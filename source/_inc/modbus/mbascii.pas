{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $01;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu +
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        s := '';
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
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
                             1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
                             2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
                             3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
                             4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
                           end;
          end;
        end else {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// READ REMOTE DISCRETE INPUT (FC 0x02)
procedure mbasc_readdinp(protocol, device, address, count: word);
var
  b, bb: byte;
  c: char;
  pdu, adu, tgm: string;
  recvbyte, recvcount: byte;
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $02;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu +
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        s := '';
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
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
                             1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
                             2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
                             3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
                             4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
                           end;
          end;
        end else {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// READ REMOTE HOLDING REGISTER (FC 0x03)
procedure mbasc_readhreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $03;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu +
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        s := '';
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
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
                             1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
                             2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
                             3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
                             4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
                           end;
          end;
        end else {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// READ REMOTE INPUT REGISTER (FC 0x04)
procedure mbasc_readireg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  pdu, adu, tgm: string;
  recvcount: byte;
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $04;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
  pdu := hex1(2, FUNCTION_CODE) +
         hex1(4, address) +
         hex1(4, count);
  adu := hex1(2, prot[protocol].uid) +
         pdu +
         hex1(2, lrc(hex1(2, prot[protocol].uid) + pdu));
  tgm := uppercase(#58 + adu + #13 + #10);
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        s := '';
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
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
                             1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
                             2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
                             3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
                             4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
                           end;
          end;
        end else {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// WRITE REMOTE COIL (FC 0x0F)
procedure mbasc_writecoil(protocol, device, address, count: word);
var
  b, bb, x: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $0F;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
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
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        s := '';
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
    try
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          if strtoint('$' + tgm[4] + tgm[5]) = FUNCTERR_CODE then
            case strtoint('$' + tgm[6] + tgm[7]) of
              1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
              2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
              3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
              4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
            end;
        end else{$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// WRITE REMOTE HOLDING REGISTER (FC 0x10)
procedure mbasc_writehreg(protocol, device, address, count: word);
var
  b: byte;
  c: char;
  i: integer;
  pdu, adu, tgm: string;
  s: string;
  wait: integer = 0;
const
  FUNCTION_CODE = $10;
  FUNCTERR_CODE = FUNCTION_CODE + $80;
begin
  // create ascii telegram for request
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
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
    // transmit request
    if ser_canwrite then
    begin
      ser_sendstring(tgm);
      {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
      s := '';
      case uconfig.echo of
        1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
        2: begin
             for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
             {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
           end;
      end;
      {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
    end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
    // receive response
    tgm := '';
    repeat
      sleep(1);
      if ser_canread then
      begin
        wait := 0;
        b := ser_recvbyte;
        {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
        s := '';
        case uconfig.echo of
          1: s := s + char(b);
          2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
        end;
        {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        tgm := tgm + char(b);
      end else
        if wait < 65535 then inc(wait);
      if keypressed then c := readkey;
    until (c = #27) or (length(tgm) = 255) or (wait = timeout);
    if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    // disconnect serial port
    ser_close;
    // parse response
    try
      if tgm[1] = #58 then
        if strtoint('$' + tgm[2] + tgm[3]) = prot[protocol].uid then
        begin
          if strtoint('$' + tgm[4] + tgm[5]) = FUNCTERR_CODE then
            case strtoint('$' + tgm[6] + tgm[7]) of
              1: {$IFNDEF X} writeln(ERR29); {$ELSE} Form1.Memo1.Lines.Add(ERR29); {$ENDIF}
              2: {$IFNDEF X} writeln(ERR30); {$ELSE} Form1.Memo1.Lines.Add(ERR30); {$ENDIF}
              3: {$IFNDEF X} writeln(ERR31); {$ELSE} Form1.Memo1.Lines.Add(ERR31); {$ENDIF}
              4: {$IFNDEF X} writeln(ERR32); {$ELSE} Form1.Memo1.Lines.Add(ERR32); {$ENDIF}
            end;
        end else {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    except
      {$IFNDEF X} writeln(ERR28); {$ELSE} Form1.Memo1.Lines.Add(ERR28); {$ENDIF}
    end;
  end else {$IFNDEF X} writeln(ERR18, dev[device].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device].device); {$ENDIF}
end;

// RUN GATEWAY OR SLAVE
function mbasc_slave(enablegw: boolean; protocol1, device1, protocol2, device2: word): boolean;
var
  address: integer;
  adu, pdu, tgm: string;
  b, bb, x: byte;
  c: char;
  count: integer;
  error: byte = 0;
  function_code: byte;
  i: integer;
  loop: boolean = true;
  ready: boolean = false;
  recvbyte: byte;
  s: string;
  sot: char;
  uid: byte;
  valid: boolean = true;
const
  FUNCTION_CODES_ALL: array[0..5] of byte = ($01, $02, $03, $04, $0F, $10);
  FUNCTERR_CODE_OFFSET = $80;
begin
  // connect to serial port
  if ser_open(dev[device1].device, dev[device1].speed, dev[device1].databit, dev[device1].parity, dev[device1].stopbit) then
  begin
    // wait for request
    repeat
      if keypressed then
      begin
        c := readkey;
        if c = #27 then loop := false;
      end else sleep(1);
    until ser_canread or (c = #27);
    if loop then
    begin
      // receive request
      tgm := '';
      repeat
        sleep(1);
        if ser_canread then
        begin
          b := ser_recvbyte;
          {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
          s := '';
          case uconfig.echo of
            1: s := s + char(b);
            2: s := s + addsomezero(2, deztohex(inttostr(b))) + ' ';
          end;
          {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
          tgm := tgm + char(b);
        end else ready := true;
        if keypressed then c := readkey;
        if c = #27 then loop := false;
      until (c = #27) or (length(tgm) = 255) or ready;
      if uconfig.echo > 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      // parse request
      if length(tgm) >= 17 then
      begin
        sot := tgm[1];
        uid := strtoint('$' + tgm[2] + tgm[3]);
        function_code := strtoint('$' + tgm[4] + tgm[5]);
        address := strtoint('$' + tgm[6] + tgm[7] + tgm[8] + tgm[9]);
        count := strtoint('$' + tgm[10] + tgm[11] + tgm[12] + tgm[13]);
        // check data
        if sot <> #58 then error := $04;
        if (address < 1) or (address > 9999) then error := $02;
        if (count < 1) or (count > 125) then error := $03;
        if (function_code = FUNCTION_CODES_ALL[4]) and (length(tgm) < 21) then error := $04;
        if (function_code = FUNCTION_CODES_ALL[5]) and (length(tgm) < 23) then error := $04;
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
    if function_code = FUNCTION_CODES_ALL[0] then mbasc_readcoil(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[1] then mbasc_readdinp(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[2] then mbasc_readhreg(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[3] then mbasc_readireg(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[4] then mbasc_writecoil(protocol2, device2, address, count);
    if function_code = FUNCTION_CODES_ALL[5] then mbasc_writehreg(protocol2, device2, address, count);
  end;
  // connect to serial port
  if ser_open(dev[device1].device, dev[device1].speed, dev[device1].databit, dev[device1].parity, dev[device1].stopbit) then
  begin
    if loop then
    begin
      // create telegram for response
      if uid = prot[protocol1].uid then
      begin
        if error > 0 then pdu := hex1(2, FUNCTERR_CODE_OFFSET + error) else
        begin
          pdu := hex1(2, FUNCTION_CODE);
          // read coil
          if function_code = FUNCTION_CODES_ALL[0] then
          begin
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
          end;
          // read discrete input
          if function_code = FUNCTION_CODES_ALL[1] then
          begin
            if (count mod 8) > 0
            then pdu := pdu + hex1(2, (count div 8) + 1)
            else pdu := pdu + hex1(2, count div 8);
            for i := address to address + count - 1 do
            begin
              x := 0;
              for bb := 0 to 7 do
                if dinp[i + bb] then x := x or powerof2(bb);
              pdu := pdu + hex1(2, x);
            end;
          end;
          // read holding register
          if function_code = FUNCTION_CODES_ALL[2] then
          begin
            pdu := pdu + hex1(2, count * 2);
            for i := address to address + count - 1 do
              pdu := pdu + hex1(4, hreg[i]);
          end;
          // read input register
          if function_code = FUNCTION_CODES_ALL[3] then
          begin
            pdu := pdu + hex1(2, count * 2);
            for i := address to address + count - 1 do
              pdu := pdu + hex1(4, ireg[i]);
          end;
          // write coil
          if function_code = FUNCTION_CODES_ALL[4] then
          begin
            b := 0;
            repeat
              recvbyte := strtoint('$' + tgm[8 + 2 * b] + tgm[9 + 2 * b]);
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
              hreg[address + b] :=
                strtoint('$' + tgm[8 + 4 * b] +
                tgm[9 + 4 * b] +
                tgm[10 + 4 * b] +
                tgm[11 + 4 * b]);
              b := b + 1;
            until b = (count div 2);
          end;
        end;
        adu := hex1(2, uid) +
               pdu +
               hex1(2, lrc(hex1(2, uid) + pdu));
        tgm := uppercase(#58 + adu + #13 + #10);
        // send answer
        if ser_canwrite then
        begin
          ser_sendstring(tgm);
          {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
          s := '';
          case uconfig.echo of
            1: {$IFNDEF X} write(tgm); {$ELSE} Form1.Memo1.Lines.Add(tgm); {$ENDIF}
            2: begin
                 for b := 1 to length(tgm) do s := s + addsomezero(2, deztohex(inttostr(ord(tgm[b])))) + ' ';
                 {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
               end;
          end;
          {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        end else {$IFNDEF X} writeln(ERR27); {$ELSE} Form1.Memo1.Lines.Add(ERR27); {$ENDIF}
      end;
    end;
    // disconnect serial port
    ser_close;
  end else {$IFNDEF X} writeln(ERR18, dev[device1].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[device1].device); {$ENDIF}
  result := loop;
end;
