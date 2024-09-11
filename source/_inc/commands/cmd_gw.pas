{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
}

// COMMAND 'MBGW'
function cmd_mbgw(p1, p2: string): byte;
var
  i1, i2: integer; // parameters in other type
  loop: boolean;
  s: string;
  s1, s2: string; // parameters in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    {$IFNDEF X}
      writeln(ERR05); // Parameters required!
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
    s := NUM1 + MSG05; // What is the 2nd parameter?
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X}
      writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    {$IFNDEF X}
      writeln(ERR01); // Device number must be 0-7!
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
    s := NUM2 + MSG05; // What is the 2nd parameter?
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X}
      writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p2) >= 4 then i2 := strtointdef(p2[4],-1) else
  begin
    {$IFNDEF X}
      writeln(ERR01); // Device number must be 0-7!
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
