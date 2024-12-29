{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_tcrd.pas                                                             | }
{ | command 'tcpread'                                                        | }
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
  tcpread dev? [$TARGET]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
  p2 |  x  |     |  x  |     |     |     |
}

// COMMAND 'TCPREAD'
function cmd_tcpread(p1, p2: string): byte;
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
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
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
       i1 := strtointdef(p1[4], -1);
       if (i1 >= 0) and (i1 < 8) then valid := true;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    ss := NUM1 + MSG05;
    ss := ss + ' ' + PREFIX[0] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(ss);
    {$ELSE}
      Form1.Memo1.Lines.Add(ss);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if not dev[i1].valid then
  begin
    {$IFNDEF X}
      if verbosity(2) then writeln(PREFIX[0], i1, MSG06);
    {$ELSE}
      Form1.Memo1.Lines.Add(PREFIX[0] + inttostr(i1) + MSG06);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if not (dev[i1].devtype = 0) then
  begin
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR25);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR25);
    {$ENDIF}
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
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR19 + p2);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR19 + p2);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if tcp_open(ipaddress, inttostr(port)) then
    begin
      {$IFNDEF X} writeln(MSG31); {$ENDIF}
      repeat
        sleep(10);
        if tcp_canread then
        begin
          wait := 0;
          b := tcp_recvbyte;
          // echo method
          {$IFNDEF X}
            textcolor(uconfig.colors[2]);
            case uconfig.echometh of
              1: write(char(b));
              2: write(addsomezero(2, deztohex(inttostr(b))) + ' ');
            end;
            textcolor(uconfig.colors[0]);
          {$ELSE}
            case uconfig.echometh of
              1: Form1.Memo1.Text := Form1.Memo1.Text + char(b);
              2: Form1.Memo1.Text := Form1.Memo1.Text + addsomezero(2, deztohex(inttostr(b))) + ' ';
            end;
          {$ENDIF}
          s := s + char(b);
          if (uconfig.echometh = 1) and (b = 13) then
          begin
            {$IFNDEF X} write(EOL); {$ELSE} Form1.Memo1.Text := Form1.Memo1.Text + EOL; {$ENDIF}
          end;
        end else
          if wait < 6000 then inc(wait);
        {$IFNDEF X} if keypressed then c := readkey; {$ENDIF}
      until {$IFNDEF X} (c = #27) or {$ENDIF} (length(s) = 255) or (wait = timeout * 100);
      tcp_close;
      if (uconfig.echometh > 0)
        then {$IFNDEF X} writeln; {$ELSE} Form1.Memo1.Lines.Add(''); {$ENDIF}      
      if length(p2) = 0 then {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      if length(p2) > 0 then
        if boolisitvariable(p2)
          then vars[intisitvariable(p2)].vvalue := s
          else arrays[intisitvariablearray(p2)].aitems[intisitvariablearrayelement(p1)] := s;
    end else
    begin
      // Cannot initialize socket!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR58);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR58);
      {$ENDIF}
      result := 1;
    end;
end;
