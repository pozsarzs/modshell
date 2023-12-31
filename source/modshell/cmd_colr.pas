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
  p0    p1            p2
  ---------------------------------
  color [$]FOREGROUND [$]BACKGROUND
}

// COMMAND 'COLOR'
procedure cmd_color(p1, p2: string);
var
  i1, i2: integer; // parameters in other type
  s1, s2: string;  // parameters in other type

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0)  then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  i1 := strtointdef(s1, -1);
  if (i1 < 0) or (i1 > 15) then
  begin
    writeln('1st ' + MSG05 + ' 0-15'); // What is the 1st parameter?
    exit;
  end;
  // CHECK P2 PARAMETER
  s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  i2 := strtointdef(s2, -1);
  if (i2 < 0) or (i2 > 15) then
  begin
    writeln('2nd ' + MSG05 + ' 0-15'); // What is the 2nd parameter?
    exit;
  end;
  // PRIMARY MISSION
  uconfig.foregroundcolor := i1;
  uconfig.backgroundcolor := i2;
end;
