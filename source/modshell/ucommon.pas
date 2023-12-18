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
  sysutils;

function checkipaddress(address: string): boolean;
function getlang: string;
function getexepath: string;
function getuserdir: string;
function terminalsize: boolean;
procedure quit(halt_code: byte; clear: boolean; message: string);
procedure ewrite(fg: byte; hl: byte; t: string);
procedure xywrite(x, y: byte; c: boolean; s: string);

implementation

// check IP address
function checkipaddress(address: string): boolean;
var
  b, c: byte;
  s: array[0..3] of string;

begin
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

// get system language
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

// get path of the executable file;
function getexepath: string;
var
  p: shortstring;
begin
  result := ExtractFilePath(ParamStr(0));
end;

// get user's directory
function getuserdir: string;
begin
  {$IFDEF GO32V2}
    result := getexepath;
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

// check terminal size
function terminalsize: boolean;
begin
  if (screenwidth>=80) and (screenheight>=25)
    then terminalsize:=true
    else terminalsize:=false;
end;

// exit
procedure quit(halt_code: byte; clear: boolean; message: string);
begin
  textcolor(lightgray); textbackground(black);
  if clear then clrscr;
  writeln(message);
  halt(halt_code);
end;

// write procedure with highlighted words
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

// write to a position
procedure xywrite(x, y: byte; c: boolean; s: string);
begin
  gotoxy(x, y);
  if c then clreol;
  write(s);
end;

end.

