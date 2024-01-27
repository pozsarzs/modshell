{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_for.pas                                                              | }
{ | command 'for'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1        p2        p3 p4        p5 p6
  -----------------------------------------------
  for $VARIABLE [$]VALUE1 to [$]VALUE2 do COMMAND  
}

// COMMAND 'FOR'
procedure cmd_for(p1, p2, p3, p4, p5, p6: string);
begin
end;
