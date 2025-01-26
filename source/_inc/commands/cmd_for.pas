{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |     |     |     |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
  p3 |     |     |     |     |     |  x  |
  p4 |  x  |  x  |  x  |  x  |  x  |     |
  p5 |     |     |     |     |     |  x  |
  p6 |     |     |     |     |  x  |     |
}

// COMMAND 'FOR'
function cmd_for(p1, p2, p3, p4, p5, p6: string): byte;
var
  i, i2, i4: integer;
  s2, s4: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) or (length(p6) = 0) then
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
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    // No such variable!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR19 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR19 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s2 := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s2 := isitvariablearray(p2)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p2);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p2);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(s2) = 0 then s2 := p2;
  i2 := strtointdef(s2, -1);
  if (i2 < 0) or (i2 > 65535) then
  begin
    // What is the 2nd parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM2 + MSG05 + ' 0-65535');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 0-65535');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if lowercase(p3) <> 'to' then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM3 + MSG05+'  to');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM3 + MSG05+'  to');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if boolisitconstantarray(p4) then
    if boolvalidconstantarraycell(p4)
      then s4 := isitconstantarray(p4)
      else result := 1;
  if boolisitvariablearray(p4) then
    if boolvalidvariablearraycell(p4)
      then s4 := isitvariablearray(p4)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p4);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p4);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(s4) = 0 then s4 := p4;
  i4 := strtointdef(s4, -1);
  if (i4 < 0) or (i4 > 65535) then
  begin
    // What is the 4th parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM4 + MSG05 + ' 0-65535');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-65535');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P5 PARAMETER
  if lowercase(p5) <> 'do' then
  begin
    // What is the 5th parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM5 + MSG05+'  do');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM5 + MSG05+'  do');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  p6 := stringreplace(p6, 'for ' + p1 + ' ' + p2 + ' ' + p3 + ' ' + p4 + ' ' +
                      p5 + ' ', '', [rfReplaceAll]);
  for i := i2 to i4 do
  begin
    vars[intisitvariable(p1)].vvalue := inttostr(i);
    parsingcommands(p6);
  end;
end;
