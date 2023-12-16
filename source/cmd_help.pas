{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
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
  b: byte;
  valid: boolean;

begin
  if length(p1) = 0 then
  begin
    writeln(MSG03); // How to use help with command list.
    writeln;
    for b := 0 to 12 do
    begin
      write('  ' + COMMANDS[b]);
      gotoxy(10, wherey);
      case b of
         0: writeln(DES00);
         1: writeln(DES01);
         2: writeln(DES02);
         3: writeln(DES03);
         4: writeln(DES04);
         5: writeln(DES05);
         6: writeln(DES06);
         7: writeln(DES07);
         8: writeln(DES08);
         9: writeln(DES09);
        10: writeln(DES10);
        11: writeln(DES11);
        12: writeln(DES12);
      end;
    end;
    writeln;
  end else
  begin
    // check parameter
    valid := false;
    for b := 0 to 12 do
      if p1 = COMMANDS[b] then
      begin
        valid := true;
        break;
      end;
    if not valid then writeln(ERR00) else // No such command!
    begin
      // primary mission
      writeln(MSG04);
      writeln;
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
      end;
    end;
    writeln;
  end;
end;
