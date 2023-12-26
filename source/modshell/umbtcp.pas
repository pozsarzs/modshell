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

procedure tcp_readdinp(device: integer; ipaddress: string; address, count: integer);
procedure tcp_readcoil(device: integer; ipaddress: string; address, count: integer);
procedure tcp_readireg(device: integer; ipaddress: string; address, count: integer);
procedure tcp_readhreg(device: integer; ipaddress: string; address, count: integer);
procedure tcp_writecoil(device: integer; ipaddress: string; address, count: integer);
procedure tcp_writehreg(device: integer; ipaddress: string; address, count: integer);

implementation

// create Cyclic Redundancy Check (CRC) value
function crc(s: string): word;
begin
  result := 0;
end;

// check CRC of a string
function chkeckcrc(s: string; l: word): boolean;
begin
  result := true;
end;

// read remote discrete input
procedure tcp_readdinp(device: integer; ipaddress: string; address, count: integer);
begin
end;

// read remote coil
procedure tcp_readcoil(device: integer; ipaddress: string; address, count: integer);
begin
end;

// read remote input register
procedure tcp_readireg(device: integer; ipaddress: string; address, count: integer);
begin
end;

// read remote holding register
procedure tcp_readhreg(device: integer; ipaddress: string; address, count: integer);
begin
end;

// write remote coil
procedure tcp_writecoil(device: integer; ipaddress: string; address, count: integer);
begin
end;

// write remote holding register
procedure tcp_writehreg(device: integer; ipaddress: string; address, count: integer);
begin
end;

end.
