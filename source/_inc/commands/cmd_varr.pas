{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_varr.pas                                                             | }
{ | command 'varr'                                                           | }
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
  varr
  varr NAME
  varr NAME SIZE

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  -  |  -  |  -  |  -  |  +  |  -  |
  p2 |  -  |  -  |  -  |  -  |  +  |  -  |
}

// CLEAR ALL VARIABLE ARRAYS
procedure clearallvariablearrays;
var
  i: integer;
begin
  for i := 0 to ARRBUFFSIZE - 1 do
    if arrays[i].areadonly = false then
    begin
      arrays[i].aname := '';
      setlength(arrays[i].aitems, 0);
      arrays[i].amonitored := false;
    end;
end;

// IF IT IS A VARIABLE ARRAY, IT RETURNS THEIRS NUMBER
function intisitvariablearray(s: string): integer;
var
  i: integer;
begin
  result := 0;  
  if (s[1] = #36) and (length(s) > 1)
    then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and not arrays[i].areadonly
      then result := i;
end;

// IF IT IS A VARIABLE ARRAY, IT RETURNS TRUE
function boolisitvariablearray(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) and (length(s) > 1)
    then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and not arrays[i].areadonly
      then result := true;
end;

// IF IT IS A VARIABLE ARRAY, RETURNS ITS VALUE
function isitvariablearray(s: string): string;
var
  i, idx: integer;
begin
  result := '';
  idx := arrayindex(s);
  if (s[1] = #36) and (length(s) > 1)
    then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and not arrays[i].areadonly
      then result := stringreplace(arrays[i].aitems[idx],
             #92 + #32 , #32, [rfReplaceAll]);
end;

// IF IT IS A VARIABLE ARRAY, IT RETURNS THEIRS ELEMENT NUMBER
function intisitvariablearrayelement(s: string): integer;
var
  i, idx: integer;
begin
  result := 0;
  idx := arrayindex(s);
  if (s[1] = #36) and (length(s) > 1)
    then s := stringreplace(s, #36 , '', [rfReplaceAll]);
  s := removearrayindex(s);
  for i := 0 to ARRBUFFSIZE - 1 do
    if (arrays[i].aname = lowercase(s)) and not arrays[i].areadonly
      then result := idx;
end;

// CHECK SPECIFIED CELL NUMBER
function boolvalidvariablearraycell(s: string): boolean;
begin
  if intisitvariablearrayelement(s) >
     (length(arrays[intisitvariablearray(s)].aitems) - 1) then
  begin
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + s);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + s);
    {$ENDIF}
    result := false
  end else result := true;
end;

// COMMAND 'varr'
function cmd_varr(p1, p2: string): byte;
var
  b, bb: byte;
  l: byte;
  {$IFNDEF X} line: integer; {$ENDIF}
  {$IFDEF X} s: string; {$ENDIF}
  s1, s2: string;
  valid: boolean = true;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    {$IFNDEF X} line := 0; {$ENDIF}
    for l := 0 to ARRBUFFSIZE - 1 do
      if (length(arrays[l].aname) > 0) and not arrays[l].areadonly then
      begin
        {$IFNDEF X}
          xywrite(2, wherey, false, '$' + arrays[l].aname);
          xywrite(20, wherey, false, '[0..' +
                  inttostr(length(arrays[l].aitems)) + ']');
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
  begin
    // Illegal character in the variable name!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR15);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR15);
    {$ENDIF}
  end else
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
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR17);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR17);
      {$ENDIF}
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
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR53);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR53);
      {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
    begin
      if boolisitconstant(p2) then s2 := isitconstant(p2);
      if boolisitvariable(p2) then s2 := isitvariable(p2);
      // No such array cell!
      if boolisitconstantarray(p2) then
        if boolvalidconstantarraycell(p2)
          then s2 := isitconstantarray(p2)
          else result := 1;
      if boolisitvariablearray(p2) then
        if boolvalidvariablearraycell(p2)
          then s2 := isitvariablearray(p2)
          else result := 1;
      if result = 1 then exit;
      if length(s2) = 0 then s2 := p2;
    end;
    // PRIMARY MISSION
    with arrays[l] do
    begin
      aname := lowercase(s1);
      areadonly := false;
      amonitored := false;
    end;
    setlength(arrays[l].aitems, strtointdef(s2, 0));
  end;
end;
