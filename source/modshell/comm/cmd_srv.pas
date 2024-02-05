{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_mbsrv.pas                                                            | }
{ | command 'mbsrv'                                                          | }
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
  ----------
  mbsrv con?
}

// COMMAND 'MBSRW'
function cmd_mbsrv(p1: string): byte;
var
  i1: integer; // parameter in other type
  s1: string; // parameter in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    write(NUM1 + MSG05); // What is the 1st parameter?
    writeln(' ' + PREFIX[2] + '[0-7]');
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    writeln(ERR01); // Device number must be 0-7!
    result := 1;
    exit;
  end;
  // PRIMARY MISSION

end;
