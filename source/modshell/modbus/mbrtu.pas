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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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
      delay(10);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
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

// RUN GATEWAY OR SLAVE
function mbrtu_slave(enablegw: boolean; protocol1, device1, protocol2, device2: word): boolean;
var
  address: integer;
  adu, pdu, tgm: string;
  b, bb, x: byte;
  c: char;
  count: integer;
  crc: word;
  error: byte = 0;
  function_code: byte;
  i: integer;
  loop: boolean = true;
  ready: boolean = false;
  recvbyte: byte;
  uid: byte;
  valid: boolean = true;
const
  FUNCTION_CODES_ALL: array[0..5] of byte = ($01, $02, $03, $04, $0F, $10);
  FUNCTERR_CODE_OFFSET = $80;

begin
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device1].device, dev[device1].speed, dev[device1].databit, dev[device1].parity, dev[device1].stopbit) then
  begin
    // WAIT FOR REQUEST
    repeat
      if keypressed then
      begin
        c := readkey;
        if c = #27 then loop := false;
      end else delay(10);
    until ser_canread or (c = #27);
    if loop then
    begin
      // RECEIVE REQUEST
      tgm := '';
      repeat
        delay(10);
        if ser_canread then
        begin
          b := ser_recvbyte;
          textcolor(uconfig.colors[2]);
          case uconfig.echo of
            1: write(char(b));
            2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
          end;
          textcolor(uconfig.colors[0]);
          tgm := tgm + char(b);
        end else ready := true;
        if keypressed then c := readkey;
        if c = #27 then loop := false;
      until (c = #27) or (length(tgm) = 255) or ready;
      if uconfig.echo > 0 then writeln;
      // PARSE REQUEST
      if length(tgm) >= 8 then
      begin
        uid := ord(tgm[1]);
        function_code := ord(tgm[2]);
        address := ord(tgm[3]) * 256 + ord(tgm[4]) ;
        count := ord(tgm[5]) * 256 + ord(tgm[6]) ;
        // check data
        if (address < 1) or (address > 9999) then error := $02;
        if (count < 1) or (count > 125) then error := $03;
        if (function_code = FUNCTION_CODES_ALL[4]) and (length(tgm) < 10) then error := $04;
        if (function_code = FUNCTION_CODES_ALL[5]) and (length(tgm) < 11) then error := $04;
        if (uid < 1) or (uid > 247) then error := 4;
        valid := false;
        for b:= 0 to 5 do
          if function_code = FUNCTION_CODES_ALL[b] then valid := true;
        if not valid then error := $01;
      end else error := $04;
    end;
    ser_close;
  end else writeln(ERR18, dev[device1].device);
  // GATEWAY
  if loop and enablegw then
  begin
    if function_code = FUNCTION_CODES_ALL[0] then mbrtu_readcoil(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[1] then mbrtu_readdinp(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[2] then mbrtu_readhreg(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[3] then mbrtu_readireg(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[4] then mbrtu_writecoil(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[5] then mbrtu_writehreg(protocol2, device2, address, count);
  end;
  // CONNECT TO SERIAL PORT
  if ser_open(dev[device1].device, dev[device1].speed, dev[device1].databit, dev[device1].parity, dev[device1].stopbit) then
  begin
    if loop then
    begin
      // CREATE TELEGRAM FOR RESPONSE
      if uid = prot[protocol1].uid then
      begin
        if error > 0 then pdu := char(FUNCTERR_CODE_OFFSET + error) else
        begin
          pdu := char(function_code);
          // read coil
          if function_code = FUNCTION_CODES_ALL[0] then
          begin
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
          end;
          // read discrete input
          if function_code = FUNCTION_CODES_ALL[1] then
          begin
            if (count mod 8) > 0
              then pdu := pdu + char((count div 8) + 1)
              else pdu := pdu + char(count div 8);
            for i := address to address + count - 1 do
            begin
              x := 0;
              for bb := 0 to 7 do
                if dinp[i + bb] then x := x or powerof2(bb);
              pdu := pdu + char(x);
            end;
          end;
          // read holding register
          if function_code = FUNCTION_CODES_ALL[2] then
          begin
            pdu := pdu + char(count * 2);
            for i := address to address + count - 1 do
              pdu := pdu + char(hi(hreg[i])) + char(lo(hreg[i]));
          end;
          // read input register
          if function_code = FUNCTION_CODES_ALL[3] then
          begin
            pdu := pdu + char(count * 2);
            for i := address to address + count - 1 do
              pdu := pdu + char(hi(ireg[i])) + char(lo(ireg[i]));
          end;
          // write coil
          if function_code = FUNCTION_CODES_ALL[4] then
          begin
            b := 0;
            repeat
              recvbyte := ord(tgm[8 + b]);
              for bb := 0 to 7 do
              coil[address + bb + b * 8 ] := inttobool(recvbyte and powerof2(bb));
              b := b + 1;
            until b = count;
          end;
          // write holding register
          if function_code = FUNCTION_CODES_ALL[5] then
          begin
            b := 0;
            repeat
              hreg[address + b] := ord(tgm[8 + 2 * b ]) * 256 + ord(tgm[9 + 2 * b]);
              b := b + 1;
            until b = count;
          end;
        end;
        crc := crc16(char(uid) + pdu);
        adu := char(uid) +
               pdu +
               char(lo(crc)) +
               char(hi(crc));
        tgm := adu;
        // SEND ANSWER
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
      end;
    end;
    // DISCONNECT SERIAL PORT
    ser_close;
  end else writeln(ERR18, dev[device1].device);
  result := loop;
end;
