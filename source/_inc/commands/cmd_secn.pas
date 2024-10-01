{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
function cmd_sercons(p1: string): byte;
var
  b: byte;
  c: char;
  fpn, fp: string;
  i1: integer; // parameters other type
  lf: file of char;
  s1: string; // parameters in other type
  s: string;
  valid: boolean = false;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
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
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[0] + '[0-7]';
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  if not dev[i1].valid then
  begin
    {$IFNDEF X} writeln(PREFIX[0], i1, MSG06); {$ELSE} Form1.Memo1.Lines.Add(PREFIX[0] + inttostr(i1) + MSG06); {$ENDIF}
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    {$IFNDEF X} writeln(MSG24); {$ELSE} Form1.Memo1.Lines.Add(MSG24); {$ENDIF}
    result := 1;
    exit;
  end;
  // SET LOG FILE
  {$IFDEF GO32V2}
    fp := getexedir + proj;
    createdir(fp);
  {$ELSE}
    fp := getuserdir + PRGNAME;
    createdir(fp);
    fp := getuserdir + PRGNAME + SLASH + proj;
    createdir(fp);
  {$ENDIF}
  fpn := fp + SLASH + 'console.log';
  assignfile(lf, fpn);
  try
    rewrite(lf);
  except
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      {$IFNDEF X} writeln(MSG31); {$ELSE} Form1.Memo1.Lines.Add(MSG31); {$ENDIF}
      repeat
        if {$IFNDEF X} keypressed {$ELSE} pressakey {$ENDIF} then
        begin
          {$IFNDEF X}
            c := readkey;
          {$ELSE}
            pressakey := false;
            c := pressedkey;
          {$ENDIF}
          if ser_canwrite then
          begin
            ser_sendstring(c);
            {$IFNDEF X} textcolor(uconfig.colors[3]); {$ENDIF}
            {$IFNDEF X} write(c); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + c; {$ENDIF}
            try
              write(lf, c);
            except
            end;
            if c = #13 then {$IFNDEF X} write(EOL); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + EOL; {$ENDIF}
            {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
          end else {$IFNDEF X} writeln(MSG27); {$ELSE} Form1.Memo1.Lines.Add(MSG27); {$ENDIF}
        end;
        if ser_canread then
        begin
          b := ser_recvbyte;
          {$IFNDEF X} textcolor(uconfig.colors[2]); {$ENDIF}
          {$IFNDEF X} write(char(b)); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + char(b); {$ENDIF}
          try
            write(lf, char(b));
          except
          end;
          if b = 13 then write(EOL);
          {$IFNDEF X} textcolor(uconfig.colors[0]); {$ENDIF}
        end;
      until c = #27;
      ser_close;
      {$IFNDEF X} write(EOL); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + EOL; {$ENDIF}      
    end else
    begin
      // Cannot initialize serial port!
      {$IFNDEF X} writeln(ERR18, dev[i1].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[i1].device); {$ENDIF}
      result := 1;
    end;
    try
      closefile(lf);
    except
    end;
end;
