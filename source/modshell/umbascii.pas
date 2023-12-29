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
  
procedure asc_readdinp(uid, address, count: integer);
procedure asc_readcoil(uid, address, count: integer);
procedure asc_readireg(uid, address, count: integer);
procedure asc_readhreg(uid, address, count: integer);
procedure asc_writecoil(uid, address, count: integer);
procedure asc_writehreg(uid, address, count: integer);

implementation

// CONVERT A STRING OF ASCII CODED HEXA BYTES TO STRING OF HEXA BYTES }
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

// CREATE LONGITUDINAL REDUNDANCY CHECK (LRC) VALUE
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

// CHECK LRC OF A STRING
function chkecklrc(s: string; l: word): boolean;
begin
  result := true;
end;

// READ REMOTE DISCRETE INPUT
procedure asc_readdinp(uid, address, count: integer);
begin
end;

// READ REMOTE COIL
procedure asc_readcoil(uid, address, count: integer);
begin
end;

// READ REMOTE INPUT REGISTER
procedure asc_readireg(uid, address, count: integer);
begin
end;

// READ REMOTE HOLDING REGISTER
procedure asc_readhreg(uid, address, count: integer);
begin
end;

// WRITE REMOTE COIL
procedure asc_writecoil(uid, address, count: integer);
begin
end;

// WRITE REMOTE HOLDING REGISTER
procedure asc_writehreg(uid, address, count: integer);
begin
end;

end.
