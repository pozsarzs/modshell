{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_tccn.pas                                                             | }
{ | command 'tcpcons'                                                        | }
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
  --------------
  tcpcons [dev?]
}

// COMMAND 'TCPCONS'
function cmd_tcpcons(p1: string): byte;
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
  {$IFDEF X}
    Form1.Memo1.Lines.Add(MSG88);
    exit;
  {$ENDIF}
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    writeln(ERR05);
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
    writeln(s);
    result := 1;
    exit;
  end;
  if not dev[i1].valid then
  begin
    writeln(PREFIX[0], i1, MSG06);
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    writeln(MSG24);
    result := 1;
    exit;
  end;
  // SET LOG FILE
  fp := vars[13].vvalue;
  ForceDirectories(fp);
  fp := fp + SLASH;
  fpn := fp + SLASH + 'console.log';
  assignfile(lf, fpn);
  try
    rewrite(lf);
  except
    writeln(ERR50);
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if tcp_open(ipaddress, inttostr(port)) then
    begin
      writeln(MSG31);
      repeat
        if  keypressed then
        begin
          c := readkey;
          if tcp_canwrite then
          begin
            tcp_sendstring(c);
            textcolor(uconfig.colors[3]);
            write(c);
            try
              write(lf, c);
            except
            end;
            if c = #13 then write(EOL);
            textcolor(uconfig.colors[0]);
          end else writeln(ERR27);
        end;
        if tcp_canread then
        begin
          b := tcp_recvbyte;
          textcolor(uconfig.colors[2]);
          write(char(b));
          try
            write(lf, char(b));
          except
          end;
          if b = 13 then write(EOL);
          textcolor(uconfig.colors[0]);
        end;
      until c = #27;
      tcp_close;
      writeln(EOL);
    end else
    begin
      // Cannot initialize network decice!
      writeln(ERR58, dev[i1].device);
      result := 1;
    end;
  try
    closefile(lf);
  except
  end;
end;