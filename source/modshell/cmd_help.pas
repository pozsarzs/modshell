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
  --------------
  help [COMMAND]
}

// command 'help'
procedure cmd_help(p1: string);
var
  b, bb: byte;
  valid: boolean;
  buffer: array[0..31] of string;


  // shorting content of buffer
  procedure shorting;
  var
   i, j: byte;
   s: string;
  begin
    for i := 0 to 30 do
     for j := i + 1 to 31 do
       if buffer[i] < buffer[j] then
       begin
         s := buffer[i];
         buffer[i] := buffer[j];
         buffer[j] := s;
       end;
  end;

begin
  for b := 0 to 31 do buffer[b] := '';
  if length(p1) = 0 then
  begin
    writeln(MSG03); // How to use help with command list.
    for b := 0 to 22 do
    begin
      buffer[b] := '  ' + COMMANDS[b];
      for bb := 0 to 5 - length(COMMANDS[b]) + 2 do
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
      end;
    end;
    shorting;
    for b := 22 downto 0 do writeln(buffer[b]);
  end else
  begin
    // check parameter
    valid := false;
    for b := 0 to 22 do
      if p1 = COMMANDS[b] then
      begin
        valid := true;
        break;
      end;
    if not valid then writeln(ERR00) else // No such command!
    begin
      // primary mission
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
      end;
    end;
  end;
end;
