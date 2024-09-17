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
  p0      p1   p2        p3   p4   p5         p6
  ------------------------------------------------------
  copyreg con? di|coil   con? coil [$]ADDRESS [[$]COUNT]
  copyreg con? ireg|hreg con? hreg [$]ADDRESS [[$]COUNT]
}

// COMMAND 'COPYREG'
function cmd_copyreg(p1, p2, p3, p4, p5, p6: string): byte;
var
  i1, i3, i5, i6: integer; // parameters in other type
  rt: byte; // register type
  s: string;
  s1, s3, s5, s6: string; // parameters in other type
  valid: boolean = false;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) then
  begin
    {$IFNDEF X}
      writeln(ERR05); // Parameters required!
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
    s := NUM1 + MSG05; // What is the 1st parameter?
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X}
      writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    {$IFNDEF X}
      writeln(ERR01); // Device number must be 0-7!
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR19);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    s := NUM2 + MSG05; // What is the 2nd parameter?
    for rt := 0 to 3 do s := s + ' ' + REG_TYPE[rt];
    {$IFNDEF X}
      writeln(s);
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
    s := NUM2 + MSG05; // What is the 3rd parameter?
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X}
      writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p3) >= 4 then i3 := strtointdef(p3[4],-1) else
  begin
    {$IFNDEF X}
      writeln(ERR01); // Device number must be 0-7!
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR01);
    {$ENDIF}
    result := 1;
    exit;
  end;
  valid := false;
  // CHECK P4 PARAMETER
  if rt <= 1 then
  begin
    if REG_TYPE[1] = p4 then valid := true
  end else
  begin
    if REG_TYPE[3] = p4 then valid := true;
  end;
  if not valid then
  begin
    result := 1;
    if rt <= 1
    then
      {$IFNDEF X}
        writeln(NUM4 + MSG05 + ' ' + REG_TYPE[1]) // What is the 4th parameter?
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' ' + REG_TYPE[1])
      {$ENDIF}
    else
      {$IFNDEF X}
        writeln(NUM4 + MSG05 + ' ' + REG_TYPE[3]); // What is the 4th parameter?
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' ' + REG_TYPE[3]);
      {$ENDIF}
    exit;
  end;
  // CHECK P5 PARAMETER
  if boolisitconstant(p5) then s5 := isitconstant(p5);
  if boolisitvariable(p5) then s5 := isitvariable(p5);
  if length(s5) = 0 then s5 := p5;
  i5 := strtointdef(s5, -1);
  if (i5 < 1) or (i5 > 9999) then
  begin
    {$IFNDEF X}
      writeln(NUM5 + MSG05 + ' 1-9999'); // What is the 5th parameter?
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM5 + MSG05 + ' 1-9999');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P6 PARAMETER
  if length(p6) > 0 then
  begin
  if boolisitconstant(p6) then s6 := isitconstant(p6);
  if boolisitvariable(p6) then s6 := isitvariable(p6);
    if length(s6) = 0 then s6 := p6;
    i6 := strtointdef(s6, -1);
    if (i6 < 1 ) or (i6 > 125) then
    begin
      {$IFNDEF X}
        writeln(NUM6 + MSG05 + ' 1-125'); // What is the 6th parameter?
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
