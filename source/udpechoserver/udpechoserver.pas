{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | udpechoserver.pas                                                        | }
{ | UDP echo server utility                                                  | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$IFDEF GO32V2} {$ERROR "Cannot compile on this system." } {$ENDIF}
{$IFDEF WINDOWS} {$APPTYPE CONSOLE} {$ENDIF}
{$MODE OBJFPC} {$H+} {$MACRO ON}

program udpechoserver;
uses
  BlckSock,
  SysUtils,
  crt,
  ucommon,
  utranslt;
var
  Socket1: TUDPBlockSocket;
  appmode: byte;
  b: byte;
  c: char;
  lang: string;
  port: string = '';
  s: string;
const
  // COMMAND LINE ARGUMENTS
  CMDLINEPARAMS: array[0..1, 0..2] of string =
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information')
  );
  // OTHERS
  PRGCOPYRIGHT = '(C) 2024 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'UDPEchoServer';
  PRGVERSION = '0.1';

{$DEFINE BASENAME := lowercase(PRGNAME)}

{$R *.res}

resourcestring
  // messages
  MSG02 = 'UDP Echo Server utility';
  MSG03 = 'port: ';
  MSG04 = 'Press [ESC] to exit.';
  MSG05 = 'Server running...';
  MSG06 = 'message: ';
  MSG07 = 'Server stopped.';
  MSG94 = 'Build date:  ';
  MSG95 = 'Builder:     ';
  MSG96 = 'FPC version: ';
  MSG97 = 'Target OS:   ';
  MSG98 = 'Target CPU:  ';
  // error messages
  ERR01 = 'ERROR: ';
  ERR02 = 'The port value must be between 0-65535.';

// SHOW USEABLE ARGUMENTS
procedure help(mode: boolean);
var
  b: byte;
begin
  if mode
    then writeln('There are one or more bad argument in command line.') else
    begin
      writeln('Usage: ' + BASENAME + ' [port]');
      writeln('       ' + BASENAME + ' [argument]');
      writeln;
      writeln('arguments:');
      for b := 0 to 1 do
      begin
        write('  ',CMDLINEPARAMS[b, 0]);
        gotoxy(8, wherey); write(CMDLINEPARAMS[b, 1]);
        gotoxy(30, wherey); writeln(CMDLINEPARAMS[b, 2]);
      end;
      writeln;
      end;
  quit(0, false, '');
end;

{$I version.pas}

begin
  // detect language
  lang := getlang;
  translatemessages(LANG, BASENAME, '.mo');
  // command line arguments
  appmode := 0;
  { appmode #0: normal run
    appmode #1: show useable arguments
    appmode #2: show version and build information }
  if length(paramstr(1)) <> 0 then
  begin
    for b := 0 to 1 do
    begin
      if paramstr(1) = CMDLINEPARAMS[b, 0] then appmode := b + 1;
      if paramstr(1) = CMDLINEPARAMS[b, 1] then appmode := b + 1;
    end;
    case appmode of
      1: help(false);
      2: version(true);
    end;
  end;
  writeln(PRGNAME + ' v' + PRGVERSION + ' * ' + MSG02);
  writeln(PRGCOPYRIGHT);
  writeln;
  writeln(MSG04);
  // port number
  if paramcount = 0 then
  begin
    write(MSG03 + '?');
    repeat
      c := readkey;
      if (ord(c) >= 48) and (ord(c) <= 57) and
         (strtoint(port + c) <= 65535) then port := port + c;
      if (c = #8) and (length(port) > 0) then delete(port,length(port), 1);
      gotoxy(1, wherey); clreol;
      write(MSG03 + port);
    until ((length(port) > 0) and (c = #13)) or (c = #27);
    if c = #27 then quit(0, false, #13);
  end else port := paramstr(1);
  writeln;
  // check port number
  if not ((strtointdef(port, -1) >= 0) and (strtointdef(port, -1) <= 65535))
    then quit(1, false, ERR01 + ERR02);
  // PRIMARY MISSION
  gotoxy(1, wherey); clreol;
  writeln(MSG03 + port);
  Socket1 := TUDPBlockSocket.Create;
  Socket1.Bind('0.0.0.0', port);
  if Socket1.LastError <> 0 then quit(2, false, ERR01 + Socket1.LastErrorDesc);
  Socket1.Listen;
  writeln(MSG05);
  repeat
    if Socket1.CanRead(100) then
    begin
      s := Socket1.RecvPacket(1000);
      if length(s) > 0 then
        if Socket1.LastError = 0 then
        begin
          Socket1.SendString(s);
          writeln(MSG06 + '"' + s + '"');
        end;
    end;
    if keypressed then c := readkey;
  until c = #27;
  Socket1.CloseSocket;
  Socket1.Free;
  writeln(MSG07);
  quit(0, false, '');
end.
