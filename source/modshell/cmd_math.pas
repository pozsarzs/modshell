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
  p0  p1      p2         p3
  -------------------------------
  add $TARGET [$]VALUE1 [$]VALUE2
  sub $TARGET [$]VALUE1 [$]VALUE2
  mul $TARGET [$]VALUE1 [$]VALUE2
  div $TARGET [$]VALUE1 [$]VALUE2
  round $TARGET [$]VALUE [$]DEC_PLACES
}

// MATHEMATICAL OPERATIONS
procedure cmd_math(op: byte; p1, p2, p3: string);
var
  s2, s3: string; // parameters in other type
begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
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
  s2 := isitvariable(p2);
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  // PRIMARY MISSION
  try
    case op of
      29: vars[intisitvariable(p1)].vvalue := floattostr(strtofloatdef(s2, 0) + strtofloatdef(s3, 0));
      30: vars[intisitvariable(p1)].vvalue :=  floattostr(strtofloatdef(s2, 0) - strtofloatdef(s3, 0));
      31: vars[intisitvariable(p1)].vvalue :=  floattostr(strtofloatdef(s2, 0) * strtofloatdef(s3, 1));
      32: vars[intisitvariable(p1)].vvalue :=  floattostr(strtofloatdef(s2, 0) / strtofloatdef(s3, 1));
      42: vars[intisitvariable(p1)].vvalue :=  floattostr(round2(strtofloatdef(s2, 0), strtointdef(s3, 0)));
    end;
  except
    writeln(ERR20);
  end;
end;
