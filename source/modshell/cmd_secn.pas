{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_secn.pas                                                             | }
{ | command 'sercons'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1
  -------------
  sercon [dev?]
}

// COMMAND 'SERCONS'
procedure cmd_sercons(p1: string);
var
  c: char;
  i1: integer;             // parameters other type
  s1: string;              // parameters in other type
  valid: boolean = false;
  x: boolean = false;

  // LOCAL ECHO
  procedure localecho(c: char);
  begin
    case echo of
      1: write(c);
      2: write(addsomezero(2, deztohex(inttostr(ord(c)))) + ' ');    
    end;
  end;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    write(MSG30);
    repeat
      c := readkey;
      i1 := ord(c);
    until ((i1 > 47) and (i1 < 56)) or (c = #27);
    if c = #27 then exit;
    writeln(c);
    i1 := i1 - 48;
  end else
  begin
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
      writeln(MSG29);
      writeln(MSG28 + ECHO_ARG[echo]);        
      repeat
        while not keypressed do
          if ser_canread then write(chr(ser_recvbyte)) else writeln(ERR26);
        c := readkey;
        if c = #0 then
          if readkey = #68 then x := true;
        if ser_canwrite then
        begin
          ser_sendbyte(ord(c));
          localecho(c);
          if c = #13 then
          begin
            c := #10;
            ser_sendbyte(ord(c));
            localecho(c);
          end;
        end else writeln(ERR27);
      until x;
      ser_close;
      writeln;
      writeln;
    end else writeln(ERR18);
end;
