{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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
  p0  p1   p2             p3            p4          p5         p6        p7
  ---------------------------------------------------------------------------------
  set dev? net            [$]DEVICE     PORT
  set dev? ser            [$]DEVICE     [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT
  set pro? ascii|rtu      [$]UID
  set pro? tcp            [$]IP_ADDRESS
  set con? dev?           pro?
  set prj  [$]PROJECTNAME
}

// COMMAND 'SET'
procedure cmd_set(p1, p2, p3, p4, p5, p6, p7: string);
var
  i1: integer;             // parameters in other type
  pr: byte;
  s1: string;              // parameters in other type
  valid: boolean = false;

  // COMMAND 'SET DEV'
  procedure cmd_set_dev(n, p2, p3, p4, p5, p6, p7: string);
  var
    dvt, i: integer;
    i4, i6: integer;         // parameters in other type
    s4, s5, s6, s7: string;  // parameters in other type
  begin
    // 1ST CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) or (length(p4) = 0) then
    begin
      writeln(ERR05); // Parameter required!
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
      write('2st ' + MSG05); // What is the 2nd parameter?
      for i := 0 to 1 do write(' ' + DEV_TYPE[i]);
      writeln;
      exit;
    end;
    if dvt = 0 then
    begin
      // DEVICE TYPE: NET
      // CHECK P4 PARAMETER
      s4 := isitvariable(p4);
      if length(s4) = 0 then s4 := p4;
      if (strtointdef(s4, -1) < 0 ) or (strtointdef(s4, -1) > 65535) then
      begin
        writeln('4th ' + MSG05 + ' 0-65535'); // What is the 4th parameter?
        exit;
      end;
      // PRIMARY MISSION
      with dev[strtoint(n)] do
      begin
        valid := true;
        devtype := dvt;
        device := p3;
        port := strtointdef(s4, 0);
      end;
    end else
    begin
      // DEVICE TYPE: SER
      // CHECK LENGTH OF PARAMETERS
      if (length(p5) = 0) or (length(p6) = 0) or (length(p7) = 0) then
      begin
        writeln(ERR05); // Parameter required!
        exit;
      end;
      // CHECK P4 PARAMETER
      s4 := isitvariable(p4);
      if length(s4) = 0 then s4 := p4;
      for i4 := 0 to 7 do
        if DEV_SPEED[i4] = p4 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        write('4th ' + MSG05); // What is the 4th parameter?
        for i := 0 to 7 do write(' ' + DEV_SPEED[i]);
        writeln;
        exit;
      end;
      // CHECK P5 PARAMETER
      s5 := isitvariable(p5);
      if length(s5) = 0 then s5 := p5;
      if (strtointdef(s5, -1) < 7 ) or (strtointdef(s5, -1) > 8) then
      begin
        writeln('5th ' + MSG05 + ' 7-8'); // What is the 5th parameter?
        exit;
      end;
      // CHECK P6 PARAMETER
      s6 := isitvariable(p6);
      if length(s6) = 0 then s6 := p6;
      for i6 := 0 to 2 do
        if DEV_PARITY[i6] = s6 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        write('6th ' + MSG05); // What is the 6th parameter?
        for i := 0 to 2 do write(' ' + DEV_PARITY[i]);
        writeln;
        exit;
      end;
      // CHECK P7 PARAMETER
      s7 := isitvariable(p7);
      if length(s7) = 0 then s7 := p7;
      if (strtointdef(s7, -1) < 1 ) or (strtointdef(s7, -1) > 2) then
      begin
        writeln('7th ' + MSG05 + ' 1-2'); // What is the 7th parameter?
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
    s3: string;              // parameter in other type
    valid: boolean = false;

  begin
    // CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      writeln(ERR05); // Parameter required!
      exit;
    end;
    // CHECK P2 PARAMETER
    for prt := 0 to 2 do
      if PROT_TYPE[prt] = p2 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      write('2st ' + MSG05); // What is the 2nd parameter?
      for i := 0 to 2 do write(' ' + PROT_TYPE[i]);
      writeln;
      exit;
    end;
    // CHECK P3 PARAMETER
    if prt < 2 then
    begin
      s3 := isitvariable(p3);
      if length(s3) = 0 then s3 := p3;
      if (strtointdef(s3, -1) < 1) or (strtointdef(s3, -1) > 247) then
      begin
        writeln(ERR06); // UID must be 1-247!
        exit;
      end;
    end else
      if not checkipaddress(s3) then
      begin
        writeln(ERR04); // Invalid IP address!
        exit;
      end;
    // PRIMARY MISSION
    with prot[strtoint(n)] do
    begin
      valid := true;
      prottype := prt;
      if prt < 2
      then
        uid := strtointdef(s3, 1)
      else
        ipaddress := s3;
    end;
  end;

  // COMMAND 'SET CON'
  procedure cmd_set_con(n, p2, p3: string);
  var
    i2, i3: integer;
    s2, s3: string;
  
  begin
    // CHECK LENGTH OF PARAMETERS
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      writeln(ERR05);  // Parameters required!
      exit;
    end;
    s2 := p2;
    s3 := p3;
    delete(s2, length(s2), 1);
    delete(s3, length(s3), 1);
    // CHECK P2 PARAMETER
    if PREFIX[0] <> s2 then
    begin
      write('2nd ' + MSG05); // What is the 2nd parameter?
      writeln(' ' + PREFIX[0]+'[0-7]');
      exit;
    end;
    if length(p2) >= 4 then i2 := strtointdef(p2[4],-1) else
    begin
      writeln(ERR01); // Device number must be 0-7!
      exit;
    end;
    if not validity(0, i2) then exit;
   // CHECK P3 PARAMETER
   if PREFIX[1] <> s3 then
    begin
      write('3rd ' + MSG05); // What is the 3rd parameter?
      writeln(' ' + PREFIX[1]+'[0-7]');
      exit;
    end;
    if length(p3) >= 4 then i3 := strtointdef(p3[4],-1) else
    begin
      writeln(ERR02); // Protocol number must be 0-7!
      exit;
    end;
    if not validity(1, i2) then exit;
    // PRIMARY MISSION
    with conn[strtoint(n)] do
    begin
      valid := true;
      dev := i2;
      prot := i3;
    end;
  end;

  // SET NAME OF THE PROJECT
  procedure cmd_set_prj(p2: string);
  var
    b, bb: byte;
    s2: string;              // parameter in other type
    {$IFDEF GO32V2}
      s: string[8];
    {$ELSE}
      s: string[16];
    {$ENDIF}
    valid : boolean = true;  
  begin
    // SEARCH ILLEGAL CHARACTERS
    s2 := isitvariable(p2);
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
    if not valid then writeln(ERR14) else proj := s;
  end;

  //SHOW VALID 1ST PARAMETERS
  procedure showvalid1stparameters;
  var
    b: byte;

  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    for b := 0 to 3 do write(' ' + PREFIX[b]+'[0-7]');
    writeln(' ' + PREFIX[3]);
  end;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameter required!
    exit;
  end;
  // CHECK P1 PARAMETER
  if p1 = PREFIX[3] then
  begin
    cmd_set_prj(p2);
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
      case pr of
        0: writeln(ERR01); // Device number must be 0-7!
        1: writeln(ERR02); // Protocol number must be 0-7!
        2: writeln(ERR03); // Connection number must be 0-7!
      end;
  end else showvalid1stparameters;
end;
