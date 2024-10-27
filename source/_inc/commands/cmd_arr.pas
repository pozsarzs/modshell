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
  p0       p1     p2
  -----------------------
  arrclear ARRAY
  arrfill  ARRAY  [$]CHAR
  arrsize  ARRAY  [$]SIZE
}

// RETURN WITH ARRAY INDEX
function arrayindex(s: string): integer;
var
  b: byte;
  idx: string = '';
begin
  for b := 0 to length(s) do
    if s[b] = '[' then break;
  for b := b + 1 to length(s) do
    if s[b] <> ']' then  idx := idx + s[b] else break;
  result := strtointdef(idx, 0);
end;

// REMOVE ARRAY INDEX WITH SQUARE BRACKETS
function removearrayindex(s: string): string;
var
  b: byte;
begin
  result := '';
  for b := 0 to length(s) do
   if s[b] <> '[' then result := result + s[b] else break;
end;

// ARRAY HANDLER COMMANDS
function cmd_arr(op: byte; p1, p2, p3: string): byte;
var
  i: integer;
  s2: string; // parameter in other format
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if length(p1) = 0 then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  if op >= 108 then
    if (length(p1) = 0) or (length(p2) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
      result := 1;
      exit;
    end;
  // CHECK P1 PARAMETER
  if (not boolisitvariablearray(p1)) or
     (not boolisitconstantarray(p1)) then
  begin
    // No such array!
    {$IFNDEF X} writeln(ERR52 + p1); {$ELSE} Form1.Memo1.Lines.Add(ERR52 + p1); {$ENDIF}
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
      109: if boolisitvariablearray(p1)
             then setlength(arrays[intisitvariablearray(p1)].aitems, strtoint(s2))
             else setlength(arrays[intisitconstantarray(p1)].aitems, strtoint(s2));
    end;
  except
    // Operating error
    {$IFNDEF X} writeln(ERR48); {$ELSE} Form1.Memo1.Lines.Add(ERR48); {$ENDIF}
    result := 1;
  end;
end;
