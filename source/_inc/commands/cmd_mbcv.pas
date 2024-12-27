{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mbcv.pas                                                             | }
{ | command 'mbconv'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1
  --------------
  mbconv $TARGET_REGISTER_TYPE $TARGET_ADDRESS [$]REGISTER_NUMBER
  mbconv $TARGET_NUMBER [$]REGISTER_TYPE [$]ADDRESS
}

// COMMAND 'MBCONV'
function cmd_mbconv(p1, p2, p3: string): byte;
begin
  result := 0;
end;
