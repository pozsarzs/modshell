{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  p0    p1                           p2         p3         p4
  -------------------------------------------------------------
  print dinp|coil|ireg|hreg          [$]ADDRESS [[$]COUNT] [-n]
  print $VARIABLE                    [-n]
  print "Hello\ world!"              [-n]
  print "^[1;31mHello\ world!^[1;0m" [-n]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |  x  |
  p2 |  x  |  x  |  x  |  x  |  x  |  x  |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
  p4 |     |     |     |     |     |  x  |
}

// COMMAND 'PRINT'
function cmd_print(p1, p2, p3, p4: string): byte;
const
  N: string[2] = '-n';
var
  crlf: boolean = true; // carriage return and line feed
  i, i2, i3: integer;
  rt: byte; // register type
  s1, s2, s3: string;
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
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER: IS IT A MESSAGE?
  s1 := isitmessage(p1);
  s := '';
  // PRIMARY MISSION
  if length(s1) > 0 then 
  begin
    {$IFNDEF X}
      textcolor(printcolors[0]);
      textbackground(printcolors[1]);
      write(s1);
      textcolor(uconfig.colors[0]);
      textbackground(uconfig.colors[1]);
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
  if boolisitconstantarray(p1) then
    if boolvalidconstantarraycell(p1)
      then s1 := isitconstantarray(p1)
      else result := 1;
  if boolisitvariablearray(p1) then
    if boolvalidvariablearraycell(p1)
      then s1 := isitvariablearray(p1)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
  s := '';
  // PRIMARY MISSION
  if length(s1) > 0 then 
  begin
    {$IFNDEF X}
      textcolor(printcolors[0]);
      textbackground(printcolors[1]);
      write(s1);
      textcolor(uconfig.colors[0]);
      textbackground(uconfig.colors[1]);
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
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if length(p2) = 0 then i2 := 1 else
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then
      if boolvalidconstantarraycell(p2)
        then s2 := isitconstantarray(p2)
        else result := 1;
    if boolisitvariablearray(p2) then
      if boolvalidvariablearraycell(p2)
        then s2 := isitvariablearray(p2)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p2);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p2);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s2) = 0 then s2 := p2;
    i2 := strtointdef(s2, 1); // start address
  end;
  if (i2 < 0 ) or (i2 > 9998) then
  begin
    // What is the 2nd parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM2 + MSG05 + AVR);
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM2 + MSG05 + AVR);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if length(p3) = 0 then i3 := 1 else
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then
      if boolvalidconstantarraycell(p3)
        then s3 := isitconstantarray(p3)
        else result := 1;
    if boolisitvariablearray(p3) then
      if boolvalidvariablearraycell(p3)
        then s3 := isitvariablearray(p3)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p3);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p3);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s3) = 0 then s3 := p3;
    i3 := strtointdef(s3, 1); // count
  end;
  if (i3 < 0 ) or (i3 > 9998) then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM3 + MSG05 + AVR);
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM3 + MSG05 + AVR);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // RANGE CHECK
  if (i2 + i3) > 9998 then i3 := (i2 + i3) - 9998;
  // PRIMARY MISSION
  s := '';
  textcolor(printcolors[0]);
  textbackground(printcolors[1]);
  for i2 := i2  to i2 + i3 - 1 do
    case rt of
      0: {$IFNDEF X}
           write(dinp[i2], ' ');
         {$ELSE}
           s := s + booltostr(dinp[i2]) + ' ';
         {$ENDIF}
      1: {$IFNDEF X}
           write(coil[i2], ' ');
         {$ELSE}
           s := s + booltostr(coil[i2]) + ' ';
         {$ENDIF}
      2: {$IFNDEF X}
           write(ireg[i2], ' ');
         {$ELSE}
           s := s + inttostr(ireg[i2]) + ' ';
         {$ENDIF}
      3: {$IFNDEF X}
           write(hreg[i2], ' ');
         {$ELSE}
           s := s + inttostr(hreg[i2]) + ' ';
         {$ENDIF}
    end;
    textcolor(uconfig.colors[0]);
    textbackground(uconfig.colors[1]);
    {$IFNDEF X}
      if crlf then writeln;
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
end;
