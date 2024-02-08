{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | mbrtu.pas                                                                | }
{ | Modbus/RTU protocol procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// READ REMOTE COIL (FC 0x01)
procedure mbrtu_readcoil(protocol, device, address, count: word);
var
  b, bb: byte;
  c: char;
  pdu, adu, tgm: string;
  recvbyte, recvcount: byte;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $01;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count));
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        case ord(tgm[2]) of
          FUNCTION_CODE: begin
                           recvcount := ord(tgm[3]); // bytes
                           b := 0;
                           repeat
                             recvbyte := ord(tgm[4 + b]);
                             for bb := 0 to 7 do
                               coil[address + bb + b * 8 ] := inttobool(recvbyte and powerof2(bb));
                             b := b + 1;
                           until b = recvcount;
                         end;
          FUNCTERR_CODE: case ord(tgm[3]) of
                           1: writeln(ERR29);
                           2: writeln(ERR30);
                           3: writeln(ERR31);
                           4: writeln(ERR32);
                         end;
        end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;  
  end else writeln(ERR18, dev[device].device);
end;

// READ REMOTE DISCRETE INPUT (FC 0x02)
procedure mbrtu_readdinp(protocol, device, address, count: word);
var
  b, bb: byte;
  c: char;
  pdu, adu, tgm: string;
  recvbyte, recvcount: byte;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $02;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count));
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        case ord(tgm[2]) of
          FUNCTION_CODE: begin
                           recvcount := ord(tgm[3]); // bytes
                           b := 0;
                           repeat
                             recvbyte := ord(tgm[4 + b]);
                             for bb := 0 to 7 do
                               dinp[address + bb + b * 8 ] := inttobool(recvbyte and powerof2(bb));
                             b := b + 1;
                           until b = recvcount;
                         end;
          FUNCTERR_CODE: case ord(tgm[3]) of
                           1: writeln(ERR29);
                           2: writeln(ERR30);
                           3: writeln(ERR31);
                           4: writeln(ERR32);
                         end;
        end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;  
  end else writeln(ERR18, dev[device].device);
end;

// READ REMOTE HOLDING REGISTER (FC 0x03)
procedure mbrtu_readhreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $03;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count));
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        case ord(tgm[2]) of
          FUNCTION_CODE: begin
                           recvcount := ord(tgm[3]) div 2; // words
                           b := 0;
                           repeat
                             hreg[address + b] := ord(tgm[4 + 2 * b ]) * 256 + ord(tgm[5 + 2 * b]);
                             b := b + 1;
                           until b = recvcount;
                         end;
          FUNCTERR_CODE: case ord(tgm[3]) of
                           1: writeln(ERR29);
                           2: writeln(ERR30);
                           3: writeln(ERR31);
                           4: writeln(ERR32);
                         end;
        end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;  
  end else writeln(ERR18, dev[device].device);
end;

// READ REMOTE INPUT REGISTER (FC 0x04)
procedure mbrtu_readireg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $02;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count));
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        case ord(tgm[2]) of
          FUNCTION_CODE: begin
                           recvcount := ord(tgm[3]) div 2; // words
                           b := 0;
                           repeat
                             ireg[address + b] := ord(tgm[4 + 2 * b ]) * 256 + ord(tgm[5 + 2 * b]);
                             b := b + 1;
                           until b = recvcount;
                         end;
          FUNCTERR_CODE: case ord(tgm[3]) of
                           1: writeln(ERR29);
                           2: writeln(ERR30);
                           3: writeln(ERR31);
                           4: writeln(ERR32);
                         end;
        end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;  
  end else writeln(ERR18, dev[device].device);
end;

// WRITE REMOTE COIL (FC 0x0F)
procedure mbrtu_writecoil(protocol, device, address, count: word);
var
  b, bb, x: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $0F;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count));
  if (count mod 8) > 0
  then pdu := pdu + char((count div 8) + 1)
  else pdu := pdu + char(count div 8);
  for i := address to address + count - 1 do
  begin
    x := 0;
    for bb := 0 to 7 do
      if coil[i + bb] then x := x or powerof2(bb);
    pdu := pdu + char(x);
  end;
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        if ord(tgm[2]) = FUNCTERR_CODE then
          case ord(tgm[3]) of
            1: writeln(ERR29);
            2: writeln(ERR30);
            3: writeln(ERR31);
            4: writeln(ERR32);
          end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;    
  end else writeln(ERR18, dev[device].device);
end;

// WRITE REMOTE HOLDING REGISTER (FC 0x10)
procedure mbrtu_writehreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  wait: integer = 0;
  crc: word;
const
  FUNCTION_CODE = $10;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE TELEGRAM FOR REQUEST
  pdu := char(FUNCTION_CODE) +
         char(hi(address)) +
         char(lo(address)) +
         char(hi(count)) +
         char(lo(count)) +
         char(count * 2);
  for i := address to address + count - 1 do
    pdu := pdu + char(hi(hreg[i])) + char(lo(hreg[i]));
  crc := crc16(char(prot[protocol].uid) + pdu);
  adu := char(prot[protocol].uid) +
         pdu + 
         char(lo(crc)) +
         char(hi(crc));
  tgm := adu;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // TRANSMIT REQUEST
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(tgm);
        2: begin
             for b := 1 to length(tgm) do
               write(addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // RECEIVE RESPONSE
    tgm := '';
    repeat
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
      begin
        delay(1);
        if wait < 65535 then inc(wait);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = DEV_TIMEOUT);
    if uconfig.echo > 0 then writeln;
    // DISCONNECT SERIAL PORT
    ser_close;
    // PARSE RESPONSE
    try
      if ord(tgm[1]) = prot[protocol].uid then
      begin
        if ord(tgm[2]) = FUNCTERR_CODE then
          case ord(tgm[3]) of
            1: writeln(ERR29);
            2: writeln(ERR30);
            3: writeln(ERR31);
            4: writeln(ERR32);
          end;
      end else writeln(ERR28);
    except
      writeln(ERR28);
    end;    
  end else writeln(ERR18, dev[device].device);
end;

// RUN GATEWAY
procedure mbrtu_gateway(protocol1, device1, protocol2, device2: word);
begin
end;

// RUN SLAVE
procedure mbrtu_slave(protocol, device: word);
begin
end;
