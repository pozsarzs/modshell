{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_arr.pas                                                              | }
{ | array handler commands                                                   | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0       p1     p2      p3
  --------------------------------
  arrclear ARRAY
  arrcopy  TARGET SOURCE  [$]COUNT
  arrfill  ARRAY  [$]CHAR
  arrsize  ARRAY  [$]SIZE
}

// ARRAY HANDLER COMMANDS
function cmd_arr(op: byte; p1, p2, p3: string): byte;
begin
end;
