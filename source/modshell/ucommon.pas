{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ucommon.pas                                                              | }
{ | common procedures and functions                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit ucommon;
interface
uses
  crt,
  math,
  sysutils;
const
  CRC16TABLE: array[0..255] of word = (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241,
    $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440,
    $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1, $CE81, $0E40,
    $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841,
    $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40,
    $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41,
    $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $D641,
    $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040,
    $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240,
    $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441,
    $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840,
    $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41,
    $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40,
    $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640,
    $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041,
    $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240,
    $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441,
    $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41,
    $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840,
    $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41,
    $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640,
    $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041,
    $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241,
    $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440,
    $9C01, $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40,
    $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841,
    $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40,
    $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41,
    $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641,
    $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040);

function powerof2(exponent: byte): byte;
function round2(const number: extended; const places: longint): extended;
function addzero(v: word): string;
function addsomezero(n: byte; s: string): string;
function hex1(n: byte; w: word): string;
function hex2(s: string): string;
function lrc(s: string): word;
function checklrc(s: string; l: word): boolean;
function crc16(s: string): word;
function checkcrc16(s: string; l: word): boolean;
function booltoint(b: boolean): integer;
function inttobool(i: integer): boolean;
function checkipaddress(address: string): boolean;
function getlang: string;
function getexedir: string;
function getuserdir: string;
function terminalsize: boolean;
procedure quit(halt_code: byte; clear: boolean; message: string);
procedure ewrite(fg: byte; hl: byte; t: string);
procedure xywrite(x, y: byte; c: boolean; s: string);

implementation

// POWER OF TWO FROM ZERO TO SEVEN
function powerof2(exponent: byte): byte;
var
  e: byte;
begin
  if exponent <= 7 then
  begin
    result := 1;
    for e := 1 to exponent do
      result := result * 2;
  end;
end;

// ROUND
function round2(const number: extended; const places: longint): extended;
var
  t: extended;
begin
   t := power(10, places);
   round2 := round(number * t) / t;
end;

// INSERT ZERO BEFORE [0-9]
function addzero(v: word): string;
var
  u: string;
begin
  str(v:0, u);
  if length(u) = 1 then u := '0' + u;
   addzero := u;
end;

// INSERT SOME ZERO BEFORE STRING
function addsomezero(n: byte; s: string): string;
begin
  while length(s) <> n do
    s := '0' + s;
  result := s;
end;

// CONVERT A BYTE/WORD NUMBER TO 2/4 DIGIT HEX NUMBER AS STRING
function hex1(n: byte; w: word): string;
var
  b:         byte;
  remainder: word;
  res:       string;
begin
  res := '';
  for b := 1 to n do
  begin
    remainder := w mod 16;
    w := w div 16;
    if remainder <= 9 then
      res := chr (remainder + 48) + res
    else
      res := chr (remainder + 87) + res;
  end;
  result := res;
end;

// CONVERT A STRING OF ASCII CODED HEXA BYTES TO STRING OF HEXA BYTES }
function hex2(s: string): string;
var
  b: byte;
  d: integer;
  res: string;
begin
  b := 1;
  res := '';
  repeat
    d := strtoint('$' + s[b] + s[b + 1]);
    res := res + char(d);
    b:= b + 2;
  until b >= length(s);
  result := res;
end;

// CREATE CYCLIC REDUNDANCY CHECK (CRC16/MODBUS) VALUE
function crc16(s: string): word;
var
  i: integer;
  idx: byte = 0;
  crc: word = $FFFF;
begin
  for i := 1 to length(s) do
  begin
    idx := ord(s[i]) xor crc;
    crc := crc shr 8;
    crc := crc xor CRC16TABLE[idx];
  end;
  result := crc;
end;

// CHECK CRC OF A STRING
function checkcrc16(s: string; l: word): boolean;
begin
  if l = crc16(s)
    then result := true
    else result := false;
end;

// CREATE LONGITUDINAL REDUNDANCY CHECK (LRC) VALUE
function lrc(s: string): word;
var
   b: byte;
   res: word;
begin
  s := hex2(s);
  res := 0;
  for b := 1 to length(s) do
    res := res + ord(s[b]) and $FF;
  res := (((res xor $FF) + 1) and $FF);
  result := res;
end;

// CHECK LRC OF A STRING
function checklrc(s: string; l: word): boolean;
begin
  if l = lrc(s)
    then result := true
    else result := false;
end;

// CONVERT BOOLEAN TO INTEGER;
function booltoint(b: boolean): integer;
begin
  if b then result := 1 else result := 0;
end;

// CONVERT INTEGER TO BOOLEAN;
function inttobool(i: integer): boolean;
begin
  if i > 0 then result := true else result := false;
end;

// CHECK IP ADDRESS
function checkipaddress(address: string): boolean;
var
  b, c: byte;
  s: array[0..3] of string;

begin
  for b := 0 to 3 do s[b] := '';
  c := 0;
  for b := 1 to length(address) do
    if address[b] <> '.'
    then
      s[c] := s[c] + address[b]
    else
      if c < 3 then inc(c);
  c := 0;
  for b := 0 to 3 do
    if (strtointdef(s[b], -1) < 0) or (strtointdef(s[b], -1) > 255) then inc(c);
  if (c > 0) then result := false else result := true;
end;

// GET SYSTEM LANGUAGE
function getlang: string;
var
{$IFDEF WINDOWS}
  buffer: PChar;
  size: integer;
{$ENDIF}
  s: string;

begin
  {$IFDEF GO32V2}
    s := getenvironmentvariable('LANG');
  {$ELSE}
    {$IFDEF WINDOWS}
      size := getlocaleinfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
      getmem(buffer, size);
      try
        getlocaleinfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, buffer, size);
        s := string(buffer);
      finally
        freemem(buffer);
      end;
    {$ELSE}
      {$IFDEF UNIX}
        s := getenvironmentvariable('LANG');
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF} 
  if length(s) = 0 then
    s := 'en';
  s := lowercase(s[1..2]);
  getlang := s;
end;

// GET PATH OF THE EXECUTABLE FILE;
function getexedir: string;
begin
  result := ExtractFilePath(ParamStr(0));
end;

// GET USER'S DIRECTORY
function getuserdir: string;
begin
  {$IFDEF GO32V2}
    result := getexedir;
  {$ELSE}
    {$IFDEF WINDOWS}
      result := getuserprofile + '\';
    {$ELSE}
      {$IFDEF UNIX}
        result := getenvironmentvariable('HOME') + '/';
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

// CHECK TERMINAL SIZE
function terminalsize: boolean;
begin
  if (screenwidth>=80) and (screenheight>=25)
    then terminalsize:=true
    else terminalsize:=false;
end;

// EXIT
procedure quit(halt_code: byte; clear: boolean; message: string);
begin
  textcolor(lightgray); textbackground(black);
  if clear then clrscr;
  writeln(message);
  halt(halt_code);
end;

// WRITE PROCEDURE WITH HIGHLIGHTED WORDS
procedure ewrite(fg: byte; hl: byte; t: string);
var
  b: byte;

begin
  textcolor(fg);
  for b:=1 to length(t) do
  begin
    case t[b] of
      '<': textcolor(hl);
      '>': textcolor(fg);
    else write(t[b]);
    end;
  end;
end;

// WRITE TO A POSITION
procedure xywrite(x, y: byte; c: boolean; s: string);
begin
  gotoxy(x, y);
  if c then clreol;
  write(s);
end;

end.

