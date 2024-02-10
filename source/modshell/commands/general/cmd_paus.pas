{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_paus.pas                                                             | }
{ | command 'pause'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1
  ---------------
  pause [[$]TIME]
  pause [[$]TIME]
}

// COMMAND 'PAUSE'
function cmd_pause(p1: string): byte;
var
  s1: string; // parameter in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then readkey else
  begin
    // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
    if length(s1) = 0 then s1 := p1;
    // PRIMARY MISSION
    if strtointdef(s1, -1) > -1 then delay(strtoint(s1) * 1000) else
    begin
      writeln(NUM1 + MSG05 + ' 1-65535'); // What is the 1st parameter?
      result := 1;
    end;
  end;
end;
