{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_gpio.pas                                                             | }
{ | direct GPIO access commands                                              | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0        p1         p2               p3
  --------------------------------------------
  gpioinit  rpi[1-4]   [$]PORT          in|out
  gpioinit  isabus     [$]BASE_ADDRESS
  gpioread  [$]BOOLEAN [$]PORT
  gpiowrite [$]PORT    [$]BOOLEAN

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |  x  |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
  p3 |  x  |  x  |  x  |  x  |     |  x  |
}

// DIRECT GPIO ACCESS COMMANDS  
function cmd_gpio(op: byte; p1, p2, p3: string): byte;
var
  b: byte;
  s1: string = '';
  s, s2, s3: string;
  i1: integer = 0;
  i3: integer = 0;
  valid: boolean = false;
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
  // CHECK P1 PARAMETER
  if op = 129 then
  begin
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
    if length(s1) = 0 then s1 := p1;
    for b := 0 to 4 do
      if RPI_VER[b] = s1 then
      begin
        valid := true;
        i1 := b;
        break;
      end;
    if not valid then
    begin
      // What is the 1st parameter?
      s := NUM1 + MSG05;
      for b := 0 to 4 do s := s + ' ' + RPI_VER[b];
      {$IFNDEF X}
        if verbosity(2) then writeln(s);
      {$ELSE}
        Form1.Memo1.Lines.Add(s);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  if op = 130 then
  begin
    if (not boolisitvariable(p1)) and
       (not boolisitvariablearray(p1)) then
    begin
      // No such variable!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR19 + p1);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR19 + p1);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if boolisitvariablearray(p1) then
      if not boolvalidvariablearraycell(p1) then result := 1;
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
  end;
  if op = 131 then
  begin
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
    if length(s1) = 0 then s1 := p1;
  end;
  // CHECK P2 PARAMETER
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
  // CHECK P3 PARAMETER
  if op = 129 then
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
    for b := 0 to 1 do
      if GPIO_MODE[b] = s3 then
      begin
        valid := true;
        i3 := b;
        break;
      end;
    if not valid then
    begin
      // What is the 3rd parameter?
      s := NUM3 + MSG05;
      for b := 0 to 1 do s := s + ' ' + GPIO_MODE[b];
      {$IFNDEF X}
        if verbosity(2) then writeln(s);
      {$ELSE}
        Form1.Memo1.Lines.Add(s);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  try
    case op of
      129: {$IFDEF UNIX}
             {$IFDEF CPUARM}
               // Linux on Raspberry Pi 
               result := initgpioport(i1, strtoint(s2), i3);
             {$ELSE}
               // Linux on x86, x86_64
               result := initgpioport(strtoint(s2));
             {$ENDIF}
           {$ELSE}
             // DOS, Windows
             result := initgpioport(strtoint(s2));
           {$ENDIF}
      130: if boolisitvariable(p1)
           then vars[intisitvariable(p1)].vvalue :=
                  booltostr(readbitfromgpioport(strtoint(s2)))
           else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                  booltostr(readbitfromgpioport(strtoint(s2)));
      131: result := writebittogpioport(strtoint(s1), strtobool(s2));
    end;
  except
    // Operating error
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR48);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR48);
    {$ENDIF}
    result := 1;
  end;
end;
