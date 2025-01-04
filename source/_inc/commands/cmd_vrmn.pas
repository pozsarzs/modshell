{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_vrmn.pas                                                             | }
{ | command 'varmon'                                                         | }
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
  -----------------------
  varmon on|off
  varmon $VARIABLE on|off

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |     |     |     |  x  |
  p2 |     |     |     |     |     |  x  |
}

// SHOW VARIABLE MONITOR
procedure varmon_viewer;
var
  b: byte;
  {$IFNDEF X} x, y: byte; {$ENDIF}
begin
  if varmon then
  begin
    {$IFNDEF X}
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
    {$ELSE}
      Form2.Show;
      with Form2.ValueListEditor1 do
      begin
        Clear;
        for b := 0 to 128 do
          if not vars[b].vreadonly then
            if vars[b].vmonitored then
              if length(vars[b].vname) > 0 then
                InsertRow(vars[b].vname, vars[b].vvalue, true);
        Form1.Show;
      end;
    {$ENDIF}
  end {$IFDEF X} else Form2.Hide {$ENDIF};
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
    // show status Parameter(s) required!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
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
        if METHOD[b] = p1 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // What is the 1st parameter?
        s := NUM1 + MSG05;
        for b := 0 to 1 do s := s + ' ' + METHOD[b];
        {$IFNDEF X}
          if verbosity(2) then writeln(s);
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
        writeln(MSG32 + METHOD[b]);
      {$ELSE}
        Form1.Memo1.Lines.Add(MSG32 + METHOD[b]);
      {$ENDIF}
    end else
    begin
      // CHECK P1 PARAMETER
      if not boolisitvariable(p1) then
      begin
        // No such variable!
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR19 + p1);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR19 + p1);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // CHECK P2 PARAMETER
      valid := false;
      for b := 0 to 1 do
        if METHOD[b] = p2 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // What is the 2nd parameter?
        s := NUM2 + MSG05;
        for b := 0 to 1 do s := s + ' ' + METHOD[b];
        {$IFNDEF X}
          if verbosity(2) then writeln(s);
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
