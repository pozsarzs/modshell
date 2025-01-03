{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  p0   p1       p2       p3
  ---------------------------
  cron [-r      rec_num]
  cron rec_num  minute   hour

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |  x  |
  p2 |     |     |     |     |  x  |     |
  p3 |     |     |     |     |  x  |     |
}

// SCRIPT RUN SCHEDULER
procedure scheduler;
var
  b: byte;
  i, h, m, s: word;
begin
  h := 0; m := 0; s := 0; i := 0;
  gettime(h, m, s, i);
  for b := 1 to 4 do
    with crontable[b] do
      if cenable then
        if (chour = h) or (chour = 255) then
          if (cminute = m) or (cminute = 255) then
            if s = 0 then
              if scriptisloaded then cmd_run('', '');
end;

// COMMAND 'CRON'
function cmd_cron(p1, p2, p3: string): byte;
const
  R: string[2] = '-r';
var
  i1, i2, i3: integer;
  b: byte;
  s: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // PRIMARY MISSION
    {$IFNDEF X}
      // header
      s := ' '; write(s);
      gotoxy(length(s) + 2, wherey); write(MSG34);
      s := s + MSG34; gotoxy(length(s) + 4, wherey); write(MSG35);
      s := s + MSG35; gotoxy(length(s) + 6, wherey); write(MSG36);
      s := s + MSG36; gotoxy(length(s) + 8, wherey); writeln(MSG37);
      // content
      for b := 1 to 4 do
        with crontable[b] do
        begin
          s := ' ';  write(s);
          gotoxy(length(s) + 2 + length(MSG34) div 2, wherey);
          write(inttostr(b));
          s := s + MSG34; gotoxy(length(s) + 4 + length(MSG35) div 2, wherey);
          if chour = 255 then write('*') else write(chour);
          s := s + MSG35; gotoxy(length(s) + 6 + length(MSG36) div 2, wherey);
          if cminute = 255 then write('*') else write(cminute);
          s := s + MSG36; gotoxy(length(s) + 8 + length(MSG37) div 2 , wherey);
          if cenable then  writeln('+') else writeln('-');
        end;
    {$ELSE}
      // header
      s := ' ' + MSG34 + #9 + MSG35 + #9 + MSG36 + #9 + MSG37;
      Form1.Memo1.Lines.Add(s);
      // content
      for b := 1 to 4 do
        with crontable[b] do
        begin
          s := ' ' + inttostr(b);
          if chour = 255
            then s := s + #9 +'*'
            else s := s  + #9 + inttostr(chour);
          if cminute = 255
            then s := s + #9 +'*'
            else s := s  + #9 + inttostr(cminute);
          if cenable
            then s := s + #9 +'+'
            else s := s + #9 +'-';
          Form1.Memo1.Lines.Add(s);
      end;
    {$ENDIF}
  end else
  begin
    if (length(p2) = 0) and (length(p3) = 0) then
      if p1 <> R then
      begin
        // What is the 2nd parameter?
        {$IFNDEF X}
          if verbosity(2) then writeln(NUM2 + MSG05 + ' ' + R);
        {$ELSE}
          Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' ' + R);
        {$ENDIF}
        result := 1;
        exit;
      end else
      begin
        // Parameter(s) required!
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR05);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR05);
        {$ENDIF}
        result := 1;
        exit;
      end;
    if (length(p2) > 0) and (length(p3) = 0) then
    begin
      // CHECK P1 PARAMETER
      if p1 <> R then
      begin
        // What is the 1st parameter?
        {$IFNDEF X}
          if verbosity(2) then writeln(NUM1 + MSG05 + ' ' + R);
        {$ELSE}
          Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' ' + R);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      i2 := strtointdef(p2, -1);
      if (i2 < 1) or (i2 > 4) then
      begin
        // What is the 2nd parameter?
        {$IFNDEF X}
          if verbosity(2) then writeln(NUM2 + MSG05 + ' 1-4');
        {$ELSE}
          Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 1-4');
        {$ENDIF}
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
        // What is the 1st parameter?
        {$IFNDEF X}
          if verbosity(2) then writeln(NUM1 + MSG05 + ' 1-4');
        {$ELSE}
          Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' 1-4');
        {$ENDIF}
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      if p2 = '*' then i2 := 255 else
      begin
        i2 := strtointdef(p2, -1);
        if (i2 < 0) or (i2 > 23) then
        begin
          // What is the 2nd parameter?
          {$IFNDEF X}
            if verbosity(2) then writeln(NUM2 + MSG05 + ' 0-23');
          {$ELSE}
            Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 0-23');
          {$ENDIF}
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
          // What is the 3rd parameter?
          {$IFNDEF X}
            if verbosity(2) then writeln(NUM3 + MSG05 + ' 0-59');
          {$ELSE}
            Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 0-59');
          {$ENDIF}
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
