{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                              | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_help.pas                                                             | }
{ | command 'help'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1
  -----------------
  help [[$]COMMAND]
}

// COMMAND 'HELP'
procedure cmd_help(p1: string);
var
  b, bb: byte;
  valid: boolean;
  buffer: array[0..51] of string;
  line: byte;
  s1: string;                      // parameters in other type

  // SHORTING CONTENT OF BUFFER
  procedure shorting;
  var
   i, j: byte;
   s: string;
  begin
    for i := 0 to 50 do
     for j := i + 1 to 51 do
       if buffer[i] < buffer[j] then
       begin
         s := buffer[i];
         buffer[i] := buffer[j];
         buffer[j] := s;
       end;
  end;

begin
  for b := 0 to 51 do buffer[b] := '';
  if length(p1) = 0 then
  begin
    writeln(MSG03); // How to use help with command list.
    writeln;
    for b := 0 to 41 do
    begin
      buffer[b] := '  ' + COMMANDS[b];
      for bb := 0 to 6 - length(COMMANDS[b]) + 2 do
        buffer[b] := buffer[b] + ' ';
      case b of
         0: buffer[b] := buffer[b] + DES00;
         1: buffer[b] := buffer[b] + DES01;
         2: buffer[b] := buffer[b] + DES02;
         3: buffer[b] := buffer[b] + DES03;
         4: buffer[b] := buffer[b] + DES04;
         5: buffer[b] := buffer[b] + DES05;
         6: buffer[b] := buffer[b] + DES06;
         7: buffer[b] := buffer[b] + DES07;
         8: buffer[b] := buffer[b] + DES08;
         9: buffer[b] := buffer[b] + DES09;
        10: buffer[b] := buffer[b] + DES10;
        11: buffer[b] := buffer[b] + DES11;
        12: buffer[b] := buffer[b] + DES12;
        13: buffer[b] := buffer[b] + DES13;
        14: buffer[b] := buffer[b] + DES14;
        15: buffer[b] := buffer[b] + DES15;
        16: buffer[b] := buffer[b] + DES16;
        17: buffer[b] := buffer[b] + DES17;
        18: buffer[b] := buffer[b] + DES18;
        19: buffer[b] := buffer[b] + DES19;
        20: buffer[b] := buffer[b] + DES20;
        21: buffer[b] := buffer[b] + DES21;
        22: buffer[b] := buffer[b] + DES22;
        23: buffer[b] := buffer[b] + DES23;
        24: buffer[b] := buffer[b] + DES24;
        25: buffer[b] := buffer[b] + DES25;
        26: buffer[b] := buffer[b] + DES26;
        27: buffer[b] := buffer[b] + DES27;
        28: buffer[b] := buffer[b] + DES28;
        29: buffer[b] := buffer[b] + DES29;
        30: buffer[b] := buffer[b] + DES30;
        31: buffer[b] := buffer[b] + DES31;
        32: buffer[b] := buffer[b] + DES32;
        33: buffer[b] := buffer[b] + DES33;
        34: buffer[b] := buffer[b] + DES34;
        35: buffer[b] := buffer[b] + DES35;
        36: buffer[b] := buffer[b] + DES36;
        37: buffer[b] := buffer[b] + DES37;
        38: buffer[b] := buffer[b] + DES38;
        39: buffer[b] := buffer[b] + DES39;
        40: buffer[b] := buffer[b] + DES40;
        41: buffer[b] := buffer[b] + DES41;
      end;
    end;
//    shorting;
    buffer[42] := MSG24;
    line := 0;
    for b := 42 downto 0 do
    begin
      writeln(buffer[b]);
      inc(line);
      if line >= (screenheight - 6) then
      begin
        write(MSG23); readkey;
        write(#13); clreol;
        // writeln;
        line := 0;
      end;
    end;
  end else
  begin
    // CHECK P1 PARAMETER
    s1 := isitvariable(p1);
    if length(s1) = 0 then s1 := p1;
    valid := false;
    for b := 0 to 41 do
      if s1 = COMMANDS[b] then
      begin
        valid := true;
        break;
      end;
    if not valid then writeln(ERR00) else // No such command!
    begin
      // PRIMARY MISSION
      writeln(MSG04);
      gotoxy(3, wherey);
      case b of
         0: writeln(USG00);
         1: writeln(USG01);
         2: writeln(USG02);
         3: writeln(USG03);
         4: writeln(USG04);
         5: writeln(USG05);
         6: writeln(USG06);
         7: writeln(USG07);
         8: writeln(USG08);
         9: writeln(USG09);
        10: writeln(USG10);
        11: writeln(USG11);
        12: writeln(USG12);
        13: writeln(USG13);
        14: writeln(USG14);
        15: writeln(USG15);
        16: writeln(USG16);
        17: writeln(USG17);
        18: writeln(USG18);
        19: writeln(USG19);
        20: writeln(USG20);
        21: writeln(USG21);
        22: writeln(USG22);
        23: writeln(USG23);
        24: writeln(USG24);
        25: writeln(USG25);
        26: writeln(USG26);
        27: writeln(USG27);
        28: writeln(USG28);
        29: writeln(USG29);
        30: writeln(USG30);
        31: writeln(USG31);
        32: writeln(USG32);
        33: writeln(USG33);
        34: writeln(USG34);
        35: writeln(USG35);
        36: writeln(USG36);
        37: writeln(USG37);
        38: writeln(USG38);
        39: writeln(USG39);
        40: writeln(USG40);
        41: writeln(USG41);
      end;
    end;
  end;
end;
