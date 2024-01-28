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
  p0    p1                  p2         p3         p4
  ----------------------------------------------------
  print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT] [-n]
  print $VARIABLE           [-n]
  print "Hello\ world!"     [-n]
}

// COMMAND 'PRINT'
function cmd_print(p1, p2, p3, p4: string): byte;
const
  N: string[2] = '-n';
var
  i, i2, i3: integer;      // parameters in other type
  rt: byte;                // register type
  s1, s2, s3: string;      // parameters in other type
  valid: boolean = false;
  crlf: boolean = true;    // carriage return and line feed
  
begin
  result := 0;
  // SEARCH -N IN ALL PARAMETERS
  if ((length(p1) > 0) and (p1 = N)) or
     ((length(p2) > 0) and (p2 = N)) or
     ((length(p3) > 0) and (p3 = N)) or
     ((length(p4) > 0) and (p4 = N)) then crlf := false else crlf := true;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER: IS IT A MESSAGE?
  s1 := isitmessage(p1);
  if length(s1) > 0 then 
  begin
    write(s1);
    if crlf then writeln;
    exit;
  end;
  // CHECK P1 PARAMETER: IS IT A VARIABLE?
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if length(s1) > 0 then 
  begin
    write(s1);
    if crlf then writeln;
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
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
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  i2 := strtointdef(s2, -1); // start address
  if (i2 < 1 ) or (i2 > 9999) then
  begin
    writeln('2nd ' + MSG05 + ' 1-9999'); // What is the 2nd parameter?
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if length(p3) = 0 then i3 := 1 else
  begin
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
    if length(s3) = 0 then s3 := p3;
    i3 := strtointdef(s3, 1); // count
  end;
  if (i3 < 1 ) or (i3 > 9999) then
  begin
    writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
    result := 1;
    exit;
  end;
  // RANGE CHECK
  if (i2 + i3) > 9999 then i3 := (i2 + i3) - 9999;
  // PRIMARY MISSION
  for i2 := i2  to i2 + i3 - 1 do
    case rt of
      0: write(dinp[i2],' ');
      1: write(coil[i2],' ');
      2: write(ireg[i2],' ');
      3: write(hreg[i2],' ');
    end;
    if crlf then writeln;
end;
