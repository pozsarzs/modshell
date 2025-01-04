{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'PAUSE'
function cmd_pause(p1: string): byte;
var
  s1: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then readkey else
  begin
    // CHECK P1 PARAMETER
    if boolisitconstant(p1) then s1 := isitconstant(p1);
    if boolisitvariable(p1) then s1 := isitvariable(p1);
    // No such array cell!
    if boolisitconstantarray(p1) then
      if boolvalidconstantarraycell(p1)
        then s1 := isitconstantarray(p1)
        else result := 1;
    if boolisitvariablearray(p1) then
      if boolvalidvariablearraycell(p1)
        then s1 := isitvariablearray(p1)
        else result := 1;
    if result = 1 then exit;
    if length(s1) = 0 then s1 := p1;
    // PRIMARY MISSION
    if strtointdef(s1, -1) > -1 then delay(strtoint(s1) * 1000) else
    begin
      // What is the 1st parameter?
      {$IFNDEF X}
        if verbosity(2) then writeln(NUM1 + MSG05 + ' 1-65535');
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' 1-65535');
      {$ENDIF}
      result := 1;
    end;
  end;
end;
