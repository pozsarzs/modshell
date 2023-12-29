{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_logc.pas                                                             | }
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
  and $TARGET [$]VALUE1 [$]VALUE2
  or  $TARGET [$]VALUE1 [$]VALUE2
  not $TARGET [$]VALUE
  xor $TARGET [$]VALUE1 [$]VALUE2
  shl $TARGET [$]VALUE1 [$]VALUE2
  shr $TARGET [$]VALUE1 [$]VALUE2
}

// LOGICAL OPERATIONS
procedure cmd_logic(op: byte; p1, p2, p3: string);
begin
end;
