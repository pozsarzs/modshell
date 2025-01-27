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
  p0    p1      p2
  -------------------------
  input $TARGET [[$]PROMPT]
  
     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
  p2 |  x  |  x  |  x  |  x  |     |     |
}

// COMMAND 'INPUT'
function cmd_input(p1, p2: string): byte;
var
  s2: string;
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
    if not boolvalidvariablearraycell(p1) then result := 1;
  if result = 1 then
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
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
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
  end;
  // PRIMARY MISSION
  {$IFNDEF X}
    if length(s2) > 0 then s2 := s2 + ' ' else s2 := '>';
    write(s2);
    if boolisitvariable(p1)
      then readln(vars[intisitvariable(p1)].vvalue)
      else readln(arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)]);
  {$ELSE}
    if boolisitvariable(p1)
      then vars[intisitvariable(p1)].vvalue :=
        InputBox(MSG76, s2, '')
      else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
        InputBox(MSG76, s2, '');
  {$ENDIF}
  result := 0;
end;
