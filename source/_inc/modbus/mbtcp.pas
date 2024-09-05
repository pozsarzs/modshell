{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

// READ REMOTE COIL (FC 0x01)
procedure mbtcp_readcoil(protocol, device, address, count: word);
begin
end;

// READ REMOTE DISCRETE INPUT (FC 0x02)
procedure mbtcp_readdinp(protocol, device, address, count: word);
begin
end;

// READ REMOTE HOLDING REGISTER (FC 0x03)
procedure mbtcp_readhreg(protocol, device, address, count: word);
begin
end;

// READ REMOTE INPUT REGISTER (FC 0x04)
procedure mbtcp_readireg(protocol, device, address, count: word);
begin
end;

// WRITE REMOTE COIL (FC 0x0F)
procedure mbtcp_writecoil(protocol, device, address, count: word);
begin
end;

// WRITE REMOTE HOLDING REGISTER (FC 0x10)
procedure mbtcp_writehreg(protocol, device, address, count: word);
begin
end;

// RUN GATEWAY OR SLAVE
function mbtcp_server(enablegw: boolean; protocol1, device1, protocol2, device2: word): boolean;
begin
  result := false;
end;
