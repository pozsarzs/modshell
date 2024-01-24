{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_echo.pas                                                             | }
{ | command 'echo'                                                           | }
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
  ----------------------
  echo [off|on|hex|swap]
}

// COMMAND 'ECHO'
procedure cmd_echo(p1: string);
var
  ea: byte;
  valid: boolean;
begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ECHO_ARG[echo]);
    exit;
  end;
  // CHECK P1 PARAMETER
  valid := false;
  for ea := 0 to 3 do
    if ECHO_ARG[ea] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    for ea := 0 to 3 do write(' ' + ECHO_ARG[ea]);
     writeln;
     exit;
  end;
  // PRIMARY MISSION
  if ea = 3 then
  begin
    inc(echo);
    if echo = 3 then echo := 0;
  end else echo := ea;
  writeln(MSG28 + ECHO_ARG[echo]);
end;
