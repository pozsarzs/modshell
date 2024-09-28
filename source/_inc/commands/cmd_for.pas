{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_for.pas                                                              | }
{ | command 'for'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1        p2        p3 p4        p5 p6
  -----------------------------------------------
  for $VARIABLE [$]VALUE1 to [$]VALUE2 do COMMAND  
}

// COMMAND 'FOR'
function cmd_for(p1, p2, p3, p4, p5, p6: string): byte;
var
  i, i2, i4: integer; // parameters in other type
  s2, s4: string; // parameters in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) or (length(p6) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    // No such variable!
    {$IFNDEF X} writeln(ERR19 + p1); {$ELSE} Form1.Memo1.Lines.Add(ERR19 + p1); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  i2 := strtointdef(s2, -1);
  if (i2 < 0) or (i2 > 65535) then
  begin
    // What is the 2nd parameter?
    {$IFNDEF X} writeln(NUM2 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 0-65535'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if lowercase(p3) <> 'to' then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X} writeln(NUM3 + MSG05+'  to'); {$ELSE} Form1.Memo1.Lines.Add(NUM3 + MSG05+'  to'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if length(s4) = 0 then s4 := p4;
  i4 := strtointdef(s4, -1);
  if (i4 < 0) or (i4 > 65535) then
  begin
    // What is the 4th parameter?
    {$IFNDEF X} writeln(NUM4 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-65535'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P5 PARAMETER
  if lowercase(p5) <> 'do' then
  begin
    // What is the 5th parameter?
    {$IFNDEF X} writeln(NUM5 + MSG05+'  do'); {$ELSE}  Form1.Memo1.Lines.Add(NUM5 + MSG05+'  do'); {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  p6 := stringreplace(p6, 'for ' + p1 + ' ' + p2 + ' ' + p3 + ' ' + p4 + ' ' + p5 + ' ', '', [rfReplaceAll]);
  for i := i2 to i4 do
  begin
    vars[intisitvariable(p1)].vvalue := inttostr(i);
    parsingcommands(p6);
  end;
end;
