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

// READ DISCRETE INPUT(S)
procedure mb_readdinp(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_readdinp(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_readdinp(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_readdinp(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// READ COIL(S)
procedure mb_readcoil(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_readcoil(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_readcoil(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_readcoil(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// READ INPUT REGISTER(S)
procedure mb_readireg(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_readireg(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_readireg(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_readireg(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// READ HOLDING REGISTER(S)
procedure mb_readhreg(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_readhreg(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_readhreg(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_readhreg(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// WRITE COIL(S)
procedure mb_writecoil(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_writecoil(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_writecoil(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_writecoil(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// WRITE HOLDING REGISTER(S)
procedure mb_writehreg(connection, address, count: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_writehreg(conn[connection].prot, conn[connection].dev, address, count);
    1: mbrtu_writehreg(conn[connection].prot, conn[connection].dev, address, count);
    2: mbtcp_writehreg(conn[connection].prot, conn[connection].dev, address, count);
  end;
end;

// RUN GATEWAY
procedure mb_gateway(connection1, connection2: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection1) then exit;
  if not validity(1, conn[connection1].prot) then exit;
  if not validity(0, conn[connection1].dev) then exit;
  if not validity(2, connection2) then exit;
  if not validity(1, conn[connection2].prot) then exit;
  if not validity(0, conn[connection2].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection1].prot].prottype of
    0: mbasc_slave(true, conn[connection1].prot, conn[connection1].dev, conn[connection2].prot, conn[connection2].dev);
    1: mbrtu_slave(true, conn[connection1].prot, conn[connection1].dev, conn[connection2].prot, conn[connection2].dev);
    2: mbtcp_server(true, conn[connection1].prot, conn[connection1].dev, conn[connection2].prot, conn[connection2].dev);
  end;
end;

// RUN SERVER/SLAVE
procedure mb_server(connection: integer);
begin
  // CHECK VALIDITY
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // CALL NEXT PROCEDURE
  case prot[conn[connection].prot].prottype of
    0: mbasc_slave(false, conn[connection].prot, conn[connection].dev, 0, 0);
    1: mbrtu_slave(false, conn[connection].prot, conn[connection].dev, 0, 0);
    2: mbtcp_server(false, conn[connection].prot, conn[connection].dev, 0, 0);
  end;
end;
