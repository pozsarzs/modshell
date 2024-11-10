{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | dcon.pas                                                                 | }
{ | DCON protocol procedures and functions                                   | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// MAKE CHECKSUM
function dc_mkchecksum(s: string): string;
var
  b: byte;
  i: integer = 0;
begin
  for b := 1 to length(s) do i := i + ord(s[b]);
  i := i mod $100;
  result := inttostr(i);
end;

// CHECK RECEIVED STRING WITH CHECKSUM
function dc_chkchecksum(s, checksum: string): boolean;
var
  b: byte;
  i: integer = 0;
begin
  for b := 1 to length(s) do i := i + ord(s[b]);
  i := i mod $100;
  if inttostr(i) = checksum then result := true else result := false;
end;

// READ AND WRITE FROM/TO A REMOTE DEVICE
function dc_readwrite(protocol, device: word; txdata: string; checksum: boolean): string;
var
  b: byte;
  c: char;
  tgm: string;
  s: string;
  wait: integer = 0;  
begin
  result := '';
  tgm := stringreplace(txdata, '__' , hex1(2, prot[protocol].id), [rfReplaceAll]);
  if checksum then tgm := tgm + dc_mkchecksum(tgm);
  tgm := tgm + CR;
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit message
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      s := '';
      case uconfig.echo of
        1: s := tgm;
        2: for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
      end;
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      if uconfig.echo > 0 then {$IFNDEF X} writeln(formattelegram(true, s)); {$ELSE} Form1.Memo1.Lines.Add(formattelegram(true, s)); {$ENDIF}
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    s := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout * 1000);
    {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
    if uconfig.echo > 0 then {$IFNDEF X} writeln(formattelegram(false, s)); {$ELSE} Form1.Memo1.Lines.Add(formattelegram(false, s)); {$ENDIF}
    {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    // disconnect serial port
    ser_close;
    result := tgm;
    // checksum check
    if checksum then
      if not dc_chkchecksum(leftstr(tgm, length(tgm) - 2), rightstr(tgm, 2)) then result := '__';
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// READ AND WRITE WITH DCON PROTOCOL
function dcon_readwrite(connection: integer; txdata: string; checksum: boolean): string;
begin
  result := '';
  // check validity
  if not validity(2, connection) then exit;
  if not validity(1, conn[connection].prot) then exit;
  if not validity(0, conn[connection].dev) then exit;
  // check device lock file
  if checklockfile(dev[conn[connection].dev].device, true) then exit;
  // call next procedure
  if prot[conn[connection].prot].prottype = 3
    then result := dc_readwrite(conn[connection].prot, conn[connection].dev, txdata, checksum)
    else {$IFNDEF X} writeln(ERR56); {$ELSE} Form1.Memo1.Lines.Add(ERR56); {$ENDIF}
end;
