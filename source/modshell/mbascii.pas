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
  :      2 chars  2 chars   n chars  2 chars  CR LF
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
  c: char;
  e: integer;
  telegram: string;

begin
  // create ASCII telegram
  telegram := hex1(2, prot[protocol].uid) + // UID
              hex1(2, 3) +                  // FC
              hex1(4, address) +            // data
              hex1(4, count);
  telegram := ':' +                         // start
              telegram +                    // UID, FC, data
              hex1(2, lrc(telegram)) +      // LRC
              #13 + #10;                    // STOP
  // connect to serial port
  if ser_open(dev[device].device, dev[device].speed, dev[device].databit, dev[device].parity, dev[device].stopbit) then
  begin
    writeln(MSG31);
    // send request
    if ser_canwrite then
    begin
      ser_sendstring(telegram);
      textcolor(uconfig.colors[3]);
      case uconfig.echo of
        1: write(telegram);
        2: begin
             for b := 1 to length(telegram) do
               write(addsomezero(2, deztohex(inttostr(ord(telegram[b])))) + ' ');
             writeln;
           end;
      end;
      textcolor(uconfig.colors[0]);
    end else writeln(ERR27);
    // receive answer
    telegram := '';
    repeat
      if ser_canread then
      begin
        b := ser_recvbyte;
        textcolor(uconfig.colors[2]);
        case uconfig.echo of
          1: if b <> 10 then write(char(b));
          2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
        end;
        textcolor(uconfig.colors[0]);
        telegram := telegram + char(b);
      end;
      if keypressed then c := readkey;
    until (c = #27) or (length(telegram) = 255) or ((length(telegram) > 0) and (telegram[length(telegram)] = #10));
    if uconfig.echo > 0 then writeln;
    // disconnect serial port
    ser_close;
    // parse answer and store in the buffer
    try
      for b := 0 to count - 1 do
        val('$' + telegram[8 + 4 * b] +
        telegram[9 + 4 * b] +
        telegram[10 + 4 * b] +
        telegram[11 + 4 * b],
        hreg[address + b], e);
    except
      writeln(ERR28);
    end;    
  end else writeln(ERR18, dev[device].device);
end;

// WRITE REMOTE COIL
procedure mbasc_writecoil(protocol, device, address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure mbasc_writehreg(protocol, device, address, count: integer);
begin
end;
