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

// Uncomment following line, if you want to simulate serial connection.
{$DEFINE LOOPCONNECT}

{$IFDEF LOOPCONNECT}
var
  loopconnectbuffer: string;
{$ENDIF}

{$IFDEF GO32V2}
const
  SPD: array[0..7] of integer = (96, 48, 24, 12, 6, 3, 2, 1);
  PAR: array[0..2] of integer = ($18, $00, $08);
  DBIT: array[7..8] of integer = ($02, $03);
  SBIT: array[1..2] of integer = ($00, $04);
{$ELSE}
{$ENDIF}

// READ CHAR FROM SERIAL PORT
function ser_chread: char;
begin
  {$IFDEF LOOPCONNECT}
    result := loopconnectbuffer[1];
    delay(25);
  {$ELSE}
    {$IFDEF GO32V2}
      result := getchar;
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;

// READ STRING FROM SERIAL PORT
function ser_read: string;
begin
  {$IFDEF LOOPCONNECT}
    result := loopconnectbuffer;
    delay(25);
  {$ELSE}
    {$IFDEF GO32V2}
      result := getstring;
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;

// WRITE CHAR TO SERIAL PORT
procedure ser_chwrite(c: char);
begin
  {$IFDEF LOOPCONNECT}
    loopconnectbuffer := c;
    delay(25);
  {$ELSE}
    {$IFDEF GO32V2}
      putchar(c);
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;

// WRITE STRING TO SERIAL PORT
procedure ser_write(s: string);
begin
  {$IFDEF LOOPCONNECT}
    loopconnectbuffer := s;
    delay(25);
  {$ELSE}
    {$IFDEF GO32V2}
      putstring(s);
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;

// OPEN SERIAL PORT
function ser_init(device: string; speed: byte; databit: byte; parity: byte; stopbit: byte): boolean;
var
  b: byte;
begin
  result := true;
  {$IFNDEF LOOPCONNECT}
    {$IFDEF GO32V2}
      for b := 0 to 4 do
        if lowercase(device) = 'com' + inttostr(b + 1) then break;
      if b < 4
        then init(PAR[parity] or DBIT[databit] or SBIT[stopbit], b,SPD[speed])
        else result := false;
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;

// CLOSE SERIAL PORT
procedure ser_close;
begin
  {$IFNDEF LOOPCONNECT}
    {$IFDEF GO32V2}
      done;
    {$ELSE}
    {$ENDIF}
  {$ENDIF}
end;
