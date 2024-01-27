{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_ascii.pas                                                            | }
{ | command 'ascii'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1 
  ---------------
  ascii 
  ascii [dec|hex] 
}

// COMMAND 'ASCII'
procedure cmd_ascii(p1: string);
var
  b, bb: byte;
  col, row: byte;
  ns: byte = 2;
  valid: boolean;
const
  SPC2 = '  ';
  SPC3 = '   ';
  SPC4 = '    ';

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) > 0) then
  begin
    // CHECK P1 PARAMETER
    valid := false;
    for ns := 1 to 2 do
    if NUM_SYS[ns] = p1 then
    begin
      valid := true;
      break;
    end;
    if not valid then
    begin
      write('1st ' + MSG05); // What is the 1st parameter?
      for ns := 1 to 2 do write(' ' + NUM_SYS[ns]);
       writeln;
       exit;
     end;
  end;
  // PRIMARY MISSION
  if ns = 2 then
  begin
    col := 15; row := 7;
    write(SPC2 + SPC3);
  end else
  begin
    col := 9; row := 12;
    write(SPC3 + SPC3);
  end;
  // columns
  for bb := 0 to col do
    if ns = 2
      then write(deztohex(inttostr(bb)) + SPC3)
      else write(inttostr(bb) + SPC3);
  writeln;
  // rows
  for b := 0 to row do
  begin
    // row number
    if ns = 2
      then write(' ' + deztohex(inttostr(b)) + SPC3)
      else write(' ' + addsomezero(2, inttostr(b)) + SPC3);
    // data
    for bb := 0 to col do
      if ns = 2 then
      begin
        if ((b * 16 + bb) >= 32) and ((b * 16 + bb) <= 127) then write(chr(b * 16 + bb) + SPC3);
        if ((b * 16 + bb) <= 31) then write('^' + chr(b * 16 + bb + 64) + SPC2);
        if ((b * 16 + bb) >= 128) then write(SPC4);
      end else
      begin
        if ((b * 10 + bb) >= 32) and ((b * 10 + bb) <= 127) then write(chr(b * 10 + bb) + SPC3);
        if ((b * 10 + bb) <= 31) then write('^' + chr(b * 10 + bb + 64) + SPC2);
        if ((b * 10 + bb) >= 128) then write(SPC4);
      end;
    writeln;
  end;
end;
