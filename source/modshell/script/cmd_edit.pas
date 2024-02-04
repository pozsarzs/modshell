{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_edit.pas                                                             | }
{ | command 'edit'                                                           | }
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
  ------------------
  edit [LINE_NUMBER]
}

// COMMAND 'EDIT'
function cmd_edit(p1: string): byte;
var
  c: char;
  i1: integer;       // parameter in other format
  s1: string;        // parameter in other format
  cursorposx: byte = 6;

begin
  result := 0;
  if not scriptisloaded then
  begin
    writeln(MSG38);  // No script loaded.
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if length(p1) = 0 then s1 := '1' else s1 := p1;
  i1 := strtointdef(s1, -1);
  if (i1 < 1) or (i1 > SCRBUFFSIZE) then
  begin
    writeln('1st ' + MSG05 + ' 1-' + inttostr(SCRBUFFSIZE)); // What is the 1st parameter?
    result := 1;
    exit;
  end;
  writeln(MSG39);
  writeln(MSG40);
  writeln(MSG41);
  writeln;
  repeat
    gotoxy(1, wherey); clreol;
    textcolor(colors[1]); textbackground(colors[0]);
    write(addsomezero(4, inttostr(i1)));
    textcolor(colors[0]); textbackground(colors[1]);
    write(' ' + sbuffer[i1 - 1]);
    gotoxy(cursorposx, wherey);
    repeat
      if appmode = 3 then showtime(colors[0], colors[1]);
      delay(SHOWTIMEDELAY)
    until keypressed;
    c := readkey;
    if (c <> #0) and (c <> #27) then
    begin
      sbuffer[i1 - 1][cursorposx - 5] := c;
      if cursorposx < 80 then inc(cursorposx);
    end;
    if c = #0 then c := readkey;
    case c of
      // scroll lines
      #71: i1 := 1;                                          // Home
      #73: if (i1 - 10) >= 1                                 // PgUp             
           then i1 := i1 - 10 else i1 := 1;
      #72: if i1 > 1 then dec(i1);                           // Up
      #80: if i1 < scriptlastline then inc(i1);              // Down
      #81: if (i1 + 10) <= scriptlastline                    // PgDn
           then i1 := i1 + 10 else i1 := scriptlastline;
      #79: i1 := scriptlastline;                             // End
      // move in the line
      #119: cursorposx := 6;                                 // Ctrl-Home
      #115: if (cursorposx - 10) >= 6
            then dec(cursorposx) else cursorposx := 6;       // Ctrl-Left
      #75:  if cursorposx > 6 then dec(cursorposx);          // Left
      #77:  if cursorposx < 80 then inc(cursorposx);         // Right
      #116: if (cursorposx + 10) <= 80
            then dec(cursorposx) else cursorposx := 80;      // Ctrl-Right
      #117: cursorposx := 6;                                 // Ctrl-End
      // insert or delete a character
      #82:  begin                                            // Ins
              insert(' ', sbuffer[i1 - 1], cursorposx - 5);
              if cursorposx < 80 then inc(cursorposx);
            end;
      #83:  delete(sbuffer[i1 - 1], cursorposx - 5, 1);      // Del
    end;
  until c = #27;                                             // Esc
  writeln;
end;
