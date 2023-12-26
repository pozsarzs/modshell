{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | userial.pas                                                              | }
{ | Serial port handler procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit userial;
interface
{$IFDEF GO32V2}
  uses dosprser;
{$ELSE}
{$ENDIF}

{$IFDEF GO32V2}
const
  SPD: array[0..7] of integer = (96, 48, 24, 12, 6, 3, 2, 1);
  PAR: array[0..2] of integer = ($18, $00, $08);
  DBIT: array[7..8] of integer = ($02, $03);
  SBIT: array[1..2] of integer = ($00, $04);
{$ELSE}
{$ENDIF}

function serialread: string;
procedure serialwrite(s: string);
function serialinit(device: string; speed: byte; databit: byte; stopbit: byte): boolean;
procedure serialclose;

implementation

// read string from serial port
function serialread: string;
begin
  {$IFDEF GO32V2}
    result := getstring;
  {$ELSE}
  {$ENDIF}
end;

// write string to serial port
procedure serialwrite(s: string);
begin
  {$IFDEF GO32V2}
    putstring(s);
  {$ELSE}
  {$ENDIF}
end;

// open serial port
function serialinit(device: string; speed: byte; databit: byte; stopbit: byte): boolean;
var
  b: byte;
begin
  result := true;
  {$IFDEF GO32V2}
    for b := 0 to 4 do
      if lowercase(device) = 'com' + inttostr(b + 1) then break
    if b < 4
      then init(PAR[parity] or DBIT[databit] or SBIT[stopbit], b,SPD[speed]);
      else result := false;
  {$ELSE}
  {$ENDIF}
end;

// close serial port
procedure serialclose;
begin
  {$IFDEF GO32V2}
    done;
  {$ELSE}
  {$ENDIF}
end;

end.
