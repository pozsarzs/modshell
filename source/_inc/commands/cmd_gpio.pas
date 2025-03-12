{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_gpio.pas                                                             | }
{ | direct GPIO access commands                                              | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0        p1         p2
  -------------------------------
  gpioread  [$]BOOLEAN [$]PORT
  gpiowrite [$]PORT    [$]BOOLEAN

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// DIRECT GPIO ACCESS COMMANDS  
function cmd_gpio(op: byte; p1, p2: string): byte;
begin
 result := 0;
end;
