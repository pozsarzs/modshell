{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_carr.pas                                                             | }
{ | command 'carr'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2
  ----------------
  carr
  carr NAME
  carr NAME SIZE
}

// CLEAR ALL CONSTANT ARRAYS
procedure clearallconstantarrays;
var
  i: integer;
begin
  for i := 0 to ARRBUFFSIZE - 1 do
    if arrays[i].areadonly = true then
    begin
      arrays[i].aname := '';
      setlength(arrays[i].aitems, 0);
      arrays[i].amonitored := false;
    end;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS NUMBER
function intisitconstantarray(s: string): integer;
var
  i: integer;
begin
  result := 0;  
  if (s[1] = #36) then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := i;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS TRUE
function boolisitconstantarray(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := true;
end;

// IF IT IS A CONSTANT ARRAY, RETURNS ITS VALUE
function isitconstantarray(s: string): string;
var
  i, idx: integer;
begin
  result := '';
  idx := arrayindex(s);
  if (s[1] = #36) then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := stringreplace(arrays[i].aitems[idx], #92 + #32 , #32, [rfReplaceAll]);
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS ELEMENT NUMBER
function intisitconstantarrayelement(s: string): integer;
var
  i, idx: integer;
begin
  result := 0;
  idx := arrayindex(s);
  if (s[1] = #36) then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := idx;
end;

// COMMAND 'carr'
function cmd_carr(p1, p2: string): byte;
var
  b, bb: byte;
  l: byte;
  {$IFNDEF X} line: integer; {$ENDIF}
  {$IFDEF X} s: string; {$ENDIF}
  s1, s2: string; // parameters in other type
  valid: boolean = true;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    {$IFNDEF X} line := 0; {$ENDIF}
    for l := 0 to ARRBUFFSIZE - 1 do
      if (length(arrays[l].aname) > 0) and arrays[l].areadonly then
      begin
        {$IFNDEF X}
          xywrite(2, wherey, false, '$' + arrays[l].aname);
          xywrite(20, wherey, false, '[0..' + inttostr(length(arrays[l].aitems)) + ']');
          writeln;
          inc(line);
          if line >= (termheight - 4) then
          begin
            write(MSG23); readkey;
            write(#13); clreol;
            writeln;
            line := 0;
          end;
        {$ELSE}
          s := '$' + arrays[l].aname;
          for b := 1 to 28 - length(s) do s := s + ' ';
          Form1.Memo1.Lines.Add(s);
        {$ENDIF}
      end;        
    exit;
  end;
  // SEARCH ILLEGAL CHARACTERS IN P1
  s1 := p1;
  for b := 1 to length(s1) do
  begin
    for bb := 0 to 44 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 46 to 47 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 58 to 64 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 91 to 94 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 96 to 96 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 123 to 255 do
      if s1[b] = chr(bb) then valid := false;
  end;
  if not valid then
    // Illegal character in the variable name!
    {$IFNDEF X} writeln(ERR15) {$ELSE} Form1.Memo1.Lines.Add(ERR15) {$ENDIF} else
  begin
    // COMPARING EXISTING NAMES WITH THE NEW ONE
    valid := true;
    for l := 0 to ARRBUFFSIZE - 1 do
      if arrays[l].aname = lowercase(p1) then valid := false;
    for l := 0 to VARBUFFSIZE - 1 do
      if vars[l].vname = lowercase(p1) then valid := false;
    if not valid then
    begin
      // There is already a variable or a constant with that name.
      {$IFNDEF X} writeln(ERR17); {$ELSE} Form1.Memo1.Lines.Add(ERR17); {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK EMPTY SPACE IN VARIABLE TABLE
    valid := false;
    for l := 0 to ARRBUFFSIZE - 1 do
      if length(arrays[l].aname) = 0 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // Cannot define more variable array!
      {$IFNDEF X} writeln(ERR53); {$ELSE} Form1.Memo1.Lines.Add(ERR53); {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
    begin
      if boolisitconstant(p2) then s2 := isitconstant(p2);
      if boolisitvariable(p2) then s2 := isitvariable(p2);
      if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
      if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
      if length(s2) = 0 then s2 := p2;
    end;
    // PRIMARY MISSION
    with arrays[l] do
    begin
      aname := lowercase(s1);
      areadonly := true;
      amonitored := false;
    end;
    setlength(arrays[l].aitems, strtointdef(s2, 0));
  end;
end;
