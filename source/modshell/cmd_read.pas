{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_read.pas                                                             | }
{ | command 'read'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2                  p3         p4
  ---------------------------------------------------
  read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]
}

//COMMAND 'READ'
procedure cmd_read(p1, p2, p3, p4: string);
var
  i1, i3, i4: integer;     // parameters other type
  rt: byte;                // register type
  s1, s3, s4: string;      // parameters in other type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    write('1st ' + MSG05); // What is the 1nd parameter?
    writeln(' ' + PREFIX[2]+'[0-7]');
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    writeln(ERR01); // Device number must be 0-7!
    exit;
  end;
  // CHECK P2 PARAMETER
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('2nd ' + MSG05); // What is the 2nd parameter?
    for rt := 0 to 3 do write(' ' + REG_TYPE[rt]);
    writeln;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  i3 := strtointdef(s3, -1);
  if (i3 < 1) or (i3 > 9999) then
  begin
    writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
    exit;
  end;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    if boolisitconstant(p4) then s4 := isitconstant(p4);
    if boolisitvariable(p4) then s4 := isitvariable(p4);
    if length(s4) = 0 then s4 := p4;
    i4 := strtointdef(s4, -1);
    if (i4 < 1 ) or (i4 > 125) then
    begin
      writeln('4th ' + MSG05 + ' 1-125'); // What is the 3rd parameter?
      exit;
    end;
  end else i4 := 1;
  // PRIMARY MISSION
  case rt of
    0: mb_readdinp(i1, i3, i4);
    1: mb_readcoil(i1, i3, i4);
    2: mb_readireg(i1, i3, i4);
    3: mb_readhreg(i1, i3, i4);
  end;
end;
