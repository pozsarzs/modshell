{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_copy.pas                                                             | }
{ | command 'copyreg'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1   p2                 p3   p4            p5         p6
  ------------------------------------------------------------------------
  copyreg con? $REGTYPE|dinp|coil con? $REGTYPE|coil [$]ADDRESS [[$]COUNT]
  copyreg con? $REGTYPE|ireg|hreg con? $REGTYPE|hreg [$]ADDRESS [[$]COUNT]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
  p2 |  x  |  x  |  x  |  x  |     |  x  |
  p3 |     |     |     |     |     |  x  |
  p4 |  x  |  x  |  x  |  x  |     |  x  |
  p5 |  x  |  x  |  x  |  x  |  x  |     |
  p6 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'COPYREG'
function cmd_copyreg(p1, p2, p3, p4, p5, p6: string): byte;
var
  i1, i3, i5, i6: integer; // parameters in other type
  rt: byte; // register type
  s: string;
  s1, s2, s3, s4, s5, s6: string; // parameters in other type
  valid: boolean = false;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) then
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
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4], -1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR01);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR19);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if (length(p2) > 0) then
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then s2 := p2;
  end;
  for rt := 0 to 3 do
    if REG_TYPE[rt] = s2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    for rt := 0 to 3 do s := s + ' ' + REG_TYPE[rt];
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  s3 := p3;
  delete(s3, length(s3), 1);
  // CHECK P3 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 3rd parameter?
    s := NUM3 + MSG05;
    s := s + ' ' + PREFIX[2] + SVR;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p3) >= 4 then i3 := strtointdef(p3[4], -1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR01);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR01);
    {$ENDIF}
    result := 1;
    exit;
  end;
  valid := false;
  // CHECK P4 PARAMETER
  if (length(p4) > 0) then
  begin
    if boolisitconstant(p4) then s4 := isitconstant(p4);
    if boolisitvariable(p4) then s4 := isitvariable(p4);
    if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
    if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
    if length(s4) = 0 then s4 := p4;
  end;
  if rt <= 1 then
  begin
    if REG_TYPE[1] = s4 then valid := true
  end else
  begin
    if REG_TYPE[3] = s4 then valid := true;
  end;
  if not valid then
  begin
    result := 1;
    // What is the 4th parameter?
    if rt <= 1
    then
      {$IFNDEF X}
        if verbosity(2) then writeln(NUM4 + MSG05 + ' ' + REG_TYPE[1])
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' ' + REG_TYPE[1])
      {$ENDIF}
    else
      {$IFNDEF X}
        if verbosity(2) then writeln(NUM4 + MSG05 + ' ' + REG_TYPE[3]);
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' ' + REG_TYPE[3]);
      {$ENDIF}
    exit;
  end;
  // CHECK P5 PARAMETER
  if boolisitconstant(p5) then s5 := isitconstant(p5);
  if boolisitvariable(p5) then s5 := isitvariable(p5);
  if boolisitconstantarray(p5) then s5 := isitconstantarray(p5);
  if boolisitvariablearray(p5) then s5 := isitvariablearray(p5);
  if length(s5) = 0 then s5 := p5;
  i5 := strtointdef(s5, -1);
  if (i5 < 0) or (i5 > 9998) then
  begin
    // What is the 5th parameter?
    {$IFNDEF X}
      if verbosity(2) then writeln(NUM5 + MSG05 + AVR);
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM5 + MSG05 + AVR);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P6 PARAMETER
  if length(p6) > 0 then
  begin
  if boolisitconstant(p6) then s6 := isitconstant(p6);
  if boolisitvariable(p6) then s6 := isitvariable(p6);
  if boolisitconstantarray(p6) then s6 := isitconstantarray(p6);
  if boolisitvariablearray(p6) then s6 := isitvariablearray(p6);
    if length(s6) = 0 then s6 := p6;
    i6 := strtointdef(s6, -1);
    if (i6 < 1 ) or (i6 > 125) then
    begin
      // What is the 6th parameter?
      {$IFNDEF X}
        if verbosity(2) then writeln(NUM6 + MSG05 + ' 1-125');
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM6 + MSG05 + ' 1-125');
      {$ENDIF}
      result := 1;
      exit;
    end;
  end else i6 := 1;
  // PRIMARY MISSION
  case rt of
    0: begin
         mb_readdinp(i1, i5, i6);
         mb_writecoil(i3, i5, i6);
       end;
    1: begin
         mb_readcoil(i1, i5, i6);
         mb_writecoil(i3, i5, i6);
       end;
    2: begin
         mb_readireg(i1, i5, i6);
         mb_writehreg(i3, i5, i6);
       end;
    3: begin
         mb_readhreg(i1, i5, i6);
         mb_writehreg(i3, i5, i6);
       end;
  end;
end;
