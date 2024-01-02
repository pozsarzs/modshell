{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | serport.pas                                                              | }
{ | Serial port handler procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$IFDEF GO32V2}
const
  SPD: array[0..7] of integer = (96, 48, 24, 12, 6, 3, 2, 1);
  PAR: array[0..2] of integer = ($18, $00, $08);
  DBIT: array[7..8] of integer = ($02, $03);
  SBIT: array[1..2] of integer = ($00, $04);
{$ELSE}
{$ENDIF}

// READ STRING FROM SERIAL PORT
function ser_read: string;
begin
  {$IFDEF GO32V2}
    result := getstring;
  {$ELSE}
  {$ENDIF}
end;

// WRITE STRING TO SERIAL PORT
procedure ser_write(s: string);
begin
  {$IFDEF GO32V2}
    putstring(s);
  {$ELSE}
  {$ENDIF}
end;

// OPEN SERIAL PORT
function ser_init(device: string; speed: byte; databit: byte; parity: byte; stopbit: byte): boolean;
var
  b: byte;
begin
  result := true;
  {$IFDEF GO32V2}
    for b := 0 to 4 do
      if lowercase(device) = 'com' + inttostr(b + 1) then break;
    if b < 4
      then init(PAR[parity] or DBIT[databit] or SBIT[stopbit], b,SPD[speed])
      else result := false;
  {$ELSE}
  {$ENDIF}
end;

// CLOSE SERIAL PORT
procedure ser_close;
begin
  {$IFDEF GO32V2}
    done;
  {$ELSE}
  {$ENDIF}
end;
