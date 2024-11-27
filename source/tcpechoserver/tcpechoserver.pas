{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | tcpechoserver.pas                                                        | }
{ | TCP echo server utility                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$IFDEF GO32V2}{$ERROR "Cannot compile on this system." }{$ENDIF}

{$MODE OBJFPC}{$H+}{$MACRO ON}
program tcpechoserver;
uses
  BlckSock,
  SysUtils,
  crt;
var
  Socket1, Socket2: TTCPBlockSocket;
  c: char;
  port: string = '';
  s: string;

{$R *.res}

begin
  writeln;
  writeln('ModShell * TCP Echo Server utility');
  writeln('----------------------------------');
  writeln('Press [ESC] to exit.');
  if paramcount = 0 then
  begin
    write('port: ?');
    repeat
      c := readkey;
      if (ord(c) >= 48) and (ord(c) <= 57) and
         (strtoint(port + c) <= 65535) then port := port + c;
      if (c = #8) and (length(port) > 0) then delete(port,length(port), 1);
      gotoxy(1, wherey); clreol;
      write('port: ' + port);
    until ((length(port) > 0) and (c = #13)) or (c = #27);
    if c = #27 then halt(0);
  end else port := paramstr(1);
  if (strtointdef(port, -1) >= 0) and (strtointdef(port, -1) <= 65535) then
  begin
    gotoxy(1, wherey); clreol;
    writeln('port: ' + port);
    Socket1 := TTCPBlockSocket.Create;
    Socket1.Bind('0.0.0.0', port);
    if Socket1.LastError <> 0 then
    begin
      writeln('ERROR: ', Socket1.LastErrorDesc);
      halt(2);
    end;    
    Socket1.Listen;
    writeln('Server running...');
    repeat
      if Socket1.CanRead(100) then
      begin
        Socket2 := TTCPBlockSocket.Create;
        Socket2.Socket := Socket1.Accept;
        s := Socket2.RecvPacket(1000);
        if length(s) > 0 then
          if Socket1.LastError = 0 then
          begin
            Socket2.SendString(s);
            writeln('message: "' + s + '"');
          end;
        Socket2.CloseSocket;
        Socket2.Free;
        delay(100);
      end;
      if keypressed then c := readkey;
    until c = #27;
    Socket1.CloseSocket;
    Socket1.Free;
    writeln('Server stopped.');
    halt(0);
  end else
  begin
    writeln('Usage: ' + ExtractFileName(paramstr(0)) + ' [port]');
    writeln('The port value must be between 0-65535.');
    halt(1);
  end;
end.
