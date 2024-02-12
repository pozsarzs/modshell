{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_cron.pas                                                             | }
{ | command 'cron'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1       p2     p3
  -------------------------
  cron [-r      rec_num]
  cron rec_num  minute hour
}

// SCRIPT RUN SCHEDULER
procedure scheduler;
var
  b: byte;
  i, h, m, s: word;

begin
  gettime(h, m, s, i);
  for b := 1 to 4 do
    with crontable[b] do
      if cenable then
        if (chour = h) or (chour = 255) then
          if (cminute = m) or (cminute = 255) then
            if s = 0 then
              if scriptisloaded then cmd_run('');
end;

// COMMAND 'CRON'
function cmd_cron(p1, p2, p3: string): byte;
const
  R: string[2] = '-r';
var
  i1, i2, i3: integer;  // parameters in other type
  b: byte;
  s: string;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // PRIMARY MISSION
    s := ' '; write(s);
    gotoxy(length(s) + 2, wherey); write(MSG34);
    s := s + MSG34; gotoxy(length(s) + 4, wherey); write(MSG35);
    s := s + MSG35; gotoxy(length(s) + 6, wherey); write(MSG36);
    s := s + MSG36; gotoxy(length(s) + 8, wherey); writeln(MSG37);
    for b := 1 to 4 do
      with crontable[b] do
      begin
        s := ' ';  write(s);
        gotoxy(length(s) + 2 + length(MSG34) div 2, wherey); write(inttostr(b));
        s := s + MSG34; gotoxy(length(s) + 4 + length(MSG35) div 2, wherey);
        if chour = 255 then  write('*') else write(chour);
        s := s + MSG35; gotoxy(length(s) + 6 + length(MSG36) div 2, wherey);
        if cminute = 255 then  write('*') else write(cminute);
        s := s + MSG36; gotoxy(length(s) + 8 + length(MSG37) div 2 , wherey);
        if cenable then  writeln('+') else writeln('-');
      end;
  end else
  begin
    if (length(p2) = 0) and (length(p3) = 0) then
      if p1 <> R then
      begin
        writeln(NUM1 + MSG05 + ' ' + R); // What is the 2nd parameter?
        result := 1;
        exit;
      end else
      begin
        writeln(ERR05); // Parameters required!
        result := 1;
        exit;
      end;
    if (length(p2) > 0) and (length(p3) = 0) then
    begin
      // CHECK P1 PARAMETER
      if p1 <> R then
      begin
        writeln(NUM1 + MSG05 + ' ' + R); // What is the 1st parameter?
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      i2 := strtointdef(p2, -1);
      if (i2 < 1) or (i2 > 4) then
      begin
        writeln(NUM2 + MSG05 + ' 1-4'); // What is the 2nd parameter?
        result := 1;
        exit;
      end;
      // PRIMARY MISSION
      with crontable[i2] do
      begin
        chour := 0;
        cminute := 0;
        cenable := false;
      end;
    end;
    if (length(p2) > 0) and (length(p3) > 0) then
    begin
      // CHECK P1 PARAMETER
      i1 := strtointdef(p1, -1);
      if (i1 < 1) or (i1 > 4) then
      begin
        writeln(NUM1 + MSG05 + ' 1-4'); // What is the 2nd parameter?
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      if p2 = '*' then i2 := 255 else
      begin
        i2 := strtointdef(p2, -1);
        if (i2 < 0) or (i2 > 23) then
        begin
          writeln(NUM2 + MSG05 + ' 0-23'); // What is the 2nd parameter?
          result := 1;
          exit;
        end;
      end;
      // CHECK P3 PARAMETER
      if p3 = '*' then i3 := 255 else
      begin
        i3 := strtointdef(p3, -1);
        if (i3 < 0) or (i3 > 59) then
        begin
          writeln(NUM3 + MSG05 + ' 0-59'); // What is the 3rd parameter?
          result := 1;
          exit;
        end;
      end;
      // PRIMARY MISSION
      with crontable[i1] do
      begin
        chour := i2;
        cminute := i3;
        cenable := true;
      end;
    end;
  end;
end;
