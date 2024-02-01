{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_cron.pas                                                             | }
{ | command 'cron'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1     p2   p3  p4    p5
  -------------------------------
  cron
  cron minute hour day month week
  cron [-e|-d|-r]
}

// COMMAND 'CRON'
function cmd_cron(p1, p2, p3, p4, p5: string): byte;
begin
  result := 0;
end;
