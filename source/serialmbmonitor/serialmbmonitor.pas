{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | serialmbmonitor.pas                                                      | }
{ | Serial Modbus traffic monitor utility                                    | }
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
program serialmbmonitor;
uses
  Synaser,
  SysUtils,
  crt,
  ucommon,
  utranslt;
var
  ser: TBlockSerial;
  appmode: byte;
  baudrate: string = '';
  b: byte;
  c: char;
  databit: string = '';
  device: string = '';
  id: string = '';
  lang: string;
  parity: string = '';
  protocol: string = '';
  s: string;
  stopbit: string = '';
  valid: boolean;
const
  // COMMAND LINE PARAMETERS
  CMDLINEPARAMS: array[0..1, 0..2] of string =
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information')
  );
  // OTHERS
  PRGCOPYRIGHT = '(C) 2024 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'SerialMBMonitor';
  PRGVERSION = '0.1';
  DEV_SPEED: array[0..10] of string = ('150','300','600','1200','2400','4800','9600','19200','38400','57600','115200');
  DEV_PARITY: array[0..2] of char = ('e','n','o');
  PROT_TYPE: array[0..1] of char = ('ascii','rtu');

{$DEFINE BASENAME := lowercase(PRGNAME)}
{$DEFINE SLASH := DirectorySeparator}
{$IFDEF UNIX}
  {$DEFINE DIR_LOCK := '/var/lock'}
{$ENDIF}

{$R *.res}

resourcestring
  // messages
  MSG01 = '[press space]';
  MSG02 = 'Serial Echo Server utility';
  MSG03 = 'device: ';
  MSG04 = 'Press [ESC] to exit.';
  MSG05 = 'Monitor running...';
  MSG06 = 'message: ';
  MSG07 = 'baudrate: ';
  MSG08 = 'databit(s): ';
  MSG09 = 'parity: ';
  MSG10 = 'stopbit(s): ';
  MSG11 = 'protocol: ';
  MSG12 = 'device ID: ';
  MSG13 = 'Monitor stopped.'
  MSG94 = 'Build date:  ';
  MSG95 = 'Builder:     ';
  MSG96 = 'FPC version: ';
  MSG97 = 'Target OS:   ';
  MSG98 = 'Target CPU:  ';
  // error messages
  ERR01 = 'ERROR: ';
  ERR02 = 'The baudrate value can only be one of the following: ';
  ERR03 = 'The databit(s) value must be 7 or 8.';
  ERR04 = 'The parity value can only be one of the following: ';
  ERR05 = 'The stopbit(s) value must be 1 or 2.';
  ERR06 = 'The protocol value can only be one of the following: ';
  ERR07 = 'The device ID value must be 1-247, (0 means all ID).';
  ERR08 = 'Cannot open this serial port: ';
  ERR43 = 'Cannot erase file!';
  ERR49 = 'Locked device: ';

// DECODE ASCII/RTU telegram

//           ID FC ADDR COUN LCRC
// REQUEST   08 01 00FF 0001 XXXX
//           ID FC BT DATA LCRC
// RESPONSE  08 01 02 0000 XXXX


function decodetelegram(mode: boolean; id: string; telegram: string): string
begin
  result := '';
  if mode then
  begin
    // Modbus/ASCII

    // parse request

{ 
    if length(tgm) >= 17 then
    begin
      sot := tgm[1];
      id := strtoint('$' + tgm[2] + tgm[3]);
      function_code := strtoint('$' + tgm[4] + tgm[5]);
      address := strtoint('$' + tgm[6] + tgm[7] + tgm[8] + tgm[9]);
      count := strtoint('$' + tgm[10] + tgm[11] + tgm[12] + tgm[13]);
      // check data
      if sot <> #58 then error := $04;
      if (address < 1) or (address > 9999) then error := $02;
      if (count < 1) or (count > 125) then error := $03;
      if (function_code = FUNCTION_CODES_ALL[4]) and (length(tgm) < 21) then error := $04;
      if (function_code = FUNCTION_CODES_ALL[5]) and (length(tgm) < 23) then error := $04;
      if (id < 1) or (id > 247) then error := 4;
      valid := false;
      for b:= 0 to 5 do
        if function_code = FUNCTION_CODES_ALL[b] then valid := true;
      if not valid then error := $01;
    end else error := $04;
}

    // parse response
    

  end else
  begin
    // Modbus/RTU
    // parse request
    // parse response
  end;




end;

// SHOW USEABLE PARAMETERS
procedure help(mode: boolean);
var
  b: byte;
begin
  if mode then
    writeln('There are one or more bad parameter in command line.') else
    begin
      writeln('Usage: ' + BASENAME + ' [device] [baudrate] [databit(s)] [parity] [stopbit(s)] [protocol] [id]');
      writeln('       ' + BASENAME + ' [parameter]');
      writeln;
      writeln('parameters:');
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
{$I lockfile.pas}

