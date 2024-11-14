{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_set.pas                                                              | }
{ | command 'set'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1      p2             p3            p4              p5                 p6        p7
  ------------------------------------------------------------------------------------------------
  set dev?    net            [$]DEVICE     [$]IP_ADDRESS   [$]PORT
  set dev?    ser            [$]DEVICE     [$]BAUDRATE     [$]DATABIT         [$]PARITY [$]STOPBIT
  set pro?    ascii|rtu|tcp  [$]ID
  set pro?    dcon           [$]ADDRESS
  set con?    dev?           pro?
  set color   [$]FOREGROUND  [$]BACKGROUND [$]RECEIVEDTEXT [$]TRANSMITTEDTEXT [$]VARMON
  set project [$]PROJECTNAME
  set timeout [$]TIMEOUT
}

// COMMAND 'SET'
function cmd_set(p1, p2, p3, p4, p5, p6, p7: string): byte;
var
  i1: integer; // parameters in other type
  error: byte = 0;
  pr: byte;
  s1: string; // parameters in other type
  valid: boolean = false;

  // COMMAND 'SET DEV'
  procedure cmd_set_dev(n, p2, p3, p4, p5, p6, p7: string);
  var
    dvt, i: integer;
    i4, i6: integer; // parameters in other type
    s: string;
    s4, s5, s6, s7: string; // parameters in other type
  begin
    // 1ST CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) or
       (length(p4) = 0) or (length(p5) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    for dvt := 0 to 1 do
      if DEV_TYPE[dvt] = p2 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // What is the 2nd parameter?
      s := NUM2 + MSG05;
      for i := 0 to 1 do s := s+ ' ' + DEV_TYPE[i];
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      error := 1;
      exit;
    end;
    if dvt = 0 then
    begin
      // DEVICE TYPE: NET
      // CHECK P4 PARAMETER
      if boolisitconstant(p4) then s4 := isitconstant(p4);
      if boolisitvariable(p4) then s4 := isitvariable(p4);
      if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
      if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
      if length(s4) = 0 then s4 := p4;
      if not checkipaddress(p4) then
      begin
        // Invalid IP address!
        {$IFNDEF X} writeln(ERR04); {$ELSE} Form1.Memo1.Lines.Add(ERR04); {$ENDIF}
        error := 1;
        exit;
      end;
      // CHECK P5 PARAMETER
      if boolisitconstant(p5) then s5 := isitconstant(p5);
      if boolisitvariable(p5) then s5 := isitvariable(p5);
      if boolisitconstantarray(p5) then s5 := isitconstantarray(p5);
      if boolisitvariablearray(p5) then s5 := isitvariablearray(p5);
      if length(s5) = 0 then s5 := p5;
      if (strtointdef(s5, -1) < 0 ) or (strtointdef(s5, -1) > 65535) then
      begin
        // What is the 5th parameter?
        {$IFNDEF X} writeln(NUM5 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-65535'); {$ENDIF}
        error := 1;
        exit;
      end;
      // PRIMARY MISSION
      with dev[strtoint(n)] do
      begin
        valid := true;
        devtype := dvt;
        device := p3;
        ipaddress := p4;
        port := strtointdef(s5, 0);
      end;
    end else
    begin
      // DEVICE TYPE: SER
      // CHECK LENGTH OF PARAMETERS
      if (length(p5) = 0) or (length(p6) = 0) or (length(p7) = 0) then
      begin
        // Parameter(s) required!
        {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
        error := 1;
        exit;
      end;
      // CHECK P4 PARAMETER
      if boolisitconstant(p4) then s4 := isitconstant(p4);
      if boolisitvariable(p4) then s4 := isitvariable(p4);
      if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
      if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
      if length(s4) = 0 then s4 := p4;
      for i4 := 0 to 7 do
        if DEV_SPEED[i4] = p4 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // What is the 4th parameter?
        s := NUM4 + MSG05;
        for i := 0 to 7 do s := s + ' ' + DEV_SPEED[i];
        {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
        error := 1;
        exit;
      end;
      // CHECK P5 PARAMETER
      if boolisitconstant(p5) then s5 := isitconstant(p5);
      if boolisitvariable(p5) then s5 := isitvariable(p5);
      if boolisitconstantarray(p5) then s5 := isitconstantarray(p5);
      if boolisitvariablearray(p5) then s5 := isitvariablearray(p5);
      if length(s5) = 0 then s5 := p5;
      if (strtointdef(s5, -1) < 7 ) or (strtointdef(s5, -1) > 8) then
      begin
        // What is the 5th parameter?
        {$IFNDEF X} writeln(NUM5 + MSG05 + ' 7-8'); {$ELSE} Form1.Memo1.Lines.Add(NUM5 + MSG05 + ' 7-8'); {$ENDIF}
        error := 1;
        exit;
      end;
      // CHECK P6 PARAMETER
      if boolisitconstant(p6) then s6 := isitconstant(p6);
      if boolisitvariable(p6) then s6 := isitvariable(p6);
      if boolisitconstantarray(p6) then s6 := isitconstantarray(p6);
      if boolisitvariablearray(p6) then s6 := isitvariablearray(p6);
      if length(s6) = 0 then s6 := p6;
      for i6 := 0 to 2 do
        if DEV_PARITY[i6] = s6 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // What is the 6th parameter?
        s := NUM6 + MSG05;
        for i := 0 to 2 do s := s + ' ' + DEV_PARITY[i];
        {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
        error := 1;
        exit;
      end;
      // CHECK P7 PARAMETER
      if boolisitconstant(p7) then s7 := isitconstant(p7);
      if boolisitvariable(p7) then s7 := isitvariable(p7);
      if boolisitconstantarray(p7) then s7 := isitconstantarray(p7);
      if boolisitvariablearray(p7) then s7 := isitvariablearray(p7);
      if length(s7) = 0 then s7 := p7;
      if (strtointdef(s7, -1) < 1 ) or (strtointdef(s7, -1) > 2) then
      begin
        // What is the 7th parameter?
        {$IFNDEF X} writeln(NUM7 + MSG05 + ' 1-2'); {$ELSE} Form1.Memo1.Lines.Add(NUM7 + MSG05 + ' 1-2'); {$ENDIF}
        error := 1;
        exit;
      end;
      // PRIMARY MISSION
      with dev[strtoint(n)] do
      begin
        valid := true;
        devtype := dvt;
        device := p3;
        speed := i4;
        databit := strtointdef(s5, 8);
        parity := i6;
        stopbit := strtointdef(s7, 1);
      end;
    end;
  end;

  // COMMAND 'SET PRO'
  procedure cmd_set_pro(n, p2, p3: string);
  var
    i: integer;
    prt: byte;
    s: string;
    s3: string; // parameter in other type
    valid: boolean = false;
  begin
    // CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
      error := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    for prt := 0 to 3 do
      if PROT_TYPE[prt] = p2 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // What is the 2nd parameter?
      s := NUM2 + MSG05;
      for i := 0 to 3 do s := s + ' ' + PROT_TYPE[i];
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      error := 1;
      exit;
    end;
    // CHECK P3 PARAMETER
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
    if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
    if length(s3) = 0 then s3 := p3;
    if prt < 3 then
      if (strtointdef(s3, -1) < 1) or (strtointdef(s3, -1) > 247) then
      begin
        // Device ID must be 1-247!
        {$IFNDEF X} writeln(ERR06); {$ELSE} Form1.Memo1.Lines.Add(ERR06); {$ENDIF}
        error := 1;
        exit;
      end else
        if (strtointdef(s3, -1) < 1) or (strtointdef(s3, -1) > 255) then
        begin
          // Address must be 1-255!
          {$IFNDEF X} writeln(ERR54); {$ELSE} Form1.Memo1.Lines.Add(ERR54); {$ENDIF}
          error := 1;
          exit;
        end;
    // PRIMARY MISSION
    with prot[strtoint(n)] do
    begin
      valid := true;
      prottype := prt;
      id := strtointdef(s3, 1)
    end;
  end;

  // COMMAND 'SET CON'
  procedure cmd_set_con(n, p2, p3: string);
  var
    i2, i3: integer;
    s: string;
    s2, s3: string;
  begin
    // CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
      error := 1;
      exit;
    end;
    s2 := p2;
    s3 := p3;
    delete(s2, length(s2), 1);
    delete(s3, length(s3), 1);
    // CHECK P2 PARAMETER
    if PREFIX[0] <> s2 then
    begin
      // What is the 2nd parameter?
      s := NUM2 + MSG05;
      s := s + ' ' + PREFIX[0] + '[0-7]';
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      error := 1;
      exit;
    end;
    if length(p2) >= 4 then i2 := strtointdef(p2[4],-1) else
    begin
      // Device number must be 0-7!
      {$IFNDEF X} writeln(ERR01); {$ELSE} Form1.Memo1.Lines.Add(ERR01); {$ENDIF}
      error := 1;
      exit;
    end;
    if not validity(0, i2) then exit;
   // CHECK P3 PARAMETER
   if PREFIX[1] <> s3 then
    begin
      // What is the 3rd parameter?
      s := NUM3 + MSG05;
      s := s + ' ' + PREFIX[1] + '[0-7]';
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
      error := 1;
      exit;
    end;
    if length(p3) >= 4 then i3 := strtointdef(p3[4],-1) else
    begin
      // Protocol number must be 0-7!
      {$IFNDEF X} writeln(ERR02); {$ELSE} Form1.Memo1.Lines.Add(ERR02); {$ENDIF}
      error := 1;
      exit;
    end;
    if not validity(1, i3) then
    begin
      error := 1;
      exit;
    end;
    // PRIMARY MISSION
    with conn[strtoint(n)] do
    begin
      valid := true;
      dev := i2;
      prot := i3;
    end;
  end;

  // SET DEFAULT COLORS
  procedure cmd_set_color(p2, p3, p4, p5, p6: string);
  var
    i2, i3, i4, i5, i6: integer; // parameters in other type
    s2, s3, s4, s5, s6: string; // parameters in other type
  begin
    result := 0;
    {$IFDEF X}
      Form1.Memo1.Lines.Add(MSG64);
      exit;
    {$ENDIF}
    // CHECK LENGTH OF PARAMETER
    if (length(p2) = 0) or (length(p3) = 0) or (length(p4) = 0) or
       (length(p5) = 0) or (length(p6) = 0) then
    begin
      // Parameter(s) required!
      writeln(ERR05);
      exit;
    end;
    // CHECK P2 PARAMETER
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
    i2 := strtointdef(s2, -1);
    if (i2 < 0) or (i2 > 15) then
    begin
      // What is the 2nd parameter?
      writeln(NUM2 + MSG05 + ' 0-15');
      result := 1;
      exit;
    end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
  if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
  i3 := strtointdef(s3, -1);
  if (i3 < 0) or (i3 > 15) then
  begin
    // What is the 3rd parameter?
    writeln(NUM3 + MSG05 + ' 0-15');
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
  if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
  if length(s4) = 0 then s4 := p4;
  i4 := strtointdef(s4, -1);
  if (i4 < 0) or (i4 > 15) then
  begin
    // What is the 4th parameter?
    writeln(NUM4 + MSG05 + ' 0-15');
    result := 1;
    exit;
  end;
    // CHECK P5 PARAMETER
    if boolisitconstant(p5) then s5 := isitconstant(p5);
    if boolisitvariable(p5) then s5 := isitvariable(p5);
    if boolisitconstantarray(p5) then s4 := isitconstantarray(p5);
    if boolisitvariablearray(p5) then s4 := isitvariablearray(p5);
    if length(s5) = 0 then s5 := p5;
    i5 := strtointdef(s5, -1);
    if (i5 < 0) or (i5 > 15) then
    begin
      // What is the 5th parameter?
      writeln(NUM5 + MSG05 + ' 0-15');
      result := 1;
      exit;
    end;
    // CHECK P6 PARAMETER
    if boolisitconstant(p6) then s6 := isitconstant(p6);
    if boolisitvariable(p6) then s6 := isitvariable(p6);
    if boolisitconstantarray(p6) then s6 := isitconstantarray(p6);
    if boolisitvariablearray(p6) then s6 := isitvariablearray(p6);
    if length(s6) = 0 then s6 := p6;
    i6 := strtointdef(s6, -1);
    if (i6 < 0) or (i6 > 15) then
    begin
      // What is the 6th parameter?
      writeln(NUM6 + MSG05 + ' 0-15');
      result := 1;
      exit;
    end;
    // PRIMARY MISSION
    uconfig.colors[0] := i2;
    uconfig.colors[1] := i3;
    uconfig.colors[2] := i4;
    uconfig.colors[3] := i5;
    uconfig.colors[4] := i6;
  end;

  // SET NAME OF THE PROJECT
  procedure cmd_set_project(p2: string);
  var
    b, bb: byte;
    s2: string; // parameter in other type
    {$IFDEF GO32V2} s: string[8]; {$ELSE} s: string[16]; {$ENDIF}
    valid : boolean = true;  
  begin
    // SEARCH ILLEGAL CHARACTERS
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
    s := s2;
    for b := 1 to length(s) do
    begin
      for bb := 0 to 44 do
        if s[b] = chr(bb) then valid := false;
      for bb := 46 to 47 do
        if s[b] = chr(bb) then valid := false;
      for bb := 58 to 64 do
        if s[b] = chr(bb) then valid := false;
      for bb := 91 to 94 do
        if s[b] = chr(bb) then valid := false;
      for bb := 96 to 96 do
        if s[b] = chr(bb) then valid := false;
      for bb := 123 to 255 do
        if s[b] = chr(bb) then valid := false;
    end;
    if not valid then
    begin
      // Illegal character in the project name!
      {$IFNDEF X} writeln(ERR14); {$ELSE} Form1.Memo1.Lines.Add(ERR14); {$ENDIF}
      error := 1;
    end else
    begin
      vars[12].vvalue := s;
      {$IFDEF GO32V2}
        vars[13].vvalue := getexedir + vars[12].vvalue;
      {$ELSE}
        vars[13].vvalue := vars[11].vvalue + PRGNAME + SLASH + vars[12].vvalue;
      {$ENDIF}
    end;
  end;

  // SET CONNECTION TIMEOUT
  procedure cmd_set_timeout(p2: string);
  var
    s2: string; // parameter in other type
  begin
    // SEARCH ILLEGAL CHARACTERS
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
    if (strtointdef(s2, -1) < 1 ) or (strtointdef(s2, -1) > 60) then
    begin
      // What is the 4th parameter?
      {$IFNDEF X} writeln(NUM2 + MSG05 + ' 1-60'); {$ELSE} Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 1-60'); {$ENDIF}
      error := 1;
      exit;
    end;
    try
      timeout := strtoint(s2);
    except
      // Cannot set connection timeout!
      {$IFNDEF X} writeln(ERR47); {$ELSE} Form1.Memo1.Lines.Add(ERR47); {$ENDIF}
      error := 1;
    end;
  end;

  //SHOW VALID 1ST PARAMETERS
  procedure showvalid1stparameters;
  var
    b: byte;
    s: string = '';
  begin
    s := NUM1 + MSG05;
    for b := 0 to 2 do  s := s + ' ' + PREFIX[b] + '[0-7]';
    s := s + ' ' + PREFIX[3];
    s := s + ' ' + PREFIX[4];
    // What is the 1st parameter?
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
  end;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if p1 = PREFIX[3] then
  begin
    cmd_set_project(p2);
    result := 1;
    exit;
  end;
  if p1 = PREFIX[4] then
  begin
    cmd_set_timeout(p2);
    result := 1;
    exit;
  end;
  if p1 = PREFIX[5] then
  begin
    cmd_set_color(p2, p3, p4, p5, p6);
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  for pr := 0 to 2 do
    if PREFIX[pr]  = s1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    showvalid1stparameters;
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then
  begin
    // PRIMARY MISSION
    i1 := strtointdef(p1[4],-1);
    if (i1 >= 0) and (i1 < 8)
    then
      case pr of
        0: cmd_set_dev(inttostr(i1), p2, p3, p4, p5, p6, p7);
        1: cmd_set_pro(inttostr(i1), p2, p3);
        2: cmd_set_con(inttostr(i1), p2, p3);
      end
    else
    begin
      case pr of
        {$IFNDEF X}
          0: writeln(ERR01); // Device number must be 0-7!
          1: writeln(ERR02); // Protocol number must be 0-7!
          2: writeln(ERR03); // Connection number must be 0-7!
        {$ELSE}
          0: Form1.Memo1.Lines.Add(ERR01);
          1: Form1.Memo1.Lines.Add(ERR02);
          2: Form1.Memo1.Lines.Add(ERR03);
        {$ENDIF}
      end;
      result := 1;
    end;
  end else
  begin
    showvalid1stparameters;
    result := 1;
  end;
  if error > 0 then result := error;
end;
