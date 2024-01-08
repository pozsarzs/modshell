{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | protcom.pas                                                              | }
{ | ProtCOM unit * protected mode serial port handler for DOS                | }
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

{$MODE OBJFPC}
{$ASMMODE INTEL}
unit protcom;
interface
uses
  go32,
  sysutils;
const
  // default address and IRQ
  DEF_IBA: word = $0020; // PIC
  DEF_SBA: array[1..4] of word = ($03f8, $02f8, $02e8, $03e8); // UART
  DEF_IRQ: array[1..4] of byte = (4, 3, 4, 3); // UART
  // register address offset of the UART (i8250)
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
  // register address offset of the PIC (i8259)
  IMR = $01; // Interrupt Mask Register
  // 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200
  BAUDRATE: array[0..7] of byte = (96, 48, 24, 12, 6, 3, 2, 1);
  DATABIT: array[7..8] of byte = ($02, $03);
  // even, none, odd
  PARITY: array[0..2] of byte = ($18, $00, $08);
  STOPBIT: array[1..2] of byte = ($00, $04);
  INTMASK: array[3..4] of byte = ($08, $10);
  RECVBUFFERSIZE = 8192;
  RECVBUFFERMASK = RECVBUFFERSIZE - 1;
var
  newvec: tseginfo; // new interrupt vector
  oldvec: tseginfo; // old interrupt vector
  orgds: word; external name '___v2prt0_ds_alias';
  ba: word; // base address of the UART
  irq: byte; // IRQ line of the device
  rda: boolean = false; // received data available
  nwb: longint; // next byte to write in the receive buffer
  nrb: longint; // next byte to read in the receive buffer
  recvbuffer: array[0..RECVBUFFERSIZE - 1] of byte; // receive buffer

function getportaddr: word;
function canread: boolean;
function canwrite: boolean;
function recvbyte: byte;
function recvstring: string;
procedure sendbyte(data: byte);
procedure sendstring(data: string);
function connect(comport: string): boolean;
procedure disconnect;
procedure config(baud, bits, par, stop: integer);

implementation

// GET BASE ADDRESS OF THE SERIAL PORT
function getportaddr: word;
begin
  result := ba;
end;

// ARE THERE ANY RECEIVED DATA IN THE BUFFER?
function canread: boolean;
begin
  if nrb = nwb then result := false else result := true;
end;

// ALL DATA HAS TRANSMITTED?
function canwrite: boolean;
begin
  // check Transmit Holding Register Empty bit (5th bit) of the Line Status Register
  if ((inportb(ba + LSR)) and $20) <> 0
    then result := true
    else result := false;
end;

// RECEIVE A BYTE
function recvbyte: byte;
begin
  rda := false;
  if canread then
  begin
    result := recvbuffer[nrb];
    inc(nrb);
    nrb := nrb and RECVBUFFERMASK;
    rda := true;
  end;
end;

// RECEIVE A STRING
function recvstring: string;
var
  s: string = '';
begin
  repeat
    s := s + char(recvbyte);
  until (length(s)=255) or (not canread);
  result := s;
end;

// SEND A BYTE
procedure sendbyte(data: byte);
begin
  repeat until canwrite;
  outportb(ba + THR, data);            // data to Transmit Holding Register
end;

// SEND A STRING
procedure sendstring(data: string);
var
  b: byte;
begin
  for b := 1 to length(data) do sendbyte(ord(data[b]));
end;

// NEW INTERRUPT PROCEDURE
procedure recvirq; assembler;
asm
   push  DS                              // original contents
   push  eax
   push  edx

   mov   DS, CS:[OrgDS]                  // set datasegment

   mov   dx, ba                          // read Receive Buffer Register
   in    al, dx
   lea   edx, recvbuffer                 // store received char in the recvbuffer
   add   edx, nwb
   mov   [edx], al
   inc   nwb
   and   nwb, recvbuffermask

   mov   al, $20                         // end of interrupt for PIC
   out   $20, al

   pop   edx                             // restore original content
   pop   eax
   pop   DS

   iret
end;

// END OF THE NEW INTERRUPT PROCEDURE
procedure recvirqend;
begin
end;

