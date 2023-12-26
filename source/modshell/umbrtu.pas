{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | umbrtu.pas                                                               | }
{ | Modbus/RTU protocol procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit umbrtu;
interface
uses
  userial;

procedure rtu_readdinp(uid, address, count: integer);
procedure rtu_readcoil(uid, address, count: integer);
procedure rtu_readireg(uid, address, count: integer);
procedure rtu_readhreg(uid, address, count: integer);
procedure rtu_writecoil(uid, address, count: integer);
procedure rtu_writehreg(uid, address, count: integer);

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
procedure rtu_readdinp(uid, address, count: integer);
begin
end;

// read remote coil
procedure rtu_readcoil(uid, address, count: integer);
begin
end;

// read remote input register
procedure rtu_readireg(uid, address, count: integer);
begin
end;

// read remote holding register
procedure rtu_readhreg(uid, address, count: integer);
begin
end;

// write remote coil
procedure rtu_writecoil(uid, address, count: integer);
begin
end;

// write remote holding register
procedure rtu_writehreg(uid, address, count: integer);
begin
end;

end.
