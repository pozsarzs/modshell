{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_logc.pas                                                             | }
{ | logical operations                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1      p2         p3
  --------------------------------
  and  $TARGET [$]VALUE1 [$]VALUE2
  bit  $TARGET [$]VALUE1 [$]VALUE2
  not  $TARGET [$]VALUE
  or   $TARGET [$]VALUE1 [$]VALUE2
  roll $TARGET [$]VALUE1 [$]VALUE2
  rolr $TARGET [$]VALUE1 [$]VALUE2
  shl  $TARGET [$]VALUE1 [$]VALUE2
  shr  $TARGET [$]VALUE1 [$]VALUE2
  xor  $TARGET [$]VALUE1 [$]VALUE2
}

// return with value of the specified bit (LSB)
function bit(w: integer; n: integer): byte;
var
  s: string;
begin
  if (w < 0) or (w > 65535) then
  begin
    writeln(NUM2 + MSG05 + ' 0-65535'); // What is the 2nd parameter?
    exit;
  end;
  if (n < 0) or (n > 15) then
  begin
    writeln(NUM3 + MSG05 + ' 0-15'); // What is the 3rd parameter?
    exit;
  end;
  s := addsomezero(16, deztobin(inttostr(w)));
  result := strtoint(s[length(s)-n]);
end;

// LOGICAL OPERATIONS
function cmd_logic(op: byte; p1, p2, p3: string): byte;
var
  s2, s3: string; // parameters in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  if op <> 25 then
    if (length(p3) = 0) then
    begin
      writeln(ERR05); // Parameters required!
      result := 1;
      exit;
    end;
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    writeln(ERR19 + p1); // No such variable
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  if op <> 25 then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if length(s3) = 0 then s3 := p3;
  end;
  // PRIMARY MISSION
  try
    case op of
      23: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) and strtointdef(s3, 0));
      24: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) or strtointdef(s3, 0));
      25: vars[intisitvariable(p1)].vvalue := inttostr(not strtointdef(s2, 0));
      26: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) xor strtointdef(s3, 0));
      27: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) shl strtointdef(s3, 0));
      28: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) shr strtointdef(s3, 0));
      60: vars[intisitvariable(p1)].vvalue := inttostr(rolword(strtointdef(s2, 0), strtointdef(s3, 0)));
      61: vars[intisitvariable(p1)].vvalue := inttostr(rorword(strtointdef(s2, 0), strtointdef(s3, 0)));
      67: vars[intisitvariable(p1)].vvalue := inttostr(bit(strtointdef(s2, 0), strtointdef(s3, 0)));
    end;
  except
    writeln(ERR20);
    result := 1;
  end;
end;
