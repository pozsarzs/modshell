{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | umbtcp.pas                                                               | }
{ | Modbus/TCP protocol procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit umbtcp;
interface
uses
  uether;

procedure tcp_readdinp(ipaddress: string; address, count: integer);
procedure tcp_readcoil(ipaddress: string; address, count: integer);
procedure tcp_readireg(ipaddress: string; address, count: integer);
procedure tcp_readhreg(ipaddress: string; address, count: integer);
procedure tcp_writecoil(ipaddress: string; address, count: integer);
procedure tcp_writehreg(ipaddress: string; address, count: integer);

implementation

// CREATE CYCLIC REDUNDANCY CHECK (CRC) VALUE
function crc(s: string): word;
begin
  result := 0;
end;

// CHECK CRC OF A STRING
function chkeckcrc(s: string; l: word): boolean;
begin
  result := true;
end;

// READ REMOTE DISCRETE INPUT
procedure tcp_readdinp(ipaddress: string; address, count: integer);
begin
end;

// READ REMOTE COIL
procedure tcp_readcoil(ipaddress: string; address, count: integer);
begin
end;

// READ REMOTE INPUT REGISTER
procedure tcp_readireg(ipaddress: string; address, count: integer);
begin
end;

// READ REMOTE HOLDING REGISTER
procedure tcp_readhreg(ipaddress: string; address, count: integer);
begin
end;

// WRITE REMOTE COIL
procedure tcp_writecoil(ipaddress: string; address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure tcp_writehreg(ipaddress: string; address, count: integer);
begin
end;

end.
