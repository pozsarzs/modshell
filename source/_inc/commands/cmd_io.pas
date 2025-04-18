{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_io.pas                                                               | }
{ | direct I/O access commands                                               | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0      p1      p2
  -----------------------
  ioread  [$]BYTE [$]PORT
  iowrite [$]PORT [$]BYTE

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// DIRECT I/O ACCESS COMMANDS  
function cmd_io(op: byte; p1, p2: string): byte;
var
  s1: string = '';
  s2: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
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
  if op = 125 then
  begin
    if (not boolisitvariable(p1)) and
       (not boolisitvariablearray(p1)) then
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
    if boolisitvariablearray(p1) then
      if not boolvalidvariablearraycell(p1) then result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p1);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p1);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end else
  begin
    if boolisitconstant(p1) then s1 := isitconstant(p1);
    if boolisitvariable(p1) then s1 := isitvariable(p1);
    if boolisitconstantarray(p1) then
      if boolvalidconstantarraycell(p1)
        then s1 := isitconstantarray(p1)
        else result := 1;
    if boolisitvariablearray(p1) then
      if boolvalidvariablearraycell(p1)
        then s1 := isitvariablearray(p1)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p1);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p1);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s1) = 0 then s1 := p1;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s2 := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s2 := isitvariablearray(p2)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p2);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p2);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(s2) = 0 then s2 := p2;
  // PRIMARY MISSION
  try
    case op of
      125: if boolisitvariable(p1)
           then vars[intisitvariable(p1)].vvalue :=
                  inttostr(readbytefromioport(strtoint(s2)))
           else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(readbytefromioport(strtoint(s2)));
      126: result := writebytetoioport(strtoint(s1), strtoint(s2));
    end;
  except
    // Operating error
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR48);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR48);
    {$ENDIF}
    result := 1;
  end;
end;
