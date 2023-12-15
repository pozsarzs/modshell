{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
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
  p0  p1   p2        p3         p4       p5      p6     p7
  -------------------------------------------------------------
  set dev? net       DEVICE     PORT
  set dev? ser       DEVICE     BAUDRATE DATABIT PARITY STOPBIT
  set pro? ascii|rtu UID
  set pro? tcp       IP_ADDRESS
  set con? dev?      pro?
}


// command 'set'
procedure cmd_set(p1, p2, p3, p4, p5, p6, p7: string);
var
  i, i1: integer;
  pr: byte;
  s1: string;
  valid: boolean = false;

  // command 'set dev'
  procedure cmd_set_dev(n, p2, p3, p4, p5, p6, p7: string);
  var
    dvt, i, i4, i6: integer;
  begin
    // 1st check length of parameters
    if (length(p2) = 0) or (length(p3) = 0) or (length(p4) = 0) then
    begin
      writeln(ERR11); // Parameter required!
      exit;
    end;
    // check p2 parameter
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
      // net
      // check p4 parameter
      if (strtointdef(p4, -1) < 0 ) or (strtointdef(p4, -1) > 65535) then
      begin
        writeln('4th ' + MSG05 + ' 0-65535'); // What is the 4th parameter?
        exit;
      end;
      // primary mission
      with dev[strtoint(n)] do
      begin
        valid := true;
        devtype := dvt;
        device := p3;
        port := strtointdef(p4, 0);
      end;
    end else
    begin
      // ser
      // check length of parameters
      if (length(p5) = 0) or (length(p6) = 0) or (length(p7) = 0) then
      begin
        writeln(ERR11); // Parameter required!
        exit;
      end;
      // check p4 parameter
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
      // check p5 parameter
      if (strtointdef(p5, -1) < 7 ) or (strtointdef(p5, -1) > 8) then
      begin
        writeln('5th ' + MSG05 + ' 7-8'); // What is the 5th parameter?
        exit;
      end;
      // check p6 parameter
      for i6 := 0 to 2 do
        if DEV_PARITY[i6] = p6 then
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
      // check p7 parameter
      if (strtointdef(p7, -1) < 1 ) or (strtointdef(p7, -1) > 2) then
      begin
        writeln('7th ' + MSG05 + ' 1-2'); // What is the 7th parameter?
        exit;
      end;
      // primary mission
      with dev[strtoint(n)] do
      begin
        valid := true;
        devtype := dvt;
        device := p3;
        speed := i4;
        databit := strtointdef(p5, 8);
        parity := i6;
        stopbit := strtointdef(p7, 1);
      end;
    end;
  end;

  // command 'set pro'
  procedure cmd_set_pro(n, p2, p3: string);
  var
    i: integer;
    prt: byte;
    valid: boolean = false;
  begin
    // check length of parameters
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      writeln(ERR11); // Parameter required!
      exit;
    end;
    // check p2 parameter
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
    // check p3 parameter
    if prt < 2 then
    begin
      if (strtointdef(p3, -1) < 1) or (strtointdef(p3, -1) > 247) then
      begin
        writeln(ERR12); // UID must be 1-247!
        exit;
      end;
    end else
      if not checkipaddress(p3) then
      begin
        writeln(ERR03); // Invalid IP address!
        exit;
      end;
    // primary mission
    with prot[strtoint(n)] do
    begin
      valid := true;
      prottype := prt;
      if prt < 2
      then
        uid := strtointdef(p3, 1)
      else
        ipaddress := p3;
    end;
  end;

  // command 'set con'
  procedure cmd_set_con(n, p2, p3: string);
  var
    i2, i3: integer;
    s2, s3: string;
  begin
    // check length of parameters
    if (length(p2) = 0) or (length(p3) = 0) then
    begin
      writeln(ERR11);  // Parameters required!
      exit;
    end;
    s2 := p2;
    s3 := p3;
    delete(s2, length(s2), 1);
    delete(s3, length(s3), 1);
    // check p2 parameter
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
   // check p3 parameter
   if PREFIX[1] <> s3 then
    begin
      write('3rd ' + MSG05); // What is the 3rd parameter?
      writeln(' ' + PREFIX[1]+'[0-7]');
      exit;
    end;
    if length(p3) >= 4 then i3 := strtointdef(p3[4],-1) else
    begin
      writeln(ERR09); // Protocol number must be 0-7!
      exit;
    end;
    // primary mission
    with conn[strtoint(n)] do
    begin
      valid := true;
      dev := i2;
      prot := i3;
    end;
  end;

begin
  // check length of parameters
  if (length(p1) = 0) then
  begin
    writeln(ERR11); // Parameter required!
    exit;
  end;
  // check p1 parameter
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
    write('1st ' + MSG05); // What is the 1st parameter?
    for i := 0 to 2 do write(' ' + PREFIX[i]+'[0-7]');
    writeln;
    exit;
  end;
  if length(p1) >= 4 then
  begin
    // primary mission
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
        1: writeln(ERR09); // Protocol number must be 0-7!
        2: writeln(ERR10); // Connection number must be 0-7!
      end;
  end;
end;
