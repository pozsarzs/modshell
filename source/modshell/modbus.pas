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
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readdinp(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_readdinp(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_readdinp(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read coil(s)
procedure mbreadcoil(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readcoil(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_readcoil(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_readcoil(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read input register(s)
procedure mbreadireg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readireg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_readireg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_readireg(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read holding register(s)
procedure mbreadhreg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readhreg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_readhreg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_readhreg(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// write coil(s)
procedure mbwritecoil(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_writecoil(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_writecoil(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_writecoil(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// write holding register(s)
procedure mbwritehreg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_writehreg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    1: rtu_writehreg(conn[connection].dev, prot[conn[connection].prot].uid, address, count);
    2: tcp_writehreg(conn[connection].dev, prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;
