{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
function cmd_goto(p1: string): byte;
var
  line: integer;
  valid: boolean = false;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    {$IFNDEF X}
      writeln(ERR05); // Parameters required!
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
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
    if not valid then
    begin
      {$IFNDEF X}
        writeln(ERR35 + p1);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR35 + p1);
      {$ENDIF}
      result := 1;
    end;
  end;
end;
