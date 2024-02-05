{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_let.pas                                                              | }
{ | command 'let'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1                  p2                  p3
  ------------------------------------------------------
  let dinp|coil|ireg|hreg [$]ADDRESS          [$]VALUE
  let $VARIABLE           [$]VALUE
  let $VARIABLE           dinp|coil|ireg|hreg [$]ADDRESS
}

// COMMAND 'LET'
function cmd_let(p1, p2, p3: string): byte;
var
  rt: byte; // register type
  x, y: byte;
  s2, s3: string; // parameters in other type
  valid: boolean = false;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitvariable(p1) then  // if p1 is a variable
  begin
    for rt := 0 to 3 do
      if REG_TYPE[rt] = p2 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // ASSIGN VALUE TO A VARIABLE FROM VARIABLE OR NUMBER
      // CHECK P2 PARAMETER
      if boolisitconstant(p2) then s2 := isitconstant(p2);
      if boolisitvariable(p2) then s2 := isitvariable(p2);
      if length(s2) = 0 then s2 := p2;
      // CHANGE '\ ' TO SPACE IN P2
      s2 := stringreplace(s2, #92+#32, #32, [rfReplaceAll]);
      // PRIMARY MISSION
      vars[intisitvariable(p1)].vvalue := s2;
      exit;
    end else
    begin
      // ASSIGN VALUE TO A VARIABLE FROM REGISTER
      // CHECK P2 PARAMETER
      valid := false;
      for rt := 0 to 3 do
        if REG_TYPE[rt] = p2 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        write(NUM1 + MSG05); // What is the 1st parameter?
        for x := 0 to 3 do write(' ' + REG_TYPE[x]);
        writeln;
        result := 1;
        exit;
      end;
      // CHECK P3 PARAMETER
      if boolisitconstant(p3) then s3 := isitconstant(p3);
      if boolisitvariable(p3) then s3 := isitvariable(p3);
      if length(s3) = 0 then s3 := p3;
      // CHANGE '\ ' TO SPACE IN P2
      s3 := stringreplace(s3, #92+#32, #32, [rfReplaceAll]);
      // RANGE CHECK
      if (strtointdef(s3, -1) < 1 ) or (strtointdef(s3, -1) > 9999) then
      begin
        writeln(NUM2 + MSG05 + ' 1-9999'); // What is the 2nd parameter?
        result := 1;
        exit;
      end;
      // PRIMARY MISSION
      case rt of
        0: if dinp[strtoint(s3)] then vars[intisitvariable(p1)].vvalue := '1' else vars[intisitvariable(p1)].vvalue := '0';
        1: if coil[strtoint(s3)] then vars[intisitvariable(p1)].vvalue := '1' else vars[intisitvariable(p1)].vvalue := '0';
        2: vars[intisitvariable(p1)].vvalue := inttostr(ireg[strtoint(s3)]);
        3: vars[intisitvariable(p1)].vvalue := inttostr(hreg[strtoint(s3)]);
      end;
      exit;
    end;  
  end;    
  // ASSIGN VALUE TO A REGISTER
  valid := false;
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write(NUM1 + MSG05); // What is the 1st parameter?
    for x := 0 to 3 do write(' ' + REG_TYPE[x]);
    writeln;
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  if (strtointdef(s2, -1) < 1 ) or (strtointdef(s2, -1) > 9999) then
  begin
    writeln(NUM2 + MSG05 + ' 1-9999'); // What is the 2nd parameter?
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  if rt > 1 then
    if (strtointdef(s3, -1) < 0 ) or (strtointdef(s3, -1) > 65535) then
    begin
      writeln(NUM3 + MSG05 + ' 0-65535'); // What is the 3rd parameter?
      result := 1;
      exit;
    end;
  valid := false;
  if rt < 2 then
  begin
    for x := 0 to 1 do
      for y := 0 to 2 do
        if BOOLVALUES[x, y] = uppercase(s3) then
        begin
          valid := true;
          break;
        end;
    if not valid then
    begin
      write(NUM3 + MSG05); // What is the 3rd parameter?
      for x := 0 to 1 do
        for y := 0 to 2 do
          write(' ' + BOOLVALUES[x, y]);
      writeln;
      result := 1;
      exit;
    end;
  end;
  // CONVERT L/H -> 0/1
  for x := 0 to 1 do
    if uppercase(s3) = BOOLVALUES[x, 1] then s3 := BOOLVALUES[x, 0];
  // PRIMARY MISSION
  case rt of
    0: dinp[strtoint(s2)] := strtobooldef(s3, false);
    1: coil[strtoint(s2)] := strtobooldef(s3, false);
    2: ireg[strtoint(s2)] := strtointdef(s3, 0);
    3: hreg[strtoint(s2)] := strtointdef(s3, 0);
  end;
end;