begin
  // detect language
  lang := getlang;
  translatemessages(LANG, BASENAME, '.mo');
  // command line parameters
  appmode := 0;
  { appmode #0: normal run
    appmode #1: show useable parameters
    appmode #2: show version and build information }
  if paramcount > 0 then
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
  // device
  if paramcount < 1 then
  begin
    write(MSG03 + '?');
    repeat
      c := readkey;
      if (c = #8) and (length(device) > 0) then delete(device,length(device), 1);
      if (c <> #13) and (c <> #8) then device := device + c;
      gotoxy(1, wherey); clreol;
      write(MSG03 + device);
    until ((length(device) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else device := paramstr(1);
  // baudrate
  if paramcount < 2 then
  begin
    b := 10;
    write(MSG07 + MSG01);
    repeat
      c := readkey;
      if c = #32 then
      begin
        if b < 10 then inc(b) else b := 0;
        gotoxy(1, wherey); clreol;
        baudrate := DEV_SPEED[b];
        write(MSG07 + baudrate);
      end;
    until ((length(baudrate) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else baudrate := paramstr(2);
  // number of databits
  if paramcount < 3 then
  begin
    b := 8;
    write(MSG08 + MSG01);
    repeat
      c := readkey;
      if c = #32 then
      begin
        if b < 8 then inc(b) else dec(b);
        gotoxy(1, wherey); clreol;
        databit := inttostr(b);
        write(MSG08 + databit);
      end;
    until ((length(databit) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else databit := paramstr(3);  
  // parity type
  if paramcount < 4 then
  begin
    b := 2;
    write(MSG09 + MSG01);
    repeat
      c := readkey;
      if c = #32 then
      begin
        if b < 2 then inc(b) else b := 0;
        gotoxy(1, wherey); clreol;
        parity := DEV_PARITY[b];
        write(MSG09 + parity);
      end;
    until ((length(parity) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else parity := paramstr(4);
  // number of stopbits
  if paramcount < 5 then
  begin
    b := 2;
    write(MSG10 + MSG01);
    repeat
      c := readkey;
      if c = #32 then
      begin
        if b < 2 then inc(b) else dec(b);
        gotoxy(1, wherey); clreol;
        stopbit := inttostr(b);
        write(MSG10 + stopbit);
      end;
    until ((length(stopbit) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else stopbit := paramstr(5);
  // protocol type
  if paramcount < 5 then
  begin
    b := 2;
    write(MSG11 + MSG01);
    repeat
      c := readkey;
      if c = #32 then
      begin
        if b < 1 then inc(b) else b := 0;
        gotoxy(1, wherey); clreol;
        protocol := PROT_TYPE[b];
        write(MSG11 + protocol);
      end;
    until ((length(protocol) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else protocol := paramstr(6);
  // device ID
  if paramcount < 6 then
  begin
    write(MSG12 + '?');
    repeat
      c := readkey;
      if (ord(c) >= 48) and (ord(c) <= 57) and
         (strtoint(port + c) <= 247) then port := port + c;
      if (c = #8) and (length(port) > 0) then delete(port,length(port), 1);
      gotoxy(1, wherey); clreol;
      write(MSG03 + port);
    until ((length(protocol) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else id := paramstr(6);
  writeln;
  // check baudrate
  valid := false;
  for b := 0 to 10 do
    if baudrate = DEV_SPEED[b] then valid := true;
  if not valid then
  begin
    writeln(ERR01 + ERR02);
    for b := 0 to 10 do write(DEV_SPEED[b] + ' ');
    writeln;
    quit(1, false, '');
  end;
  // check number of databits
  if not ((strtointdef(databit, -1) >= 7) and (strtointdef(databit, -1) <= 8))
    then quit(1, false, ERR01 + ERR03);
  // check parity
  valid := false;
  for b := 0 to 2 do
    if parity = DEV_PARITY[b] then valid := true;
  if not valid then
  begin
    write(ERR01 + ERR04);
    for b := 0 to 2 do write(DEV_PARITY[b] + ' ');
    writeln;
    quit(1, false, '');
  end;
  // check number of stopbits
  if not ((strtointdef(stopbit, -1) >= 1) and (strtointdef(stopbit, -1) <= 2))
    then quit(1, false, ERR01 + ERR05);
  {$IFDEF UNIX}
    // check lockfile
    if checklockfile('/dev/' + device, false)
      then quit(3, false, ERR01 + ERR49 + device);
  {$ENDIF}
  // check protocol type
  valid := false;
  for b := 0 to 1 do
    if protocol = PROT_TYPE[b] then valid := true;
  if not valid then
  begin
    write(ERR01 + ERR06);
    for b := 0 to 1 do write(PROT_TYPE[b] + ' ');
    writeln;
    quit(1, false, '');
  end;
  // check device ID
  if not ((strtointdef(stopbit, -1) >= 0) and (strtointdef(stopbit, -1) <= 247))
    then quit(1, false, ERR01 + ERR07);
  // PRIMARY MISSION
  ser := TBlockSerial.Create;
  try
    ser.Connect(device);
    ser.Config(strtoint(baudrate), strtoint(databit), parity[1], strtoint(stopbit), false, false);
  except
    quit(2, false, ERR01 + ERR08 + device);
  end;
  writeln(MSG05);
  repeat
    if keypressed then c := readkey else
    begin
      if ser.CanRead(0) then
      begin
        s := ser.RecvString(0);
        writeln(decodetelegram(protocol, id, s));
      end;    
      delay(100);
    end;
  until c = #27;
  ser.Free;  
  writeln(MSG13);
  quit(0, false, '');
end.
