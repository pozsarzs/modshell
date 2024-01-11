{ +--------------------------------------------------------------------------+ }
{ | ProtCOM v0.1 * Protected mode serial port handler for DOS                | }
{ | Copyright (C) 2024 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | testprco.pas                                                             | }
{ | test program for ProtCOM unit                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is Public Domain, you can redistribute it and/or modify
  it under the terms of the Creative Common Zero Universal version 1.0.
}

{$IFNDEF GO32V2}
  {$MESSAGE FATAL This unit can only be used on DOS!}
{$ENDIF}

program testprco;
uses
  crt,
  protcom;
var
  c: char;
begin
  connect('com1'); // COM1
  config(3,8,1,1); // 9600, 8 N 1
  write('Colors:');
  textcolor(lightgreen); write(' received data');
  textcolor(lightred); writeln(' trasmitted data');
  repeat
    if not keypressed then
    begin
      if canread then
      begin
        textcolor(lightgreen);
        write(char(recvbyte));
      end;
    end else
    begin
      c:=readkey;
      sendbyte(ord(c));
      textcolor(lightred);
      write(c);
    end;
  until c=#27;
  textcolor(lightgray);
  disconnect;
end.
