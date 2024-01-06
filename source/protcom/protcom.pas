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
uses
  go32,
  sysutils;
var
  newvec: tseginfo; // new interrupt vector
  oldvec: tseginfo; // old interrupt vector
  orgds: word; external name '___v2prt0_ds_alias';
  ba: word; // base address of the device
  error: boolean = false; // collected error flag
  irq: byte; // IRQ line of the device
  rda: boolean = false; // received data available
  
const
  // default base address and IRQ
  DEF_BA: array[1..4] of word = ($03f8, $02f8, $02e8, $03e8);
  DEF_IRQ: array[1..4] of byte = (4, 3, 4, 3);
  // offset of register addresses from the base address
  THR = $00; // Transmit Holding Register
  RBR = $00; // Receive Buffer Register
  DLL = $00; // Divisor Latch Low byte
  DLH = $01; // Divisor Latch High byte
  IER = $01; // Interrupt Enable Register
  IIR = $02; // Interrupt Identification Register
  LCR = $03; // Line Control Register
  MCR = $04; // Modem Control Register
  LSR = $05; // Line Status Register
  MSR = $06; // Modem Status Register
  SCR = $07; // Scratch Register
  // 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200
  BAUDRATE: array[0..7] of byte = (96, 48, 24, 12, 6, 3, 2, 1);
  DATABIT: array[7..8] of byte = ($02, $03);
  // even, none, odd
  PARITY: array[0..2] of byte = ($18, $00, $08);
  STOPBIT: array[1..2] of byte = ($00, $04);
  
function geterror: boolean;
function canread: boolean;
function canwrite: boolean;
function getportaddr: word; 
function recvbyte: byte;
function recvstring: string;
procedure config(baud, bits, par, stop: integer);
procedure connect(comport: string);
procedure sendbyte(data: byte);
procedure sendstring(data: string);

implementation

function geterror: boolean;
begin
  result := error;
end;

procedure recvirq; assembler;
asm
end;

procedure recvirqend;
begin
end;

function  getchar: char; assembler;
asm
end;

procedure putchar(c: char); assembler;
asm
end;

procedure setspeed(speed: word); assembler;
asm
end;

procedure init(defaults: byte); assembler;
asm
end;

function canread(timeout: integer): boolean;
begin
  result := rda;
end;

function canwrite(timeout: integer): boolean;
begin
end;

function getportaddr: word; 
begin
  result := ba;
end;

function recvbyte(timeout: integer): byte;
begin
end;

function recvstring(timeout: integer): string;
begin
end;

procedure config(baud, bits, par, stop: integer);
begin
  disable;
  init(PARITY[par] or DATABIT[bits] OR STOPBITS[stop]);
  setspeed(BAUDRATE[speed]);





  enable;
end;

procedure connect(comport: string);
var
  i: byte;
  s: string = '';
begin
  error := false;
  if length(comport) >= 4 then
  begin
    for i := 1 to 3 do s := s + comport[i];
    if comparestr(uppercase(s),'COM') = 0 then
    begin
      i := strtointdef(comport[4], 0);
      if (i > 0) and (i < 5) then
      begin
        ba := DEF_BA[i];
        irq := DEF_IRQ[i];
      end else error := true;
    end;
  end;
end;

procedure sendbyte(data: byte);
begin
  putchar(chr(data));
end; 

procedure sendstring(data: string);
var
  b: byte;
begin
  for b := 1 to length(data) do putchar(data[b]);
end;

end.
