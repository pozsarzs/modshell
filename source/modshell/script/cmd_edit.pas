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
  i1: integer; // parameter in other format
  s1: string; // parameter in other format
  b, bb: byte;
  c: char;
  en: byte;
  shift: byte = 0;
  tp: byte = 1;
  txt: string;
  x: byte;
  x1: byte = 10;
  x2: byte;

begin
  x2 := screenwidth - 1;
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
    writeln(NUM1 + MSG05 + ' 1-' + inttostr(SCRBUFFSIZE)); // What is the 1st parameter?
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  writeln(MSG39);
  writeln(MSG40);
  writeln(MSG41);
  writeln;
  x := x1;
  repeat
    txt := sbuffer[i1 - 1];
    en := length(txt);
    // write line number
    gotoxy(1, wherey); //clreol;
    textcolor(colors[1]); textbackground(colors[0]);
    write(addsomezero(4, inttostr(i1)));
    // write character number in the line
    gotoxy(6, wherey);
    textcolor(colors[1]); textbackground(colors[0]);
    write(addsomezero(3, inttostr(tp)));
    // write text
    textcolor(colors[0]); textbackground(colors[1]);
    // scrolling text in line
    if tp = x - x1 + 1 then
    begin
      gotoxy(x1, wherey); clreol;
      for b:= 1 to x2 - x1 + 1 do
        if b <= length(txt) then write(txt[b]);
    end;
    if ( x - x1 + 1 = x2 - x1 + 1) and (tp > x - x1 + 1) then
    begin
      gotoxy(x1, wherey); clreol;
      for b:= 1 + shift to x2 - x1 + 1 + shift do
        if b <= length(txt) then write(txt[b]);
    end;
    if ( x - x1 + 1 = 1 ) and (tp > x - x1 + 1) then
    begin
      gotoxy(x1, wherey); clreol;
      for b:= 1 + shift to x2 - x1 + 1 + shift do
        if b <= length(txt) then write(txt[b]);
    end;
    repeat
      if appmode = 3 then showtime(colors[0], colors[1]);
      gotoxy(x, wherey);
      delay(SHOWTIMEDELAY)
    until keypressed;
    c := readkey;
    // overwrite character
    if (c <> #0) and (c <> #27) then
    begin
      sbuffer[i1 - 1][tp] := c;
      c := #77;
    end;
    // keys with double scan-code
    if c = #0 then c := readkey;
    gotoxy(x, wherey);
    // insert or delete
    case c of
      #82: begin                                             // Ins
             insert(' ', sbuffer[i1 - 1], tp);
             c := #77;
           end;
      #83: delete(sbuffer[i1 - 1], tp, 1);                   // Del
    end;
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
      #119: begin                                            // Ctrl-Home
              tp := 1;
              x := x1;
            end;
      #115: for bb:= 1 to 10 do                              // Ctrl-Left
            begin
             if x = x1 then
               if tp > 1 then
               begin
                 dec(shift);
                 tp := x - x1 + 1 + shift;
               end;
             if x > x1 then
             begin
               dec(x);
               tp := x - x1 + 1 + shift;
             end;
           end;
      #75: begin                                             // Left 
             if x = x1 then
               if tp > 1 then
               begin
                 dec(shift);
                 tp := x - x1 + 1 + shift;
               end;
             if x > x1 then
             begin
               dec(x);
               tp := x - x1 + 1 + shift;
             end;
           end;
      #77: begin                                             // Right 
             if x = x2 then
               if tp < en then
               begin
                 inc(shift);
                 tp := x - x1 + 1 + shift;
               end;
             if x < x2 then
             begin
               inc(x);
               tp := x - x1 + 1 + shift;
             end;
           end;
      #116: for bb:= 1 to 10 do                              // Ctrl-Right
            begin
              if x = x2 then
                if tp < en then
                begin
                  inc(shift);
                  tp := x - x1 + 1 + shift;
                end;
              if x < x2 then
              begin
                inc(x);
                tp := x - x1 + 1 + shift;
              end;
            end;
      #117: for tp := tp to en do                            // Ctrl-End 
             begin
               if x = x2 then
                 if tp < en then inc(shift);
               if x < x2 then inc(x);
             end;
    end;
  until c = #27;
  writeln;
end;






