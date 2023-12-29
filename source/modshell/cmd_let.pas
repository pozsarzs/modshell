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
procedure cmd_let(p1, p2, p3: string);
var
  rt, x, y: byte;
  s2, s3: string;          // parameters in other type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
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
    for x := 0 to 3 do write(' ' + REG_TYPE[x]);
    writeln;
    exit;
  end;
  // CHECK P2 PARAMETER
  s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  if (strtointdef(s2, -1) < 1 ) or (strtointdef(s2, -1) > 9999) then
  begin
    writeln('2nd ' + MSG05 + ' 1-9999'); // What is the 2nd parameter?
    exit;
  end;
  // CHECK P3 PARAMETER
  s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  if rt > 1 then
    if (strtointdef(s3, -1) < 0 ) or (strtointdef(s3, -1) > 65535) then
    begin
      writeln('3rd ' + MSG05 + ' 0-65535'); // What is the 3rd parameter?
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
      write('3rd ' + MSG05); // What is the 3rd parameter?
      for x := 0 to 1 do
        for y := 0 to 2 do
          write(' ' + BOOLVALUES[x, y]);
      writeln;
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
