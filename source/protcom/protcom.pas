{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | protcom.pas                                                              | }
{ | protected mode serial port handler for DOS                               | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$IFNDEF GO32V2}
  {$MESSAGE FATAL This unit can only be used on DOS!} 
{$ENDIF}

{$MODE FPC}
{$ASMMODE INTEL}
unit protcom;
interface

function canread(timeout: integer): boolean;
function canwrite(timeout: integer): boolean;
function getportaddr: word; 
function recvbyte(timeout: integer): byte;
function recvstring(timeout: integer): ansistring;
procedure config(baud, bits: integer; parity: char; stop: integer);
procedure connect(comport: string);
procedure sendbyte(data: byte);
procedure sendstring(data: ansistring);
procedure setsizerecvbuffer(size: integer);

implementation

function canread(timeout: integer): boolean;
begin
end;

function canwrite(timeout: integer): boolean;
begin
end;

function getportaddr: word; 
begin
end;

function recvbyte(timeout: integer): byte;
begin
end;

function recvstring(timeout: integer): ansistring;
begin
end;

procedure config(baud, bits: integer; parity: char; stop: integer);
begin
end;

procedure connect(comport: string);
begin
end;

procedure sendbyte(data: byte);
begin
end;

procedure sendstring(data: ansistring);
begin
end;

procedure setsizerecvbuffer(size: integer);
begin
end;

end.
