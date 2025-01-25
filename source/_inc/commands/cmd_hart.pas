{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
  p2 |     |     |  x  |     |     |     |
  p3 |     |     |  x  |     |     |     |

  $TXARRAY:
  [?]  ?

  $RXARRAY:
  [?]  ?
}

// COMMAND 'HART'
function cmd_hart(p1, p2, p3: string): byte;
var
  i1: integer;
  rxdata: string = '';
  s: string;
  s1: string;
  txdata: string = '';
begin
  result := 0;
  // CHECK ALL PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
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
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1nd parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4], -1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR01);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR01);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if not boolisitvariablearray(p2) then
  begin
    // No such variable array!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR55 + p2);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR55 + p2);
    {$ENDIF}
    result := 1;
    exit;
  end else
    if length(arrays[intisitvariablearray(p2)].aitems) < 4
      then setlength(arrays[intisitvariablearray(p2)].aitems, 4);
  // CHECK P3 PARAMETER
  if not boolisitvariablearray(p3) then
  begin
    // No such variable array!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR55 + p3);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR55 + p3);
    {$ENDIF}
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
