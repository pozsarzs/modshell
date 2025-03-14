{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_gw.pas                                                               | }
{ | command 'mbgw'                                                           | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0   p1   p2
  --------------
  mbgw con? con?

     | var |const|varr |carr |text |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
  p2 |     |     |     |     |     |  x  |
}

// COMMAND 'MBGW'
function cmd_mbgw(p1, p2: string): byte;
var
  i1, i2: integer;
  loop: boolean;
  s: string;
  s1, s2: string;
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
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 2nd parameter?
    s := NUM1 + MSG05; 
    s := s + ' ' + PREFIX[2] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4], -1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR01);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR01);
    {$ENDIF}
    result := 1;
    exit;
  end;
  s2 := p2;
  delete(s2, length(s2), 1);
  // CHECK P2 PARAMETER
  if PREFIX[2] <> s2 then
  begin
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    s := s + ' ' + PREFIX[2] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p2) >= 4 then i2 := strtointdef(p2[4], -1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR01);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR01);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  repeat
    loop := mb_gateway(i1, i2);
  until loop = false;
end;
