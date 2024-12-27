{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  p0      p1        p2        p3            p4
  --------------------------------------------------
  add     $TARGET   [$]VALUE1   [$]VALUE2
  chr     $TARGET   [$]VALUE
  cos     $TARGET   [$]VALUE
  cotan   $TARGET   [$]VALUE
  dec     $VARIABLE
  div     $TARGET   [$]VALUE1   [$]VALUE2
  exp     $TARGET   [$]VALUE
  idiv    $TARGET   [$]VALUE1   [$]VALUE2
  imod    $TARGET   [$]VALUE1   [$]VALUE2
  inrange $TARGET   [$]MIN      [$]MAX      [$]VALUE
  inc     $VARIABLE
  ln      $TARGET   [$]VALUE
  mul     $TARGET   [$]VALUE1   [$]VALUE2
  mulinv  $TARGET   [$]VALUE
  pow     $TARGET   [$]BASE     [$]EXPONENT
  pow2    $TARGET   [$]EXPONENT
  odd     $TARGET   [$]VALUE
  ord     $TARGET   [$]VALUE
  rnd     $TARGET   [$]VALUE
  round   $TARGET   [$]VALUE    [$]DEC_PLACES
  sin     $TARGET   [$]VALUE
  sqr     $TARGET   [$]VALUE
  sqrt    $TARGET   [$]VALUE
  sub     $TARGET   [$]VALUE1   [$]VALUE2
  tan     $TARGET   [$]VALUE
}

// MATHEMATICAL OPERATIONS
function cmd_math(op: byte; p1, p2, p3, p4: string): byte;
var
  s1, s2, s3, s4: string; // parameters in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if length(p1) = 0 then
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
  if ((op <> 45) and (op <> 49)) then
    if (length(p2) = 0) then
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
  if ((op >= 29) and (op <= 32)) or (op = 42) or ((op >= 47) and (op <= 48)) then
    if (length(p3) = 0) then
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
  if op = 75 then
    if (length(p4) = 0) then
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
  end else s1 := isitvariable(p1);
  // CHECK P2 PARAMETER
  if ((op <> 45) and (op <> 49)) then
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
  end;
  // CHECK P3 PARAMETER
  if ((op >= 29) and (op <= 32)) or (op = 42) or ((op >= 47) and (op <= 48)) then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
    if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
    if length(s3) = 0 then s3 := p3;
  end;
  // CHECK P4 PARAMETER
  if op = 75 then
  begin
    if boolisitconstant(p4) then s4 := isitconstant(p4);
    if boolisitvariable(p4) then s4 := isitvariable(p4);
    if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
    if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
    if length(s4) = 0 then s4 := p4;
  end;
  // PRIMARY MISSION
  try
    if boolisitvariable(p1)
      then
        case op of
          29: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) + strtofloatdef(s3, 0));
          30: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) - strtofloatdef(s3, 0));
          31: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) * strtofloatdef(s3, 1));
          32: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) / strtofloatdef(s3, 1));
          42: vars[intisitvariable(p1)].vvalue := floattostr(round2(strtofloatdef(s2, 0), strtointdef(s3, 0)));
          43: vars[intisitvariable(p1)].vvalue := floattostr(cos(strtofloatdef(s2, 0)));
          44: vars[intisitvariable(p1)].vvalue := floattostr(cot(strtofloatdef(s2, 0)));
          45: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s1, 0) - 1);
          46: vars[intisitvariable(p1)].vvalue := floattostr(exp(strtofloatdef(s2, 0)));
          47: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) div strtointdef(s3, 1));
          48: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s2, 0) mod strtointdef(s3, 1));
          49: vars[intisitvariable(p1)].vvalue := inttostr(strtointdef(s1, 0) + 1);
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
        else
        end
      else
        case op of
          29: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(strtofloatdef(s2, 0) + strtofloatdef(s3, 0));
          30: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(strtofloatdef(s2, 0) - strtofloatdef(s3, 0));
          31: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(strtofloatdef(s2, 0) * strtofloatdef(s3, 1));
          32: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(strtofloatdef(s2, 0) / strtofloatdef(s3, 1));
          42: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(round2(strtofloatdef(s2, 0), strtointdef(s3, 0)));
          43: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(cos(strtofloatdef(s2, 0)));
          44: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(cot(strtofloatdef(s2, 0)));
          45: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(strtointdef(s1, 0) - 1);
          46: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(exp(strtofloatdef(s2, 0)));
          47: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(strtointdef(s2, 0) div strtointdef(s3, 1));
          48: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(strtointdef(s2, 0) mod strtointdef(s3, 1));
          49: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(strtointdef(s1, 0) + 1);
          50: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(ln(strtofloatdef(s2, 0)));
          51: if strtofloatdef(s2, 0) > 0 then arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(1 / (strtofloatdef(s2, 0)));
          52: if odd(strtointdef(s2, 0)) then arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := '1' else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := '0';
          53: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(random(strtointdef(s2, 1)));
          54: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(tan(strtofloatdef(s2, 0)));
          55: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(sin(strtofloatdef(s2, 0)));
          56: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(sqr(strtofloatdef(s2, 0)));
          57: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(sqrt(strtofloatdef(s2, 0)));
          68: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(power(strtofloatdef(s2, 0), strtofloatdef(s3, 0)));
          75: if ((strtofloatdef(s4, 0)) >= (strtofloatdef(s2, 0))) and 
                 ((strtofloatdef(s4, 0)) <= (strtofloatdef(s3, 0)))
              then arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := '1'
              else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := '0';
          78: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := floattostr(powerof2(strtointdef(s2, 0)));
        else
        end;
  except
    // Calculating error!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR20);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR20);
    {$ENDIF}
    result := 1;
  end;
end;
