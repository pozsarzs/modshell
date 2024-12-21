{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mbmn.pas                                                             | }
{ | serial Modbus traffic monitor (same as SerialMBMonitor utility)          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1
  --------------
  mbmon   [con?]
}

// COMMAND MBMON
function cmd_mbmon(p1: string): byte;
var
  c: char;
  fpn, fp: string;
  i1: integer; // parameter in other type
  lf: textfile;
  s: string;
  s1: string; // parameter in other type
begin
  result := 0;
  {$IFDEF X}
    Form1.Memo1.Lines.Add(MSG108);
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
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + SVR;
    writeln(s);
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4], -1) else
  begin
    // Connection number must be 0-7!
    writeln(ERR03);
    result := 1;
    exit;
  end;
  if not dev[conn[i1].dev].valid then
  begin
    writeln(PREFIX[0], i1, MSG06);
    exit;
  end;
  if not (dev[conn[i1].dev].devtype = 1) then
  begin
    writeln(ERR24);
    result := 1;
    exit;
  end;
  // SET LOG FILE
  fp := vars[13].vvalue;
  ForceDirectories(fp);
  fp := fp + SLASH;
  fpn := fp + SLASH + 'mbmon.log';
  assignfile(lf, fpn);
  try
    rewrite(lf);
  except
    writeln(ERR61);
  end;
  // PRIMARY MISSION
  writeln(MSG101);
  if checklockfile(dev[conn[i1].dev].device, true) then exit;
  with dev[conn[i1].dev] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      writeln(MSG91);
      writeln;
      // write header
      if prot[conn[i1].prot].id = 0 then write('L') else write('C');
      writeln(MSG104 + MSG107);
      // write traffic
      repeat
        if keypressed then c := readkey else
        begin
          if ser.CanRead(0) then
          begin
            s := ser.RecvString(0);
            writeln(mbdecodetelegram(PROT_TYPE[prot[conn[i1].prot].prottype],
                    inttostr(prot[conn[i1].prot].id), s));
          end;    
          delay(100);
        end;
        // pause
        if c = #32 then
        begin
          write(MSG92);
          c := readkey;
          gotoxy(1,wherey); clreol;
        end;
      until c = #27;
      writeln(EOL + MSG93);
      ser_close;
    end else
    begin
      // Cannot initialize serial port!
      writeln(ERR18, dev[conn[i1].dev].device);
      result := 1;
    end;
  try
    closefile(lf);
  except
  end;
end;
