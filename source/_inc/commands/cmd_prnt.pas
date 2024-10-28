{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  crlf: boolean = true; // carriage return and line feed
  i, i2, i3: integer; // parameters in other type
  rt: byte; // register type
  s1, s2, s3: string; // parameters in other type
  s: string;
  valid: boolean = false;
begin
  result := 0;
  // SEARCH -n IN ALL PARAMETERS
  if ((length(p1) > 0) and (p1 = N)) or
     ((length(p2) > 0) and (p2 = N)) or
     ((length(p3) > 0) and (p3 = N)) or
     ((length(p4) > 0) and (p4 = N)) then crlf := false else crlf := true;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER: IS IT A MESSAGE?
  s1 := isitmessage(p1);
  s := '';
  if length(s1) > 0 then 
  begin
    {$IFNDEF X}
      write(s1);
      if crlf then writeln;
    {$ELSE}
      s := s + s1;
      if crlf then Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    exit;
  end;
  // CHECK P1 PARAMETER: IS IT A VARIABLE?
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then s1 := isitconstantarray(p1);
  if boolisitvariablearray(p1) then s1 := isitvariablearray(p1);
  s := '';
  if length(s1) > 0 then 
  begin
    {$IFNDEF X}
      write(s1);
      if crlf then writeln;
    {$ELSE}
      s := s + s1;
      if crlf then Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER IS IT A REGISTER?
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for i := 0 to 3 do s := s + ' ' + REG_TYPE[i];
    s := s + MSG83 + MSG84 + '.';
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if length(p2) = 0 then i2 := 1 else
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
    i2 := strtointdef(s2, 1); // start address
  end;
  if (i2 < 1 ) or (i2 > 9999) then
  begin
    // What is the 2nd parameter?
    {$IFNDEF X} writeln(NUM2 + MSG05 + ' 1-9999'); {$ELSE} Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 1-9999'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if length(p3) = 0 then i3 := 1 else
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
    if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
    if length(s3) = 0 then s3 := p3;
    i3 := strtointdef(s3, 1); // count
  end;
  if (i3 < 1 ) or (i3 > 9999) then
  begin
    // What is the 2nd parameter?
    {$IFNDEF X} writeln(NUM3 + MSG05 + ' 1-9999'); {$ELSE} Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 1-9999'); {$ENDIF}
    result := 1;
    exit;
  end;
  // RANGE CHECK
  if (i2 + i3) > 9999 then i3 := (i2 + i3) - 9999;
  // PRIMARY MISSION
  s := '';
  for i2 := i2  to i2 + i3 - 1 do
    case rt of
      0: {$IFNDEF X} write(dinp[i2], ' '); {$ELSE} s := s + booltostr(dinp[i2]) + ' '; {$ENDIF}
      1: {$IFNDEF X} write(coil[i2], ' '); {$ELSE} s := s + booltostr(coil[i2]) + ' '; {$ENDIF}
      2: {$IFNDEF X} write(ireg[i2], ' '); {$ELSE} s := s + inttostr(ireg[i2]) + ' '; {$ENDIF}
      3: {$IFNDEF X} write(hreg[i2], ' '); {$ELSE} s := s + inttostr(hreg[i2]) + ' '; {$ENDIF}
    end;
    {$IFNDEF X} if crlf then writeln; {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
end;
