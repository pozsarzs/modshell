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
{
  ASCII telegram format:
  start  address  function  data     LRC      end
  :      2 chars  2 chars   n chars	2 chars  CR LF
}

// READ REMOTE DISCRETE INPUT
procedure mbasc_readdinp(protocol, device, address, count: integer);
begin
end;

// READ REMOTE COIL
procedure mbasc_readcoil(protocol, device, address, count: integer);
begin
end;

// READ REMOTE INPUT REGISTER
procedure mbasc_readireg(protocol, device, address, count: integer);
begin
end;

// READ REMOTE HOLDING REGISTER
procedure mbasc_readhreg(protocol, device, address, count: integer);
var
  b: byte;
  e: integer;
  telegram: string;

begin
  // create ASCII telegram
  telegram := hex1(2, prot[protocol].uid) + hex1(2, 3) + hex1(4, address) + hex1(4, count);
  telegram := ':' + telegram + hex1(2, lrc(telegram)) + #13 + #10;
  // connect to serial port
  if not ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(); // hiba!
    exit;
  end;
  // send request
  if ser_canwrite then
  begin
    ser_sendstring(telegram);
    // echo!
  end;
  delay(100);
  // receive answer
  telegram := ser_recvstring;
  // disconnect serial port
  ser_close;
  // parse answer and store in the buffer
  for b := 0 to count - 1 do
      val('$' + telegram[8 + 4 * b] + telegram[9 + 4 * b]+ telegram[10 + 4 * b] + telegram[11 + 4 * b], hreg[address + b], e);
{ 

  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      writeln(MSG31);
      repeat
        if ser_canread then
        begin
          b := ser_recvbyte;
          textcolor(uconfig.colors[2]);
          write(char(b));
          if b = 13 then write(#10);
          textcolor(uconfig.colors[0]);
        end;
        if keypressed then
        begin
          c := readkey;
          if ser_canwrite then
          begin
            ser_sendbyte(ord(c));
            textcolor(uconfig.colors[3]);
            write(c);
            if c = #13 then write(#10);
            textcolor(uconfig.colors[0]);
          end else writeln(ERR27);
        end;
      until c = #27;
      writeln;
      ser_close;
    end else writeln(ERR18, dev[i1].device);

begin
  if clearholdreg(r, rs) then
  begin
    
    buffer := hex1(2, a) + hex1(2, 3) + hex1(4, r - 40001) + hex1(4, rs);
    buffer := ':' + buffer + hex1(2, lrc(buffer));
    writeln('- request:  ' + buffer);
    buffer := buffer + char($0d) + char($0a);
    
    putstring(buffer);
    
    buffer := getstring;
    
  end;
end;


	
}


end;

// WRITE REMOTE COIL
procedure mbasc_writecoil(protocol, device, address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure mbasc_writehreg(protocol, device, address, count: integer);
begin
end;
