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

{$DEFINE PROGTEST}

{$IFDEF GO32V2}{$ERROR "Cannot compile on this system." }{$ENDIF}
{$MODE OBJFPC}{$H+}{$MACRO ON}
program serialmbmonitor;
uses
  Synaser,
  SysUtils,
  convert,
  crt,
  ucommon,
  utranslt;
var
  {$IFNDEF PROGTEST}
    ser: TBlockSerial;
  {$ENDIF}
  appmode: byte;
  baudrate: string = '';
  b, bb: byte;
  c: char;
  databit: string = '';
  device: string = '';
  deviceid: string = '';
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
  DEV_SPEED: array[0..10] of string = ('150', '300', '600', '1200', '2400', '4800', '9600', '19200', '38400', '57600', '115200');
  DEV_PARITY: array[0..2] of char = ('e','n','o');
  PROT_TYPE: array[0..1] of string = ('ascii','rtu');
  EOL: string = #13 + #10;
  {$IFDEF PROGTEST}
    // TEST PDUs (FC + data)  
    PDU_ASCII_REQUEST: array[0..5] of string =        ('0100FF0001',
                                                       '0200FF0001',
                                                       '0300FF0001',
                                                       '0400FF0001',
                                                       '0F00FF0010020000',
                                                       '1000FF00010200000000');
    PDU_ASCII_RESPONSE: array[0..5] of string =       ('01020000',
                                                       '02020000',
                                                       '03020000',
                                                       '04020000',
                                                       '0F00FF0010',
                                                       '1000FF0001');
    PDU_ASCII_ERROR_RESPONSE: array[0..5] of string = ('810101',
                                                       '820102',
                                                       '830103',
                                                       '840104',
                                                       '8F01F1',
                                                       '9001F2');
    PDU_RTU_REQUEST: array[0..5] of string =          ('0100FF0001',
                                                       '0200FF0001',
                                                       '0300FF0001',
                                                       '0400FF0001',
                                                       '0F00FF0010020000',
                                                       '1000FF00010200000000');
    PDU_RTU_RESPONSE: array[0..5] of string =         ('01020000',
                                                       '02020000',
                                                       '03020000',
                                                       '04020000',
                                                       '0F00FF0010',
                                                       '1000FF0001');
    PDU_RTU_ERROR_RESPONSE: array[0..5] of string =   ('810101',
                                                       '820102',
                                                       '830103',
                                                       '840104',
                                                       '8F01F1',
                                                       '9001F2');                                                       
  {$ENDIF}

{$DEFINE BASENAME := lowercase(PRGNAME)}
{$DEFINE SLASH := DirectorySeparator}
{$IFDEF UNIX}
  {$DEFINE DIR_LOCK := '/var/lock'}
{$ENDIF}

{$R *.res}

resourcestring
  // messages
  MSG01 = '[press space]';
  MSG02 = 'Serial Modbus traffic monitor utility';
  MSG03 = 'device:      ';
  MSG04 = 'Press [ESC] to exit.';
  MSG05 = 'Monitor running...';
  MSG06 = 'message: ';
  MSG07 = 'baudrate:    ';
  MSG08 = 'databit(s):  ';
  MSG09 = 'parity:      ';
  MSG10 = 'stopbit(s):  ';
  MSG11 = 'protocol: ';
  MSG12 = 'device ID: ';
  MSG13 = 'Monitor stopped.';
  MSG14 = 'Serial port: ';
  MSG15 = 'Protocol:    ';
  MSG16 = 'CS test  ';
  MSG17 = '[ok]     ';
  MSG18 = '[error]  ';
  MSG19 = 'ID  FC  DATA';
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

// DECODE TELEGRAM
function decodetelegram(protocol, filter, telegram: string): string;
var
  cs: word;
  cs_ok: boolean;
  data: string = '';
  fc: string;
  i: integer;
  id: string;
  show_cscheck: boolean = false;
begin
  if protocol = PROT_TYPE[0] then
  begin
    // ASCII
    if telegram[1] = #58 then
      if telegram[length(telegram) - 1] + telegram[length(telegram)] = EOL then
      begin
        id := inttostr(strtoint('$' + telegram[2] + telegram[3]));
        if (filter = '0') or (filter = id) then
        begin
          fc := telegram[4] + telegram[5];
          for i := 6 to length(telegram) - 4 do data := data + telegram[i];
          cs := strtoint('$' + telegram[length(telegram) - 3] + telegram[length(telegram) - 2]);
          cs_ok := checklrc(telegram[2] + telegram[3] + telegram[4] + telegram[5] + data, cs);
          show_cscheck := true;
        end else data := '[...]';
      end;
  end else
  begin
    // RTU
  end;
  // split data to bytes
  b := 1;
  s := '';
  repeat
    s := s + data[b] + data[b + 1] + #32;
    b := b + 2;
  until b >= length(data);
  data := s;
  result:= addsomezero(3, id) + '  ' + fc + '  ' + data;
  // show result of the checksum check
  if show_cscheck then
    if cs_ok then result := MSG17 + result else result := MSG18 + result;
