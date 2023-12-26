{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | umbascii.pas                                                             | }
{ | Modbus/ASCII protocol procedures and functions                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit umbascii;
interface
uses
  userial;
  
procedure asc_readdinp(device, uid, address, count: integer);
procedure asc_readcoil(device, uid, address, count: integer);
procedure asc_readireg(device, uid, address, count: integer);
procedure asc_readhreg(device, uid, address, count: integer);
procedure asc_writecoil(device, uid, address, count: integer);
procedure asc_writehreg(device, uid, address, count: integer);

implementation

// convert a string of ASCII coded hexa bytes to string of hexa bytes }
function hex2(s: string): string;
var
  b:       byte;
  d, e: integer;
  res:     string;
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

// create Longitudinal Redundancy Check (LRC) value
function lrc(s: string): word;
var
   b:   byte;
   res: word;
begin
  s := hex2(s);
  res := 0;
  for b := 1 to length(s) do
    res := res + ord(s[b]) and $FF;
  res := (((res xor $FF) + 1) and $FF);
  lrc := res;
end;

// check LRC of a string
function chkecklrc(s: string; l: word): boolean;
begin
  result := true;
end;

// read remote discrete input
procedure asc_readdinp(device, uid, address, count: integer);
begin
end;

// read remote coil
procedure asc_readcoil(device, uid, address, count: integer);
begin
end;

// read remote input register
procedure asc_readireg(device, uid, address, count: integer);
begin
end;

// read remote holding register
procedure asc_readhreg(device, uid, address, count: integer);
begin
end;

// write remote coil
procedure asc_writecoil(device, uid, address, count: integer);
begin
end;

// write remote holding register
procedure asc_writehreg(device, uid, address, count: integer);
begin
end;

end.
