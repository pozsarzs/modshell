{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_secn.pas                                                             | }
{ | command 'sercons'                                                        | }
{ +--------------------------------------------------------------------------+ }
(*
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
*)
{
  p0     p1
  -------------
  sercon [dev?]
}

// COMMAND 'SERCONS'
procedure cmd_sercons(p1: string);
var
  b: byte;
  c: char;
  i1: integer;             // parameters other type
  s1: string;              // parameters in other type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := p1;
  delete(s1, length(s1), 1);
  if PREFIX[0]  = s1 then valid := true;
  if valid then
    if length(p1) >= 4 then
    begin
       i1 := strtointdef(p1[4],-1);
       if (i1 >= 0) and (i1 < 8) then valid := true;
    end;
  if not valid then
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    writeln(' ' + PREFIX[0] + '[0-7]');
    exit;
  end;
  if not dev[i1].valid then
  begin
    writeln(PREFIX[0], i1, MSG06);
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    writeln(MSG24);
    exit;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      writeln(MSG31);
      repeat
        if keypressed then
        begin
          c := readkey;
          if ser_canwrite then
          begin
            ser_sendstring(c);
            textcolor(uconfig.colors[3]);
            write(c);
            if c = #13 then write(#10);
            textcolor(uconfig.colors[0]);
          end else writeln(ERR27);
        end;
        if ser_canread then
        begin
          b := ser_recvbyte;
          textcolor(uconfig.colors[2]);
          write(char(b));
          if b = 13 then write(#10);
          textcolor(uconfig.colors[0]);
        end;
      until c = #27;
      writeln;
      ser_close;
      writeln;
    end else writeln(ERR18, dev[i1].device);
end;
