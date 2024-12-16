{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_mbmn.pas                                                             | }
{ | serial Modbus traffic monitor (same as SerialMBMonitor utility)          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1
  --------------
  mbmon   [con?]
}

// COMMAND MBMON
function TLThread.thr_mbmon(p1: byte): byte;

{$I sendmesg.pas}

begin
  result := 0;
end;
