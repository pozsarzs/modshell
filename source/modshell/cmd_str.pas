{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_str.pas                                                              | }
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
  p0      p1      p2        p3
  -----------------------------------
  upcase  $TARGET [$]VALUE
  length  $TARGET [$]VALUE
  lowcase $TARGET [$]VALUE
  stritem $TARGET [$]VALUE1 [$]VALUE2
  chr     $TARGET [$]VALUE
  ord     $TARGET [$]VALUE
}

procedure cmd_string(op: byte; p1, p2, p3: string);
var
  s2, s3: string; // parameters in other type
begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  if op = 63 then
    if (length(p3) = 0) then
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
  if op = 63 then
  begin
    s3 := isitvariable(p3);
    if length(s3) = 0 then s3 := p3;
  end;
  // PRIMARY MISSION
  try
    case op of
      60: vars[intisitvariable(p1)].vvalue := uppercase(s2);
      61: vars[intisitvariable(p1)].vvalue := inttostr(length(s2));
      62: vars[intisitvariable(p1)].vvalue := lowercase(s2);
      63: vars[intisitvariable(p1)].vvalue := s2[strtointdef(s3, 0)];
      64: vars[intisitvariable(p1)].vvalue := chr(strtointdef(s2, 0));
      65: vars[intisitvariable(p1)].vvalue := inttostr(ord(s2[1]));
    end;
  except
    writeln(ERR20);
  end;
end;
