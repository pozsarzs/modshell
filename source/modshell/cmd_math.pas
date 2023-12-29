{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_math.pas                                                             | }
{ | logical operations                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1      p2         p3
  -------------------------------
  add $TARGET [$]VALUE1 [$]VALUE2
  sub $TARGET [$]VALUE1 [$]VALUE2
  mul $TARGET [$]VALUE1 [$]VALUE2
  div $TARGET [$]VALUE1 [$]VALUE2
}

// MATHEMATICAL OPERATIONS
procedure cmd_math(op: byte; p1, p2, p3: string);
begin
end;
