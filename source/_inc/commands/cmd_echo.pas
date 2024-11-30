{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  -------------------------
  echo [off|ascii|hex|swap]
}

// COMMAND 'ECHO'
function cmd_echo(p1: string): byte;
var
  ea: byte;
  s: string = '';
  valid: boolean;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    {$IFNDEF X}
      writeln(ECHO_ARG[echo]); {$ELSE} Form1.Memo1.Lines.Add(ECHO_ARG[echo]); {$ENDIF}
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
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for ea := 0 to 3 do s := s + ' ' + ECHO_ARG[ea];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  if ea = 3 then
  begin
    inc(echo);
    if echo = 3 then echo := 0;
  end else echo := ea;
  {$IFNDEF X}
    writeln(MSG28 + ECHO_ARG[echo]);
  {$ELSE}
    Form1.Memo1.Lines.Add(MSG28 + ECHO_ARG[echo]);
    Form1.StatusBar1.Panels[0].Text := 'Echo: ' + upcase(ECHO_ARG[echo]);
    Form3.StatusBar1.Panels[0].Text := 'Echo: ' + upcase(ECHO_ARG[echo]);
    Form4.StatusBar1.Panels[0].Text := 'Echo: ' + upcase(ECHO_ARG[echo]);
    Form5.StatusBar1.Panels[0].Text := 'Echo: ' + upcase(ECHO_ARG[echo]);
  {$ENDIF}
end;
