{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_prop.pas                                                             | }
{ | command 'prop'                                                           | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0   p1      p2     p3     p4      p5      p6
  ---------------------------------------------------
  prop $TARGET [$]MIN [$]MAX [$]ZERO [$]SPAN [$]VALUE

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
  p4 |  x  |  x  |  x  |  x  |  x  |     |
  p5 |  x  |  x  |  x  |  x  |  x  |     |
  p6 |  x  |  x  |  x  |  x  |  x  |     |
}

function cmd_prop(p1, p2, p3, p4, p5, p6: string): byte;
var
  f2, f3, f4, f5, f6: float;
  s2, s3, s4, s5, s6: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) or (length(p6) = 0) then
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
    if not boolvalidvariablearraycell(p1) then
    begin
      // No such array cell!
      result := 1;
      exit;
    end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  // No such array cell!
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s2 := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s2 := isitvariablearray(p2)
      else result := 1;
  if result = 1 then exit;
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  // No such array cell!
  if boolisitconstantarray(p3) then
    if boolvalidconstantarraycell(p3)
      then s3 := isitconstantarray(p3)
      else result := 1;
  if boolisitvariablearray(p3) then
    if boolvalidvariablearraycell(p3)
      then s3 := isitvariablearray(p3)
      else result := 1;
  if result = 1 then exit;
  if length(s3) = 0 then s3 := p3;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  // No such array cell!
  if boolisitconstantarray(p4) then
    if boolvalidconstantarraycell(p4)
      then s4 := isitconstantarray(p4)
      else result := 1;
  if boolisitvariablearray(p4) then
    if boolvalidvariablearraycell(p4)
      then s4 := isitvariablearray(p4)
      else result := 1;
  if result = 1 then exit;
  if length(s4) = 0 then s4 := p4;
  // CHECK P5 PARAMETER
  if boolisitconstant(p5) then s5 := isitconstant(p5);
  if boolisitvariable(p5) then s5 := isitvariable(p5);
  // No such array cell!
  if boolisitconstantarray(p5) then
    if boolvalidconstantarraycell(p5)
      then s5 := isitconstantarray(p5)
      else result := 1;
  if boolisitvariablearray(p5) then
    if boolvalidvariablearraycell(p5)
      then s5 := isitvariablearray(p5)
      else result := 1;
  if result = 1 then exit;
  if length(s5) = 0 then s5 := p5;
  // CHECK P6 PARAMETER
  if boolisitconstant(p6) then s6 := isitconstant(p6);
  if boolisitvariable(p6) then s6 := isitvariable(p6);
  // No such array cell!
  if boolisitconstantarray(p6) then
    if boolvalidconstantarraycell(p6)
      then s6 := isitconstantarray(p6)
      else result := 1;
  if boolisitvariablearray(p6) then
    if boolvalidvariablearraycell(p6)
      then s6 := isitvariablearray(p6)
      else result := 1;
  if result = 1 then exit;
  if length(s6) = 0 then s6 := p6;
  // PRIMARY MISSION
  try
    f2 := strtofloatdef(s2, 0);
    f3 := strtofloatdef(s3, 0);
    f4 := strtofloatdef(s4, 0);
    f5 := strtofloatdef(s5, 0);
    f6 := strtofloatdef(s6, 0);
    if boolisitvariablearray(p1)
      then vars[intisitvariable(p1)].vvalue :=
             floattostr((((f5 - f4) / (f3 - f2)) * (f6 - f2)) + f4)
      else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
             floattostr((((f5 - f4) / (f3 - f2)) * (f6 - f2)) + f4);
  except
    // Calculating error!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR20);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR20);
    {$ENDIF}
    result := 1;
  end;
end;
