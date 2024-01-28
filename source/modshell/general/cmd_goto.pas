{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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
  ----------
  goto LABEL
}

// COMMAND 'GOTO'
procedure cmd_goto(p1: string);
var
  line: byte;
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // parameter required
    exit;
  end;
  scriptlabel := 0;
  if appmode <> 4 then writeln(MSG33) else
  begin
    for line := 0 to SCRBUFFSIZE - 1 do
      if length(sbuffer[line]) > 0 then
        if COMMANDS[72] + p1 = stringreplace(sbuffer[line], #32, '', [rfReplaceAll]) then
        begin
          scriptlabel := line;
          valid := true;
          break;
        end;
  if not valid then writeln(ERR35 + p1);
  end;
end;
