{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_inpt.pas                                                             | }
{ | command 'input'                                                          | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0    p1
  -------------
  input $TARGET
  
     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
}

// COMMAND 'INPUT'
function cmd_input(p1: string): byte;
var
  s1: string;
begin
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
  // CHECK P1 PARAMETER
  if (not boolisitvariable(p1)) and
     (not boolisitvariablearray(p1)) then
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
  if boolisitvariablearray(p1) then
    if not boolvalidvariablearraycell(p1) then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p1);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p1);
      {$ENDIF}
      result := 1;
      exit;
    end;
  // PRIMARY MISSION
//  if boolisitvariable(p1)
//    then vars[intisitvariable(p1)].vvalue := s
//    else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := s;
end;
