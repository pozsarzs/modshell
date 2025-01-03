{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_dttp.pas                                                             | }
{ | command 'datatype'                                                       | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0       p1
  ------------------
  datatype [$]VALUE

  exit code: 0: string
             1: floating-point number
             2: integer number

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'DATATYPE'
function cmd_datatype(p1: string): byte;
var
  s1: string;
begin
  // CHECK LENGTH OF PARAMETERS
  if length(p1) = 0 then
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
  // PRIMARY MISSON
  try
    strtoint(s1);
    result := 2;
    exit;
  except
    result := 0;
  end;
  try
    strtofloat(s1);
    result := 1;
    exit;
  except
    result := 0;
  end;
  result := 0;
end;
