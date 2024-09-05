{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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
}

function cmd_avg(p1, p2, p3, p4, p5, p6: string): byte;
var
  b: byte;
  f: float = 0;
  s: array[2..6] of string; // parameters in other type
  count: byte = 2; // number of the input values

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    writeln(ERR19 + p1); // No such variable
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s[2] := isitconstant(p2);
  if boolisitvariable(p2) then s[2] := isitvariable(p2);
  if length(s[2]) = 0 then s[2] := p2;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s[3] := isitconstant(p3);
  if boolisitvariable(p3) then s[3] := isitvariable(p3);
  if length(s[3]) = 0 then s[3] := p3;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    if boolisitconstant(p4) then s[4] := isitconstant(p4);
    if boolisitvariable(p4) then s[4] := isitvariable(p4);
    if length(s[4]) = 0 then s[4] := p4;
    inc(count);
  end;
  // CHECK P5 PARAMETER
  if length(p5) > 0 then
  begin
    if boolisitconstant(p5) then s[5] := isitconstant(p5);
    if boolisitvariable(p5) then s[5] := isitvariable(p5);
    if length(s[5]) = 0 then s[5] := p5;
    inc(count);
  end;
  // CHECK P6 PARAMETER
  if length(p6) > 0 then
  begin
    if boolisitconstant(p6) then s[6] := isitconstant(p6);
    if boolisitvariable(p6) then s[6] := isitvariable(p6);
    if length(s[6]) = 0 then s[6] := p6;
    inc(count);
  end;
  // PRIMARY MISSION
  try
    for b := 2 to count + 1 do
      f := f + strtofloatdef(s[b], 0);
    vars[intisitvariable(p1)].vvalue := floattostr(f / count);
  except
    writeln(ERR20);
  end;
end;
