{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_prnt.pas                                                             | }
{ | command 'print'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1                  p2      p3
  -----------------------------------------
  print dinp|coil|ireg|hreg ADDRESS [COUNT]
}

// command 'print'
procedure cmd_print(p1, p2, p3: string);
var
  i, j: integer;
  rt: byte;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check p1 parameter
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    for i := 0 to 3 do write(' ' + REG_TYPE[i]);
    writeln;
    exit;
  end;
  // check p2 parameter
  if (strtointdef(p2, -1) < 1 ) or (strtointdef(p2, -1) > 9999) then
  begin
    writeln('2nd ' + MSG05 + ' 1-9999'); // What is the 2nd parameter?
    exit;
  end;
  // check p3 parameter
  if length(p3) = 0
  then
    j := 1
  else
    if (strtointdef(p3, -1) < 1 ) or (strtointdef(p3, -1) > 9999) then
    begin
      writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
      exit;
    end;
  // range check
  i := strtointdef(p2, -1); // start address
  j := strtointdef(p3, -1); // count
  if (i + j) > 9999 then j := (i + j) - 9999;
  // primary mission
  for i := i  to i + j - 1 do
    case rt of
      0: write(dinp[i],' ');
      1: write(coil[i],' ');
      2: write(ireg[i],' ');
      3: write(hreg[i],' ');
    end;
  writeln;
end;