end;

{$IFDEF PROGTEST}
  // MAKE A TEST TELEGRAM
  function testtelegram(protocol: string; id, number: byte; respreq: boolean): string;
  var
    error: byte;
  begin
    error := random(150);
    if protocol = PROT_TYPE[0] then
    begin
      // ASCII:
      //   PDU = FC + data  
      //   ADU = SA + PDU + LRC(SA + PDU)  
      //   TGM = 0x3A + ADU + 0x0D + 0x0A
      if respreq
        then result := uppercase(#58 + hex1(2, id) + PDU_ASCII_REQUEST[number] +
                                 hex1(2, lrc(hex1(2, id) + PDU_ASCII_REQUEST[number])) +
                                 EOL)
        else
          if error < 130
            then result := uppercase(#58 + hex1(2, id) + PDU_ASCII_RESPONSE[number] +
                                     hex1(2, lrc(hex1(2, id) + PDU_ASCII_RESPONSE[number])) +
                                     EOL)
            else result := uppercase(#58 + hex1(2, id) + PDU_ASCII_ERROR_RESPONSE[number] +
                                     hex1(2, lrc(hex1(2, id) + PDU_ASCII_ERROR_RESPONSE[number])) +
                                     EOL);
    end else
    begin
      // RTU:
      //   PDU = FC + data  
      //   ADU = SA + PDU + CRC(SA + PDU)  
      //   TGM = ADU
    end;
  end;
{$ENDIF}

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
  // DETECT LANGUAGE
  lang := getlang;
  translatemessages(LANG, BASENAME, '.mo');
  // GET OR SET AND CHECK PARAMETERS
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

  // databits
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
  if not ((strtointdef(databit, -1) >= 7) and (strtointdef(databit, -1) <= 8))
    then quit(1, false, ERR01 + ERR03);

  // parity
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
  end else parity := lowercase(paramstr(4));
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

  // stopbits
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
  if not ((strtointdef(stopbit, -1) >= 1) and (strtointdef(stopbit, -1) <= 2))
    then quit(1, false, ERR01 + ERR05);

  // protocol
  if paramcount < 6 then
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
  end else protocol := lowercase(paramstr(6));
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

  // device ID
  if paramcount < 7 then
  begin
    write(MSG12 + '?');
    repeat
      c := readkey;
      if (ord(c) >= 48) and (ord(c) <= 57) and
         (strtoint(deviceid + c) <= 247) then deviceid := deviceid + c;
      if (c = #8) and (length(deviceid) > 0) then delete(deviceid,length(deviceid), 1);
      gotoxy(1, wherey); clreol;
      write(MSG12 + deviceid);
    until ((length(protocol) > 0) and (c = #13)) or (c = #27);
    writeln;
    if c = #27 then halt(0);
  end else deviceid := paramstr(7);
  if not ((strtointdef(deviceid, -1) >= 0) and (strtointdef(deviceid, -1) <= 247))
    then quit(1, false, ERR01 + ERR07);

  writeln;
  writeln(MSG14 + device + ' ' + baudrate + ' ' + databit + uppercase(parity) + stopbit);
  writeln(MSG15 +  uppercase(protocol) + ' #' + deviceid);
  writeln;
  writeln(MSG04);
  {$IFDEF UNIX}
    // check lockfile
    if checklockfile('/dev/' + device, false)
      then quit(3, false, ERR01 + ERR49 + device);
  {$ENDIF}
  // PRIMARY MISSION
  {$IFNDEF PROGTEST}
    ser := TBlockSerial.Create;
    try
      ser.Connect(device);
      ser.Config(strtoint(baudrate), strtoint(databit), parity[1], strtoint(stopbit), false, false);
    except
      quit(2, false, ERR01 + ERR08 + device);
    end;
  {$ENDIF}
  writeln(MSG05);
  writeln;
  writeln(MSG16 + MSG19);
  repeat
    if keypressed then c := readkey else
    begin
      {$IFNDEF PROGTEST}
        if ser.CanRead(0) then
        begin
          s := ser.RecvString(0);
          writeln(decodetelegram(protocol, deviceid, s));
        end;    
        delay(100);
      {$ELSE}
        b := random(5);
        bb := random(246) + 1;
        // test request
        writeln(decodetelegram(protocol, deviceid, testtelegram(protocol, bb, b, true)));
        // test response
        writeln(decodetelegram(protocol, deviceid, testtelegram(protocol, bb, b, false)));
        delay(500);
      {$ENDIF}
    end;
  until c = #27;
  {$IFNDEF PROGTEST}
    ser.Free;
  {$ENDIF}
  writeln(MSG13);
  quit(0, false, '');
end.
