{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | mbascii.pas                                                              | }
{ | Modbus/ASCII protocol procedures and functions                           | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// READ REMOTE COIL (FC 0x01)
procedure mbasc_readcoil(protocol, device, address, count: word);
var
  b, bb: byte;
  c: char;
  pdu, adu, tgm: string;
  recvbyte, recvcount: byte;
  wait: integer = 0;
const
  FUNCTION_CODE = $01;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          case strtoint('$' + tgm[4] + tgm[5]) of
            FUNCTION_CODE: begin
                             recvcount := strtoint('$' + tgm[6] + tgm[7]); // bytes
                             b := 0;
                             repeat
                               recvbyte := strtoint('$' + tgm[8 + 2 * b] + tgm[9 + 2 * b]);
                               for bb := 0 to 7 do
                                 coil[address + bb + b * 8 ] := inttobool(recvbyte and powerof2(bb));
                               b := b + 1;
                             until b = recvcount;
                           end;
            FUNCTERR_CODE: case strtoint('$' + tgm[6] + tgm[7]) of
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
procedure mbasc_readdinp(protocol, device, address, count: word);
var
  b, bb: byte;
  c: char;
  pdu, adu, tgm: string;
  recvbyte, recvcount: byte;
  wait: integer = 0;
const
  FUNCTION_CODE = $02;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          case strtoint('$' + tgm[4] + tgm[5]) of
            FUNCTION_CODE: begin
                             recvcount := strtoint('$' + tgm[6] + tgm[7]); // bytes
                             b := 0;
                             repeat
                               recvbyte := strtoint('$' + tgm[8 + 2 * b] + tgm[9 + 2 * b]);
                               for bb := 0 to 7 do
                                 dinp[address + bb + b * 8 ] := inttobool(recvbyte and powerof2(bb));
                               b := b + 1;
                             until b = recvcount;
                           end;
            FUNCTERR_CODE: case strtoint('$' + tgm[6] + tgm[7]) of
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
procedure mbasc_readhreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  wait: integer = 0;
const
  FUNCTION_CODE = $03;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          case strtoint('$' + tgm[4] + tgm[5]) of
            FUNCTION_CODE: begin
                             recvcount := strtoint('$' + tgm[6] + tgm[7]) div 2; // words
                             b := 0;
                             repeat
                               hreg[address + b] := 
                                 strtoint('$' + tgm[8 + 4 * b] +
                                                tgm[9 + 4 * b] +
                                                tgm[10 + 4 * b] +
                                                tgm[11 + 4 * b]);
                               b := b + 1;
                             until b = recvcount;
                           end;
            FUNCTERR_CODE: case strtoint('$' + tgm[6] + tgm[7]) of
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
procedure mbasc_readireg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  wait: integer = 0;
const
  FUNCTION_CODE = $04;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          case strtoint('$' + tgm[4] + tgm[5]) of
            FUNCTION_CODE: begin
                             recvcount := strtoint('$' + tgm[6] + tgm[7]) div 2; // words
                             b := 0;
                             repeat
                               ireg[address + b] := 
                                 strtoint('$' + tgm[8 + 4 * b] +
                                                tgm[9 + 4 * b] +
                                                tgm[10 + 4 * b] +
                                                tgm[11 + 4 * b]);
                               b := b + 1;
                             until b = recvcount;
                           end;
            FUNCTERR_CODE: case strtoint('$' + tgm[6] + tgm[7]) of
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
procedure mbasc_writecoil(protocol, device, address, count: word);
var
  b, bb, x: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $0F;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  if (count mod 8) > 0
  then pdu := pdu + hex1(2, (count div 8) + 1)
  else pdu := pdu + hex1(2, count div 8);
  for i := address to address + count - 1 do
  begin
    x := 0;
    for bb := 0 to 7 do
      if coil[i + bb] then x := x or powerof2(bb);
    pdu := pdu + hex1(2, x);
  end;
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          if strtoint('$' + tgm[4] + tgm[5]) = FUNCTERR_CODE then
            case strtoint('$' + tgm[6] + tgm[7]) of
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
procedure mbasc_writehreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $10;
  FUNCTERR_CODE = FUNCTION_CODE + $80;

begin
  // CREATE ASCII TELEGRAM FOR REQUEST
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count) +
         hex1(2, count * 2);
  for i := address to address + count - 1 do
    pdu := pdu + hex1(4, hreg[i]);
  adu := hex1(2, prot[protocol].uid) +
         pdu + 
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
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
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          if strtoint('$' + tgm[4] + tgm[5]) = FUNCTERR_CODE then
            case strtoint('$' + tgm[6] + tgm[7]) of
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
