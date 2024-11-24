{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_hart.pas                                                             | }
{ | command 'hart'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2       p3
  ---------------------------
  hart con? $TXARRAY $RXARRAY

  $TXARRAY:
  [?]  ?

  $RXARRAY:
  [?]  ?
}

// COMMAND 'HART'
function cmd_hart(p1, p2, p3: string): byte;
var
  i1: integer; // parameters other type
  txdata: string = '';
  rxdata: string = '';
  s: string;
  s1: string; // parameters in other type
begin
  result := 0;
  // CHECK ALL PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1nd parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X} writeln(ERR01); {$ELSE}  Form1.Memo1.Lines.Add(ERR01); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if not boolisitvariablearray(p2) then
  begin
    // No such variable array!
    {$IFNDEF X} writeln(ERR55 + p2); {$ELSE} Form1.Memo1.Lines.Add(ERR55 + p2); {$ENDIF}
    result := 1;
    exit;
  end else
    if length(arrays[intisitvariablearray(p2)].aitems) < 4
      then setlength(arrays[intisitvariablearray(p2)].aitems, 4);
  // CHECK P3 PARAMETER
  if not boolisitvariablearray(p3) then
  begin
    // No such variable array!
    {$IFNDEF X} writeln(ERR55 + p3); {$ELSE} Form1.Memo1.Lines.Add(ERR55 + p3); {$ENDIF}
    result := 1;
    exit;
  end else
    if length(arrays[intisitvariablearray(p3)].aitems) < 4
      then setlength(arrays[intisitvariablearray(p3)].aitems, 4);
  // PRIMARY MISSION
  try
  except
    result := 1;
  end;    
end;
