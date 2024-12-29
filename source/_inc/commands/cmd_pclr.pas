{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_pclr.pas                                                             | }
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
  p0         p1                p2
  ----------------------------------------------
  printcolor [$]FOREGROUND|255 [$]BACKGROUND|255

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'PRINTCOLOR'
function cmd_printcolor(p1, p2: string): byte;
var
  i1, i2: integer; // parameters in other type
  s1, s2: string; // parameters in other type
begin
  result := 0;
  {$IFDEF X}
    Form1.Memo1.Lines.Add(MSG87);
    exit;
  {$ENDIF}
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    // Parameter(s) required!
    writeln(ERR05);
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then s1 := isitconstantarray(p1);
  if boolisitvariablearray(p1) then s1 := isitvariablearray(p1);
  if length(s1) = 0 then s1 := p1;
  i1 := strtointdef(s1, -1);
  if ((i1 < 0) or (i1 > 15)) and (i1 <> 255) then
  begin
    // What is the 1st parameter?
    if verbosity(2) then writeln(NUM1 + MSG05 + ' 0-15|255');
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
  if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
  i2 := strtointdef(s2, -1);
  if ((i2 < 0) or (i2 > 15)) and (i2 <> 255) then
  begin
    // What is the 2nd parameter?
    if verbosity(2) then writeln(NUM2 + MSG05 + ' 0-15|255');
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  if i1 <> 255 then printcolors[0] := i1 else printcolors[0] := uconfig.colors[0];
  if i2 <> 255 then printcolors[1] := i2 else printcolors[1] := uconfig.colors[1];
end;
