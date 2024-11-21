{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | ethernet.pas                                                             | }
{ | Ethernet handler procedures and functions                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// TRUE IF THERE IS RECEIVED DATA	
function eth_canread: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := false;
  {$ENDIF}
end;

// TRUE, ALL DATA HAS BEEN SENT
function eth_canwrite: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := false;
  {$ENDIF}
end;

// READ CHAR FROM NETWORK DEVICE
function eth_recvbyte: byte;
begin
  {$IFDEF GO32V2}
    result := 0;
  {$ELSE}
    result := 0;
  {$ENDIF}
end;

// READ STRING FROM NETWORK DEVICE
function eth_recvstring: string;
begin
  {$IFDEF GO32V2}
    result := '';
  {$ELSE}
    result := '';
  {$ENDIF}
end;

// WRITE CHAR TO NETWORK DEVICE
procedure eth_sendbyte(b: byte);
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

// WRITE STRING TO NETWORK DEVICE
procedure eth_sendstring(s: string);
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

// OPEN NETWORK DEVICE
function eth_open(device, ipaddress: string; port: integer): boolean;
begin
  result := true;
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

// CLOSE NETWORK DEVICE
procedure eth_close;
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;