// SET PARAMETERS OF CONNECTION, INITIALIZE PORT, SET IRQ
procedure config(baud, bits, par, stop: integer);
var
  defaults: byte;
  l: byte;
begin
  defaults := PARITY[par] or DATABIT[bits] OR STOPBIT[stop];
  // DISABLE ALL INTERRUPTS
  disable;
  // INITIALIZE UART
  inportb(ba + RBR);                     // read Receive Buffer Register
  outportb(ba + LCR, defaults and $7f);  // set Line Control Register
  outportb(ba + MCR,
    (inportb(ba + MCR) and $01) or $0a); // set Modem Control Register
  inportb(ba + RBR);                     // read Receive Buffer Register
  inportb(ba + MSR);                     // read Modem Status Register
  inportb(ba + LSR);                     // read Line Status Register
  inportb(ba + IIR);                     // read Interrupt Identification Register
  // SET BAUDRATE
  // set Divisor Latch Access bit (7 bit) of the Line Control Register to 1
  l := inportb(ba + LCR) or $80;
  outportb(ba + LCR, l);
  outportw(ba, BAUDRATE[baud]);                   // set Divisor Latch Low and High registers
  // set Divisor Latch Access bit (7 bit) of the Line Control Register to 0
  l := l and $7f;
  outportb(ba + LCR, l);
  // SET INTERRUPT EVENT
  // set RBR Data Ready Interrupt bit (0 bit) of the Interrupt Enable Register to 1
  outportb(ba + IER, $01);
  // LOCK CODE AND DATA
  lock_code(@recvirq, longint(@recvirqend) - longint(@recvirq));
  lock_data(ba, sizeof(ba));
  lock_data(recvbuffer, sizeof(recvbuffer));
  lock_data(rda, sizeof(rda));
  // SET INTERRUPT VECTOR
  newvec.offset:=@recvirq;
  newvec.segment:=get_cs;
  get_pm_interrupt(irq + 8, oldvec);
  set_pm_interrupt(irq + 8, newvec);
  // ENABLE IRQ LINE OF THE PIC
  // set 4th or 5th bit of the Interrupt Mask Register to 0
  outportb(DEF_IBA + IMR, inportb(DEF_IBA + IMR) and not INTMASK[irq]);
  // ENABLE ALL INTERRUPTS
  enable;
end;

// SET SPEED OF SERIAL PORT
procedure setspeed(speed: word);
var
  l: byte;
begin
  // set Divisor Latch Access bit (7 bit) of the Line Control register to 1
  l := inportb(ba + LCR) or $80;
  outportb(ba + LCR, l);
  // set Divisor Latch Low and High registers
  outportw(ba, speed);
  // set Divisor Latch Access bit (7 bit) of the Line Control register to 0
  l := l and $7f;
  outportb(ba + LCR, l);
end;

// DISABLE IRQ AND RESTORE TO ORIGINAL
procedure disconnect;
begin
  // RESET INTERRUPT EVENT
  outportb(ba + IER, $00);
  // DISABLE IRQ LINE OF THE PIC
  // set 4th or 5th bit of the Interrupt Mask Register to 1
  outportb(DEF_IBA + IMR, inportb(DEF_IBA + IMR) or INTMASK[irq]);
  // SET ORIGINAL INTERRUPT VECTOR
  set_pm_interrupt(irq + 8, oldvec);
  // unlock code and data
  unlock_code(@recvirq, longint(@recvirqend) - longint(@recvirq));
  unlock_data(ba, sizeof(ba));
  unlock_data(recvbuffer, sizeof(recvbuffer));
  unlock_data(rda, sizeof(rda));
end;

// set base address and IRQ line
function connect(comport: string): boolean;
var
  i: byte;
  s: string = '';
begin
  result := true;
  if length(comport) >= 4 then
  begin
    for i := 1 to 3 do s := s + comport[i];
    if comparestr(uppercase(s),'COM') = 0 then
    begin
      i := strtointdef(comport[4], 0);
      if (i > 0) and (i < 5) then
      begin
        ba := DEF_SBA[i];
        irq := DEF_IRQ[i];
      end else result := false;
    end;
  end;
end;

end.
