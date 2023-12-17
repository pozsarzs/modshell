{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | modbus.pas                                                               | }
{ | Modbus protocol common procedures and functions                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// read discrete input(s)
procedure mbreaddinp(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;

// read coil(s)
procedure mbreadcoil(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;

// read input register(s)
procedure mbreadireg(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;

// read holding register(s)
procedure mbreadhreg(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;

// write coil(s)
procedure mbwritecoil(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;

// write holding register(s)
procedure mbwritehreg(connection, address, count: integer);
begin
  writeln(connection, address, count);
end;
