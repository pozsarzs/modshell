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

function powerof2(exponent: byte): byte;
function round2(const number: extended; const places: longint): extended;
function addzero(v: word): string;
function addsomezero(n: byte; s: string): string;
function hex1(n: byte; w: word): string;
function hex2(s: string): string;
function lrc(s: string): word;
function chkecklrc(s: string; l: word): boolean;
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
  hex1 := res;
end;

// CONVERT A STRING OF ASCII CODED HEXA BYTES TO STRING OF HEXA BYTES }
function hex2(s: string): string;
var
  b: byte;
  d, e: integer;
  res: string;
begin
  b := 1;
  res := '';
  repeat
    val('$' + s[b] + s[b + 1], d, e);
    res := res + char(d);
    b:=b + 2;
  until b >= length(s);
  hex2 := res;
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
  lrc := res;
end;

// CHECK LRC OF A STRING
function chkecklrc(s: string; l: word): boolean;
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

