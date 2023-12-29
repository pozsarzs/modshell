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
procedure rtu_readdinp(uid, address, count: integer);
begin
end;

// READ REMOTE COIL
procedure rtu_readcoil(uid, address, count: integer);
begin
end;

// READ REMOTE INPUT REGISTER
procedure rtu_readireg(uid, address, count: integer);
begin
end;

// READ REMOTE HOLDING REGISTER
procedure rtu_readhreg(uid, address, count: integer);
begin
end;

// WRITE REMOTE COIL
procedure rtu_writecoil(uid, address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure rtu_writehreg(uid, address, count: integer);
begin
end;

end.
