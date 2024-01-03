{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | dosprser.pas                                                             | }
{ | protected mode serial port handler for DOS                               | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$mode fpc}
{$asmmode intel}
unit dosprser;
interface
uses
  crt,
  go32;
const
  bps1200 = 96;
  bps2400 = 48;
  bps4800 = 24;
  bps9600 = 12;
  bps14400 = 8;
  bps19200 = 6;
  bps28800 = 4;
  bps38400 = 3;
  bps57600 = 2;
  bps115200 = 1;
  pnoneparity = $00;
  pevenparity = $18;
  poddparity = $08;
  s1stopbit = $00;
  s2stopbit = $04;
  d5databit = $00;
  d6databit = $01;
  d7databit = $02;
  d8databit = $03;
  com1 = $00;
  com2 = $01;
  com3 = $02;
  com4 = $03;
  thr = $00; // transmit holding register
  rbr = $00; // receive buffer register
  dll = $00; // divisor latch low byte
  dlh = $01; // divisor latch high byte
  ier = $01; // interrupt enable register
  iir = $02; // interrupt identification register
  lcr = $03; // line control register
  mcr = $04; // modem control register
  lsr = $05; // line status register
  msr = $06; // modem status register
  scr = $07; // scratch register
  address: array[0..3] of word = ($03f8, $02f8, $02e8, $03e8);
  intr: array[0..3] of byte = (4, 3, 4, 3);
  bits: array[0..7] of byte = ($01, $02, $04, $08, $10, $20, $40, $80); // bitmask
  recvbufflong = 8192;
  recvbuffmask = recvbufflong - 1;
var
  base: word;
  irqn: byte;
  recvbuff: array[0..recvbufflong -1 ] of byte;
  rbs, rbe: longint;
  newvec: tseginfo;
  oldvec: tseginfo;
  orgds: word; external name '___v2prt0_ds_alias';
  key: char;
  rds: boolean;
  i: byte;

function getchar: char;
function getstring: string;
procedure putchar(c: char);
procedure putstring(s: string);
procedure init(defaults: byte; com: word; speed: word);
procedure done;

implementation

function newchar: boolean;
begin
  if rbs <> rbe then result := true else result := false;
end;

procedure receiveirq; assembler;
asm
   push  ds
   push  eax
   push  edx
   mov   ds, cs:[orgds]
   mov   dx, base
   in    al, dx
   lea   edx, recvbuff
   add   edx, rbs
   mov   [edx], al
   inc   rbs
   and   rbs, recvbuffmask
   mov   al, $20
   out   $20, al
   pop   edx
   pop   eax
   pop   ds
   iret
end;

procedure endreceiveirq;
begin
end;

function getchar: char; assembler;
asm
   mov   rds, 0
   mov   eax, rbs
   cmp   eax, rbe
   jz    @exit
   lea   ebx, recvbuff
   add   ebx, rbe
   mov   al, [ebx]
   inc   rbe
   and   rbe, recvbuffmask
   inc   rds
@exit:
end ['eax', 'ebx', 'edx'];

procedure putchar(c: char); assembler;
asm
   mov   dx, base
   add   dx, lsr
@wait:
   in    al, dx
   and   al, 00100000b
   jz    @wait
   sub   dx, lsr
   mov   al, c
   out   dx, al
end ['eax', 'edx'];

procedure enableirqline(line: byte);
begin
  outportb($21, inportb($21) and not bits[line]);
end;

procedure disableirqline(line: byte);
begin
  outportb($21, inportb($21) or bits[line]);
end;

procedure setirq;
begin
 lock_code(@receiveirq, longint(@endreceiveirq) - longint(@receiveirq));
 lock_data(base, sizeof(base));
 lock_data(recvbuff, sizeof(recvbuff));
 lock_data(rbs, sizeof(rbs));
 newvec.offset := @receiveirq;
 newvec.segment := get_cs;
 get_pm_interrupt(irqn + 8, oldvec);
 set_pm_interrupt(irqn + 8, newvec);
 enableirqline(irqn);
end;

procedure resetirq;
begin
 disableirqline(irqn);
 set_pm_interrupt(irqn + 8, oldvec);
 unlock_code(@receiveirq, longint(@endreceiveirq) - longint(@receiveirq));
 unlock_data(base, sizeof(base));
 unlock_data(recvbuff, sizeof(recvbuff));
 unlock_data(rbs, sizeof(rbs));
end;

procedure setspeed(speed: word); assembler;
asm
   mov   dx, base
   add   dx, lcr
   in    al, dx
   or    al, 10000000b
   out   dx, al
   mov   bl, al
   sub   dx, lcr
   mov   ax, speed
   out   dx, ax
   add   dx, lcr
   mov   al, bl
   and   al, 01111111b
   out   dx, al
end ['eax', 'ebx', 'edx'];

procedure resetmodem; assembler;
asm
   mov    dx, base
   add    dx, mcr
   in     al, dx
   mov    ah, al
   or     al, 00010000b
   out    dx, al
   mov    ecx, 100
@wait:
   nop
   loop   @wait
   mov    al, ah
   out    dx, al
end ['eax', 'ecx', 'edx'];

procedure initserialport(defaults: byte); assembler;
asm
   mov   dx, base
   in    al, dx
   mov   al, defaults
   and   al, 01111111b
   add   dx, lcr
   out   dx, al
   inc   dx
   in    al, dx
   and   al, $01
   or    al, $0a
   out   dx, al
   mov   dx, base
   in    al, dx
   add   dx, msr
   in    al, dx
   dec   dx
   in    al, dx
   sub   dx, 3
   in    al, dx
end ['eax', 'edx'];

procedure putstring(s: string);
var
   i: integer;
begin
  for i := 1 to length(s) do
    putchar(s[i]);
end;

function getstring: string;
var
  c:  char;
  res: string;
begin
  res := '';
  delay(500);
  repeat
    c := getchar;
    if rds then
      res := res + c;
  until rbs = rbe;
  getstring := res;
end;

procedure init(defaults: byte; com: word; speed: word);
begin
 base := address[com];
 irqn := intr[com];
 disable;
 initserialport(defaults);
 setspeed(speed);
 outportb(base + ier, $01);
 setirq;
 enable;
end;

procedure done;
begin
 outportb(base + ier, $00);
 resetirq;
end;

end.
