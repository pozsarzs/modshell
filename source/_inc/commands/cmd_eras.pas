{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_eras.pas                                                             | }
{ | command 'erasescr'                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0
  --------
  erasescr
}

// COMMAND 'ERASESCR'
function cmd_erasescr: byte;
var
  line: integer;
begin
  result := 0;
  // PRIMARY MISSION
  for line := 0 to SCRBUFFSIZE - 1 do sbuffer[line] := '';
  scriptisloaded := false;
end;
