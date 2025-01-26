{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_goto.pas                                                             | }
{ | command 'goto'                                                           | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0   p1
  -------------
  goto [$]LABEL

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'GOTO'
function cmd_goto(p1: string): byte;
var
  line: integer;
  valid: boolean = false;
  s1: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
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
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then
    if boolvalidconstantarraycell(p1)
      then s1 := isitconstantarray(p1)
      else result := 1;
  if boolisitvariablearray(p1) then
    if boolvalidvariablearraycell(p1)
      then s1 := isitvariablearray(p1)
      else result := 1;
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
  if length(s1) = 0 then s1 := p1;
  scriptlabel := 0;
  for line := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[line]) > 0 then
      if COMMANDS[72] + s1 = stringreplace(sbuffer[line], #32, '', [rfReplaceAll]) then
      begin
        scriptlabel := line;
        valid := true;
        break;
      end;
  if not valid then
  begin
    // No such label!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR35 + s1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR35 + s1);
    {$ENDIF}
    result := 1;
  end;
end;
