{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_math.pas                                                             | }
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
  p0      p1      p2        p3            p4
  ------------------------------------------------
  add     $TARGET [$]VALUE1   [$]VALUE2
  chr     $TARGET [$]VALUE
  cos     $TARGET [$]VALUE
  cotan   $TARGET [$]VALUE
  dec     $TARGET [$]VALUE
  div     $TARGET [$]VALUE1   [$]VALUE2
  exp     $TARGET [$]VALUE
  idiv    $TARGET [$]VALUE1   [$]VALUE2
  imod    $TARGET [$]VALUE1   [$]VALUE2
  inrange $TARGET [$]MIN      [$]MAX      [$]VALUE
  inc     $TARGET [$]VALUE
  ln      $TARGET [$]VALUE
  mul     $TARGET [$]VALUE1   [$]VALUE2
  mulinv  $TARGET [$]VALUE
  pow     $TARGET [$]BASE     [$]EXPONENT
  pow2    $TARGET [$]EXPONENT
  odd     $TARGET [$]VALUE
  ord     $TARGET [$]VALUE
  rnd     $TARGET [$]VALUE
  round   $TARGET [$]VALUE    [$]DEC_PLACES
  sin     $TARGET [$]VALUE
  sqr     $TARGET [$]VALUE
  sqrt    $TARGET [$]VALUE
  sub     $TARGET [$]VALUE1   [$]VALUE2
  tan     $TARGET [$]VALUE
}

// MATHEMATICAL OPERATIONS
procedure cmd_math(op: byte; p1, p2, p3, p4: string);
var
  s2, s3, s4: string; // parameters in other type
begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  if ((op >= 29) and (op <= 32)) or (op = 42) or ((op >= 47) and (op <= 48)) then
    if (length(p3) = 0) then
    begin
      writeln(ERR05); // Parameters required!
      exit;
    end;
  if op = 75 then
    if (length(p4) = 0) then
    begin
      writeln(ERR05); // Parameters required!
      exit;
    end;
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    writeln(ERR19 + p1); // No such variable
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  if ((op >= 29) and (op <= 32)) or (op = 42) or ((op >= 47) and (op <= 48)) then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if length(s3) = 0 then s3 := p3;
  end;
  // CHECK P4 PARAMETER
  if op = 75 then
  begin
    if boolisitconstant(p4) then s4 := isitconstant(p4);
    if boolisitvariable(p4) then s4 := isitvariable(p4);
    if length(s4) = 0 then s4 := p4;
  end;
  // PRIMARY MISSION
  try
    case op of
      29: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) + strtofloatdef(s3, 0));
      30: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) - strtofloatdef(s3, 0));
      31: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) * strtofloatdef(s3, 1));
      32: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) / strtofloatdef(s3, 1));
      42: vars[intisitvariable(p1)].vvalue := floattostr(round2(strtofloatdef(s2, 0), strtointdef(s3, 0)));
      43: vars[intisitvariable(p1)].vvalue := floattostr(cos(strtofloatdef(s2, 0)));
      44: vars[intisitvariable(p1)].vvalue := floattostr(cot(strtofloatdef(s2, 0)));
      45: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) - 1);
      46: vars[intisitvariable(p1)].vvalue := floattostr(exp(strtofloatdef(s2, 0)));
      47: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) div strtointdef(s3, 1));
      48: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) mod strtointdef(s3, 1));
      49: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) + 1);
      50: vars[intisitvariable(p1)].vvalue := floattostr(ln(strtofloatdef(s2, 0)));
      51: if strtofloatdef(s2, 0) > 0 then vars[intisitvariable(p1)].vvalue := floattostr(1 / (strtofloatdef(s2, 0)));
      52: if odd(strtointdef(s2, 0)) then vars[intisitvariable(p1)].vvalue := '1' else vars[intisitvariable(p1)].vvalue := '0';
      53: vars[intisitvariable(p1)].vvalue := inttostr(random(strtointdef(s2, 1)));
      54: vars[intisitvariable(p1)].vvalue := floattostr(tan(strtofloatdef(s2, 0)));
      55: vars[intisitvariable(p1)].vvalue := floattostr(sin(strtofloatdef(s2, 0)));
      56: vars[intisitvariable(p1)].vvalue := floattostr(sqr(strtofloatdef(s2, 0)));
      57: vars[intisitvariable(p1)].vvalue := floattostr(sqrt(strtofloatdef(s2, 0)));
      68: vars[intisitvariable(p1)].vvalue := floattostr(power(strtofloatdef(s2, 0), strtofloatdef(s3, 0)));
      75: if ((strtofloatdef(s4, 0)) >= (strtofloatdef(s2, 0))) and 
             ((strtofloatdef(s4, 0)) <= (strtofloatdef(s3, 0)))
          then vars[intisitvariable(p1)].vvalue := '1'
          else vars[intisitvariable(p1)].vvalue := '0';
      78: vars[intisitvariable(p1)].vvalue := floattostr(powerof2(strtointdef(s2, 0)));
    end;
  except
    writeln(ERR20);
  end;
end;
