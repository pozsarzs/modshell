{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | mbtcp.pas                                                                | }
{ | Modbus/TCP protocol procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}


// READ REMOTE DISCRETE INPUT
procedure mbtcp_readdinp(protocol, device, address, count: integer);
begin
end;

// READ REMOTE COIL
procedure mbtcp_readcoil(protocol, device, address, count: integer);
begin
end;

// READ REMOTE INPUT REGISTER
procedure mbtcp_readireg(protocol, device, address, count: integer);
begin
end;

// READ REMOTE HOLDING REGISTER
procedure mbtcp_readhreg(protocol, device, address, count: integer);
begin
end;

// WRITE REMOTE COIL
procedure mbtcp_writecoil(protocol, device, address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure mbtcp_writehreg(protocol, device, address, count: integer);
begin
end;
