{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_arr.pas                                                              | }
{ | array handler commands                                                   | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0          p1    p2
  -------------------------
  arrclear    ARRAY
  arrfill     ARRAY [$]DATA
  getarrsize  ARRAY $TARGET
  setarrsize  ARRAY [$]SIZE

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// RETURN WITH ARRAY INDEX
function arrayindex(s: string): integer;
var
  b: byte;
  idx: string = '';
begin
  try
  for b := 1 to length(s) do
    if s[b] = '[' then break;
  for b := b + 1 to length(s) do
    if s[b] <> ']' then  idx := idx + s[b] else break;
  if boolisitconstant(idx) then idx := isitconstant(idx);
  if boolisitvariable(idx) then idx := isitvariable(idx);
  except
  end;
  result := strtointdef(idx, 0);
end;

// REMOVE ARRAY INDEX WITH SQUARE BRACKETS
function removearrayindex(s: string): string;
var
  b: byte;
begin
  result := '';
  for b := 1 to length(s) do
    if s[b] <> '[' then result := result + s[b] else break;
end;

// ARRAY HANDLER COMMANDS
function cmd_arr(op: byte; p1, p2: string): byte;
var
  b, bb: byte;
  valid: boolean;
  i: integer;
  s1,s2: string; // parameter in other format
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if length(p1) = 0 then
  begin
    // Parameter(s) required!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if op >= 108 then
    if (length(p1) = 0) or (length(p2) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR05);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR05);
      {$ENDIF}
      result := 1;
      exit;
    end;
  // SEARCH ILLEGAL CHARACTERS IN P1
  s1 := p1;
  valid := true;
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
    exit;
  end; 
  // CHECK P1 PARAMETER
  if (not boolisitvariablearray(p1)) and
     (not boolisitconstantarray(p1)) then
  begin
    // No such array!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR52 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR52 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if op >= 108 then
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
  end;
  // PRIMARY MISSION
  try
    case op of
      107: if boolisitvariablearray(p1)
             then setlength(arrays[intisitvariablearray(p1)].aitems, 0)
             else setlength(arrays[intisitconstantarray(p1)].aitems, 0);
      108: for i := 0 to length(arrays[intisitvariablearray(p1)].aitems) do
             if boolisitvariablearray(p1)
               then arrays[intisitvariablearray(p1)].aitems[i] := p2
               else
                 if length(arrays[intisitconstantarray(p1)].aitems[i]) = 0
                   then arrays[intisitconstantarray(p1)].aitems[i] := p2;
      109: if boolisitvariablearray(p1) then
           begin
             if boolisitvariable(p2) then
               vars[intisitvariable(p2)].vvalue := inttostr(length(arrays[intisitvariablearray(p1)].aitems));
             if boolisitvariablearray(p2) then
               arrays[intisitvariablearray(p2)].aitems[intisitvariablearrayelement(p1)] := inttostr(length(arrays[intisitvariablearray(p1)].aitems));
           end;
      110: if boolisitvariablearray(p1)
             then setlength(arrays[intisitvariablearray(p1)].aitems, strtoint(s2))
             else setlength(arrays[intisitconstantarray(p1)].aitems, strtoint(s2));
    end;
  except
    // Operating error
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR48);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR48);
    {$ENDIF}
    result := 1;
  end;
end;
