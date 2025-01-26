{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_avg.pas                                                              | }
{ | command 'avg'                                                            | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0  p1      p2        p3        p4-6
  -----------------------------------------------
  avg $TARGET [$]VALUE1 [$]VALUE2 [[$]VALUE3...6]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
  p4 |  x  |  x  |  x  |  x  |  x  |     |
  p5 |  x  |  x  |  x  |  x  |  x  |     |
  p6 |  x  |  x  |  x  |  x  |  x  |     |
}

function cmd_avg(p1, p2, p3, p4, p5, p6: string): byte;
var
  count: byte = 2; // number of the input values
  b: byte;
  f: float = 0;
  s: array[2..6] of string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
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
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s[2] := isitconstant(p2);
  if boolisitvariable(p2) then s[2] := isitvariable(p2);
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s[2] := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s[2] := isitvariablearray(p2)
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
  if length(s[2]) = 0 then s[2] := p2;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s[3] := isitconstant(p3);
  if boolisitvariable(p3) then s[3] := isitvariable(p3);
  if boolisitconstantarray(p3) then
    if boolvalidconstantarraycell(p3)
      then s[3] := isitconstantarray(p3)
      else result := 1;
  if boolisitvariablearray(p3) then
    if boolvalidvariablearraycell(p3)
      then s[3] := isitvariablearray(p3)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p3);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p3);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(s[3]) = 0 then s[3] := p3;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    if boolisitconstant(p4) then s[4] := isitconstant(p4);
    if boolisitvariable(p4) then s[4] := isitvariable(p4);
    if boolisitconstantarray(p4) then
      if boolvalidconstantarraycell(p4)
        then s[4] := isitconstantarray(p4)
        else result := 1;
    if boolisitvariablearray(p4) then
      if boolvalidvariablearraycell(p4)
        then s[4] := isitvariablearray(p4)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p4);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p4);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s[4]) = 0 then s[4] := p4;
    inc(count);
  end;
  // CHECK P5 PARAMETER
  if length(p5) > 0 then
  begin
    if boolisitconstant(p5) then s[5] := isitconstant(p5);
    if boolisitvariable(p5) then s[5] := isitvariable(p5);
    if boolisitconstantarray(p5) then
      if boolvalidconstantarraycell(p5)
        then s[5] := isitconstantarray(p5)
        else result := 1;
    if boolisitvariablearray(p5) then
      if boolvalidvariablearraycell(p5)
        then s[5] := isitvariablearray(p5)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p5);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p5);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s[5]) = 0 then s[5] := p5;
    inc(count);
  end;
  // CHECK P6 PARAMETER
  if length(p6) > 0 then
  begin
    if boolisitconstant(p6) then s[6] := isitconstant(p6);
    if boolisitvariable(p6) then s[6] := isitvariable(p6);
    if boolisitconstantarray(p6) then
      if boolvalidconstantarraycell(p6) then s[6] := isitconstantarray(p6) else result := 1;
    if boolisitvariablearray(p6) then
      if boolvalidvariablearraycell(p6)
        then s[6] := isitvariablearray(p6)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p6);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p6);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s[6]) = 0 then s[6] := p6;
    inc(count);
  end;
  // PRIMARY MISSION
  try
    for b := 2 to count + 1 do
      f := f + strtofloatdef(s[b], 0);
    if boolisitvariable(p1)
      then vars[intisitvariable(p1)].vvalue := floattostr(f / count)
      else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
             floattostr(f / count);
  except
    // Calculating error!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR20);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR20);
    {$ENDIF}
  end;
end;
