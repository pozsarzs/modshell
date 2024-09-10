{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_asci.pas                                                             | }
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
function cmd_ascii(p1: string): byte;
var
  b, bb: byte;
  col, row: byte;
  ns: byte = 2;
  s: string = '';
  valid: boolean;
const
  SPC2 = '  ';
  SPC3 = '   ';
  SPC4 = '    ';

begin
  result := 0;
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
      s := NUM1 + MSG05; // What is the 1st parameter?
      for ns := 1 to 2 do s := s + ' ' + NUM_SYS[ns];
      {$IFNDEF X}
        writeln(s);
      {$ELSE}
        Form1.Memo1.Lines.Add(s);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  if ns = 2 then
  begin
    col := 15; row := 7;
    {$IFNDEF X}
      write(SPC3);
    {$ELSE}
      s := SPC3;
    {$ENDIF}
  end else
  begin
    col := 9; row := 12;
    {$IFNDEF X}
      write(SPC2 + SPC2);
    {$ELSE}
      s := SPC2 + SPC2;
    {$ENDIF}
  end;
  {$IFNDEF X}
    // columns
    textcolor(colors[1]); textbackground(colors[0]);
    for bb := 0 to col do
      if ns = 2
        then write(deztohex(inttostr(bb)) + SPC3)
        else write(inttostr(bb) + SPC3);
    textcolor(colors[0]); textbackground(colors[1]);
    writeln;
    // rows
    for b := 0 to row do
    begin
      // row number
      if ns = 2 then
      begin
        textcolor(colors[1]); textbackground(colors[0]);
        write(deztohex(inttostr(b)));
        textcolor(colors[0]); textbackground(colors[1]);
        write(SPC2);
      end else
      begin
        textcolor(colors[1]); textbackground(colors[0]);
        write(addsomezero(2, inttostr(b)));
        textcolor(colors[0]); textbackground(colors[1]);
        write(SPC2);
      end;
      // data
      for bb := 0 to col do
        if ns = 2 then
        begin
          if ((b * 16 + bb) >= 32) and ((b * 16 + bb) < 127) then write(chr(b * 16 + bb) + SPC3);
          if ((b * 16 + bb) <= 31) then write('^' + chr(b * 16 + bb + 64) + SPC2);
          if ((b * 16 + bb) = 127) then write('DEL');
          if ((b * 16 + bb) >= 128) then write(SPC4);
        end else
        begin
          if ((b * 10 + bb) >= 32) and ((b * 10 + bb) < 127) then write(chr(b * 10 + bb) + SPC3);
          if ((b * 10 + bb) <= 31) then write('^' + chr(b * 10 + bb + 64) + SPC2);
          if ((b * 10 + bb) = 127) then write('DEL');
          if ((b * 10 + bb) >= 128) then write(SPC4);
        end;
      writeln;
    end;
  {$ELSE}
    // columns
    for bb := 0 to col do
      if ns = 2
        then s := s + deztohex(inttostr(bb)) + SPC3
        else s := s + inttostr(bb) + SPC3;
    Form1.Memo1.Lines.Add(s);
    // rows
    for b := 0 to row do
    begin
      s := '';
      // row number
      if ns = 2 then
        s := s + deztohex(inttostr(b)) + SPC2 else
        s := s + addsomezero(2, inttostr(b)) + SPC2;
      // data
      for bb := 0 to col do
        if ns = 2 then
        begin
          if ((b * 16 + bb) >= 32) and ((b * 16 + bb) < 127) then s := s + chr(b * 16 + bb) + SPC3;
          if ((b * 16 + bb) <= 31) then  s := s + '^' + chr(b * 16 + bb + 64) + SPC2;
          if ((b * 16 + bb) = 127) then  s := s + 'DEL';
          if ((b * 16 + bb) >= 128) then  s := s + SPC4;
        end else
        begin
          if ((b * 10 + bb) >= 32) and ((b * 10 + bb) < 127) then  s := s + chr(b * 10 + bb) + SPC3;
          if ((b * 10 + bb) <= 31) then  s := s + '^' + chr(b * 10 + bb + 64) + SPC2;
          if ((b * 10 + bb) = 127) then  s := s + 'DEL';
          if ((b * 10 + bb) >= 128) then  s := s + SPC4;
        end;
      Form1.Memo1.Lines.Add(s);
    end;
  {$ENDIF}
end;
