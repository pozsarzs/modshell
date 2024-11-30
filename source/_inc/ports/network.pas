{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | network.pas                                                              | }
{ | Network handler procedures and functions                                 | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// TRUE IF THERE IS RECEIVED DATA	
function tcp_canread: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := tcp.CanRead(100);
  {$ENDIF}
end;

// TRUE, ALL DATA HAS BEEN SENT
function tcp_canwrite: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := tcp.CanWrite(100);
  {$ENDIF}
end;

// READ CHAR FROM SOCKET
function tcp_recvbyte: byte;
begin
  {$IFDEF GO32V2}
    result := 0;
  {$ELSE}
    result := tcp.RecvByte(1000);
  {$ENDIF}
end;

// READ STRING FROM SOCKET
function tcp_recvstring: string;
begin
  {$IFDEF GO32V2}
    result := '';
  {$ELSE}
    result := tcp.RecvString(1000);
  {$ENDIF}
end;

// READ PACKET FROM SOCKET
function tcp_recvpacket: string;
begin
  {$IFDEF GO32V2}
    result := '';
  {$ELSE}
    result := tcp.RecvPacket(1000);
  {$ENDIF}
end;

// WRITE CHAR TO SOCKET
procedure tcp_sendbyte(b: byte);
begin
  {$IFDEF GO32V2}
  {$ELSE}
    tcp.SendByte(b);
  {$ENDIF}
end;

// WRITE STRING TO SOCKET
procedure tcp_sendstring(s: string);
begin
  {$IFDEF GO32V2}
  {$ELSE}
    tcp.SendString(s);
  {$ENDIF}
end;

// OPEN SOCKET
function tcp_open(ipaddress, port: string): boolean;
begin
  result := true;
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    tcp := TTCPBlockSocket.Create;
    try
      tcp.Connect(ipaddress, port);
    except
      result := false;
    end;
  {$ENDIF}
end;

// CLOSE SOCKET
procedure tcp_close;
begin
  {$IFDEF GO32V2}
  {$ELSE}
    tcp.CloseSocket;
    tcp.Free;
  {$ENDIF}
end;

// TRUE IF THERE IS RECEIVED DATA	
function udp_canread: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := udp.CanRead(100);
  {$ENDIF}
end;

// TRUE, ALL DATA HAS BEEN SENT
function udp_canwrite: boolean;
begin
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    result := udp.CanWrite(100);
  {$ENDIF}
end;

// READ CHAR FROM SOCKET
function udp_recvbyte: byte;
begin
  {$IFDEF GO32V2}
    result := 0;
  {$ELSE}
    result := udp.RecvByte(1000);
  {$ENDIF}
end;

// READ STRING FROM SOCKET
function udp_recvstring: string;
begin
  {$IFDEF GO32V2}
    result := '';
  {$ELSE}
    result := udp.RecvString(1000);
  {$ENDIF}
end;

// WRITE CHAR TO SOCKET
procedure udp_sendbyte(b: byte);
begin
  {$IFDEF GO32V2}
  {$ELSE}
    udp.SendByte(b);
  {$ENDIF}
end;

// WRITE STRING TO SOCKET
procedure udp_sendstring(s: string);
begin
  {$IFDEF GO32V2}
  {$ELSE}
    udp.SendString(s);
  {$ENDIF}
end;

// OPEN SOCKET
function udp_open(ipaddress, port: string): boolean;
begin
  result := true;
  {$IFDEF GO32V2}
    result := false;
  {$ELSE}
    udp := TUDPBlockSocket.Create;
    try
      udp.Connect(ipaddress, port);
    except
      result := false;
    end;
  {$ENDIF}
end;

// CLOSE SOCKET
procedure udp_close;
begin
  {$IFDEF GO32V2}
  {$ELSE}
    udp.CloseSocket;
    udp.Free;
  {$ENDIF}
end;
