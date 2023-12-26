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
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readdinp(prot[conn[connection].prot].uid, address, count);
    1: rtu_readdinp(prot[conn[connection].prot].uid, address, count);
    2: tcp_readdinp(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read coil(s)
procedure mbreadcoil(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readcoil(prot[conn[connection].prot].uid, address, count);
    1: rtu_readcoil(prot[conn[connection].prot].uid, address, count);
    2: tcp_readcoil(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read input register(s)
procedure mbreadireg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readireg(prot[conn[connection].prot].uid, address, count);
    1: rtu_readireg(prot[conn[connection].prot].uid, address, count);
    2: tcp_readireg(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// read holding register(s)
procedure mbreadhreg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_readhreg(prot[conn[connection].prot].uid, address, count);
    1: rtu_readhreg(prot[conn[connection].prot].uid, address, count);
    2: tcp_readhreg(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// write coil(s)
procedure mbwritecoil(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_writecoil(prot[conn[connection].prot].uid, address, count);
    1: rtu_writecoil(prot[conn[connection].prot].uid, address, count);
    2: tcp_writecoil(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;

// write holding register(s)
procedure mbwritehreg(connection, address, count: integer);
begin
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // init serial port
  if prot[conn[connection].prot].prottype < 2 then
    if not serialinit(dev[conn[connection].dev].device,
                      dev[conn[connection].dev].speed,
                      dev[conn[connection].dev].databit,
                      dev[conn[connection].dev].stopbit) then
    begin
      writeln(ERR18);
      exit;
    end;
  // call next procedure
  case prot[conn[connection].prot].prottype of
    0: asc_writehreg(prot[conn[connection].prot].uid, address, count);
    1: rtu_writehreg(prot[conn[connection].prot].uid, address, count);
    2: tcp_writehreg(prot[conn[connection].prot].ipaddress, address, count);
  end; 
end;
