{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_copy.pas                                                             | }
{ | command 'copy'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2        p3   p4   p5      p6
  -------------------------------------------
  copy con? di|coil   con? coil ADDRESS COUNT
  copy con? ireg|hreg con? hreg ADDRESS COUNT
}

// command 'copy'
procedure cmd_copy(p1, p2, p3, p4, p5, p6: string);
begin
end;
