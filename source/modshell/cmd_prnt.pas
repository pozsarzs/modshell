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
  p0    p1                  p2                p3
  -------------------------------------------------------------
  print dinp|coil|ireg|hreg ADDRESS|$VARIABLE [COUNT|$VARIABLE]
  print $VARIABLE
  print "Hello\ world!"
}

// command 'print'
procedure cmd_print(p1, p2, p3: string);
var
  i, i2, i3: integer;
  rt: byte;
  s1, s2, s3: string;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check p1 parameter: is it a message?
  s1 := isitmessage(p1);
  if length(s1) > 0 then 
  begin
    writeln(s1);
    exit;
  end;
  // check p1 parameter: is it a variable?
  s1 := isitvariable(p1);
  if length(s1) > 0 then
  begin
    writeln(s1);
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
  s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  i2 := strtointdef(s2, -1); // start address
  if (i2 < 1 ) or (i2 > 9999) then
  begin
    writeln('2nd ' + MSG05 + ' 1-9999'); // What is the 2nd parameter?
    exit;
  end;
  // check p3 parameter
  if length(p3) = 0 then i3 := 1 else
  begin
    s3 := isitvariable(p3);
    if length(s3) = 0 then s3 := p3;
    i3 := strtointdef(s3, 1); // count
  end;
  if (i3 < 1 ) or (i3 > 9999) then
  begin
    writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
    exit;
  end;
  // range check
  if (i2 + i3) > 9999 then i3 := (i2 + i3) - 9999;
  // primary mission
  for i2 := i2  to i2 + i3 - 1 do
    case rt of
      0: write(dinp[i2],' ');
      1: write(coil[i2],' ');
      2: write(ireg[i2],' ');
      3: write(hreg[i2],' ');
    end;
  writeln;
end;
