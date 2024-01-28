{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_color.pas                                                            | }
{ | command 'color'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1            p2            p3              p4                 p5
  ------------------------------------------------------------------------------
  color [$]FOREGROUND [$]BACKGROUND [$]RECEIVEDTEXT [$]TRANSMITTEDTEXT [$]VARMON
}

// COMMAND 'COLOR'
function cmd_color(p1, p2, p3, p4, p5: string): byte;
var
  i1, i2, i3, i4, i5: integer; // parameters in other type
  s1, s2, s3, s4, s5: string;  // parameters in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  i1 := strtointdef(s1, -1);
  if (i1 < 0) or (i1 > 15) then
  begin
    writeln('1st ' + MSG05 + ' 0-15'); // What is the 1st parameter?
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  i2 := strtointdef(s2, -1);
  if (i2 < 0) or (i2 > 15) then
  begin
    writeln('2nd ' + MSG05 + ' 0-15'); // What is the 2nd parameter?
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  i3 := strtointdef(s3, -1);
  if (i3 < 0) or (i3 > 15) then
  begin
    writeln('3rd ' + MSG05 + ' 0-15'); // What is the 3rd parameter?
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if length(s4) = 0 then s4 := p4;
  i4 := strtointdef(s4, -1);
  if (i4 < 0) or (i4 > 15) then
  begin
    writeln('4th ' + MSG05 + ' 0-15'); // What is the 4th parameter?
    result := 1;
    exit;
  end;
  // CHECK P5 PARAMETER
  if boolisitconstant(p5) then s5 := isitconstant(p5);
  if boolisitvariable(p5) then s5 := isitvariable(p5);
  if length(s5) = 0 then s5 := p5;
  i5 := strtointdef(s5, -1);
  if (i5 < 0) or (i5 > 15) then
  begin
    writeln('5th ' + MSG05 + ' 0-15'); // What is the 5th parameter?
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  uconfig.colors[0] := i1;
  uconfig.colors[1] := i2;
  uconfig.colors[2] := i3;
  uconfig.colors[3] := i4;
  uconfig.colors[4] := i5;
end;
