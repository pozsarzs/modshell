{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_serd.pas                                                             | }
{ | command 'serread'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1   p2
  -----------------------
  serread dev? [$TARGET]
}

// COMMAND 'SERREAD'
function cmd_serread(p1, p2: string): byte;
var
  b: byte;
  {$IFNDEF X} c: char; {$ENDIF}
  i1: integer; // parameters other type
  s: string = '';
  ss: string;
  s1: string; // parameters in other type
  valid: boolean = false;
  wait: integer = 0;
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
    ss := NUM1 + MSG05;
    ss := ss + ' ' + PREFIX[0] + '[0-7]';
    {$IFNDEF X} writeln(ss); {$ELSE} Form1.Memo1.Lines.Add(ss); {$ENDIF}
    result := 1;
    exit;
  end;
  if not dev[i1].valid then
  begin
    {$IFNDEF X} writeln(PREFIX[0], i1, MSG06); {$ELSE} Form1.Memo1.Lines.Add(PREFIX[0] + inttostr(i1) + MSG06); {$ENDIF}
    result := 1;
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    {$IFNDEF X} writeln(MSG24); {$ELSE} Form1.Memo1.Lines.Add(MSG24); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
    if (not boolisitvariable(p2)) and
       (not boolisitvariablearray(p2)) then
    begin
      // No such variable!
      {$IFNDEF X} writeln(ERR19 + p2); {$ELSE} Form1.Memo1.Lines.Add(ERR19 + p2); {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  if checklockfile(dev[i1].device, true) then exit;
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      {$IFNDEF X} writeln(MSG31); {$ENDIF}
      repeat
        sleep(10);
        if ser_canread then
        begin
          wait := 0;
          b := ser_recvbyte;
          {$IFNDEF X}
            textcolor(uconfig.colors[2]);
            case uconfig.echo of
              1: write(char(b));
              2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
            end;
            textcolor(uconfig.colors[0]);
          {$ELSE}
            case uconfig.echo of
              1: Form1.Memo1.Text := Form1.Memo1.Text + char(b);
              2: Form1.Memo1.Text := Form1.Memo1.Text + addsomezero(2, deztohex(inttostr(b))) + ' ';
            end;
          {$ENDIF}
          s := s + char(b);
          if (uconfig.echo = 1) and (b = 13) then
          begin
            {$IFNDEF X} write(EOL); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + EOL; {$ENDIF}
          end;
        end else
          if wait < 6000 then inc(wait);
        {$IFNDEF X} if keypressed then c := readkey; {$ENDIF}
      until {$IFNDEF X} (c = #27) or {$ENDIF} (length(s) = 255) or (wait = timeout * 100);
      ser_close;
      if (uconfig.echo > 0)
        then {$IFNDEF X} writeln; {$ELSE} Form1.Memo1.Lines.Add(''); {$ENDIF}      
      if length(p2) = 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      if length(p2) > 0 then
        if boolisitvariable(p2)
          then vars[intisitvariable(p2)].vvalue := s
          else arrays[intisitvariablearray(p2)].aitems[intisitvariablearrayelement(p1)] := s;
    end else
    begin
      // Cannot initialize serial port!
      {$IFNDEF X} writeln(ERR18, dev[i1].device); {$ELSE} Form1.Memo1.Lines.Add(ERR18 + dev[i1].device); {$ENDIF}
      result := 1;
    end;
end;
