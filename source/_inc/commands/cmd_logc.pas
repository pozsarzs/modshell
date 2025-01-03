{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
}

// return with value of the specified bit (LSB)
function bit(w: integer; n: integer): byte;
var
  s: string;
begin
  // What is the 2nd parameter?
  if (w < 0) or (w > 65535) then
  begin
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM2 + MSG05 + ' 0-65535');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM2 + MSG05 + ' 0-65535');
    {$ENDIF}
    exit;
  end;
  if (n < 0) or (n > 15) then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM3 + MSG05 + ' 0-15');
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 0-15');
    {$ENDIF}
    exit;
  end;
  s := addsomezero(16, deztobin(inttostr(w)));
  result := strtoint(s[length(s)-n]);
end;

// LOGICAL OPERATIONS
function cmd_logic(op: byte; p1, p2, p3: string): byte;
var
  s2, s3: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
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
  if op <> 25 then
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
  end;
  if boolisitvariablearray(p1) then
    if not boolvalidvariablearraycell(p1) then
    begin
      // No such array cell!
      result := 1;
      exit;
    end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  // No such array cell!
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s2 := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s2 := isitvariablearray(p2)
      else result := 1;
  if result = 1 then exit;
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  if op <> 25 then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    // No such array cell!
    if boolisitconstantarray(p3) then
      if boolvalidconstantarraycell(p3)
        then s3 := isitconstantarray(p3)
        else result := 1;
    if boolisitvariablearray(p3) then
      if boolvalidvariablearraycell(p3)
        then s3 := isitvariablearray(p3)
        else result := 1;
    if result = 1 then exit;
    if length(s3) = 0 then s3 := p3;
  end;
  // PRIMARY MISSION
  try
    if boolisitvariable(p1)
      then
        case op of
          23: vars[intisitvariable(p1)].vvalue :=
                inttostr(strtointdef(s2, 0) and strtointdef(s3, 0));
          24: vars[intisitvariable(p1)].vvalue :=
                inttostr(strtointdef(s2, 0) or strtointdef(s3, 0));
          25: vars[intisitvariable(p1)].vvalue :=
                inttostr(not strtointdef(s2, 0));
          26: vars[intisitvariable(p1)].vvalue :=
                inttostr(strtointdef(s2, 0) xor strtointdef(s3, 0));
          27: vars[intisitvariable(p1)].vvalue :=
                inttostr(strtointdef(s2, 0) shl strtointdef(s3, 0));
          28: vars[intisitvariable(p1)].vvalue :=
                inttostr(strtointdef(s2, 0) shr strtointdef(s3, 0));
          60: vars[intisitvariable(p1)].vvalue :=
                inttostr(rolword(strtointdef(s2, 0), strtointdef(s3, 0)));
          61: vars[intisitvariable(p1)].vvalue :=
                inttostr(rorword(strtointdef(s2, 0), strtointdef(s3, 0)));
          67: vars[intisitvariable(p1)].vvalue :=
                inttostr(bit(strtointdef(s2, 0), strtointdef(s3, 0)));
        else
        end
      else
        case op of
          23: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(strtointdef(s2, 0) and strtointdef(s3, 0));
          24: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(strtointdef(s2, 0) or strtointdef(s3, 0));
          25: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(not strtointdef(s2, 0));
          26: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(strtointdef(s2, 0) xor strtointdef(s3, 0));
          27: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(strtointdef(s2, 0) shl strtointdef(s3, 0));
          28: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(strtointdef(s2, 0) shr strtointdef(s3, 0));
          60: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(rolword(strtointdef(s2, 0), strtointdef(s3, 0)));
          61: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(rorword(strtointdef(s2, 0), strtointdef(s3, 0)));
          67: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] :=
                inttostr(bit(strtointdef(s2, 0), strtointdef(s3, 0)));
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
