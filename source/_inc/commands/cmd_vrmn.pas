{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_vrmn.pas                                                             | }
{ | command 'vrmn'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1         p2
  --------------------------
  varmon on|off
  varmon $VARIABLE1 on|off
}

// SHOW VARIABLE MONITOR
procedure varmon_viewer;
var
  b, x, y: byte;
  
begin
  if varmon then
  begin
    x := wherex;
    y := wherey;
    gotoxy(1,1);
    textcolor(uconfig.colors[4]);
    for b := 0 to 128 do
      if not vars[b].vreadonly then
        if vars[b].vmonitored then
          if length(vars[b].vname) > 0 then
            write (' ' + vars[b].vname + '=' + vars[b].vvalue + ' ');
    clreol;
    textcolor(uconfig.colors[0]);
    gotoxy(x, y);
  end;
end;

// COMMAND 'VARMON'
function cmd_varmon(p1, p2: string): byte;
var
  b: byte;
  valid: boolean;
  s: string;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    {$IFNDEF X}
      writeln(ERR05); // Parameters required!
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end else
    if length(p2) = 0 then
    begin
      // CHECK P1 PARAMETER
      valid := false;
      for b := 0 to 1 do
        if ECHO_ARG[b] = p1 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        s := NUM1 + MSG05; // What is the 1st parameter?
        for b := 0 to 1 do s := s + ' ' + ECHO_ARG[b];
        {$IFNDEF X}
          writeln(s);
        {$ELSE}
          Form1.Memo1.Lines.Add(s);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // PRIMARY MISSION
      // on/off variable monitor
      varmon := inttobool(b);
      {$IFNDEF X}
        writeln(MSG32 + ECHO_ARG[b]);
      {$ELSE}
        Form1.Memo1.Lines.Add(MSG32 + ECHO_ARG[b]);
      {$ENDIF}
    end else
    begin
      // CHECK P1 PARAMETER
      if not boolisitvariable(p1) then
      begin
        {$IFNDEF X}
          writeln(ERR19 + p1); // No such variable
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR19 + p1);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      valid := false;
      for b := 0 to 1 do
        if ECHO_ARG[b] = p2 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        s := NUM2 + MSG05; // What is the 2nd parameter?
        for b := 0 to 1 do s := s + ' ' + ECHO_ARG[b];
        {$IFNDEF X}
          writeln(s);
        {$ELSE}
          Form1.Memo1.Lines.Add(s);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // PRIMARY MISSION
      // on/off monitoring specfied variable
      vars[intisitvariable(p1)].vmonitored := inttobool(b);
    end;
end;
