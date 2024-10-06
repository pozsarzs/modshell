{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_wrte.pas                                                             | }
{ | command 'writereg'                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0       p1   p2        p3         p4
  ---------------------------------------------
  writereg con? coil|hreg [$]ADDRESS [[$]COUNT]
}

// COMMAND 'WRITEREG'
function cmd_writereg(p1, p2, p3, p4: string): byte;
var
  i1, i3, i4: integer; // parameters other type
  rt: byte = 1; // register type
  s: string;
  s1, s3, s4: string; // parameters in other type
  valid: boolean = false;
begin
  result := 0;
  // CHECK ALL PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1nd parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X} writeln(ERR01); {$ELSE}  Form1.Memo1.Lines.Add(ERR01); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  while rt < 4 do
  begin
    if REG_TYPE[rt] = p2 then
    begin
      valid := true;
      break;
    end;
    rt := rt + 2;
  end;
  if not valid then
  begin
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    rt := 1;
    while rt < 4 do
    begin
      s := s + ' ' + REG_TYPE[rt];
      rt := rt + 2;
    end;
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  i3 := strtointdef(s3, -1);
  if (i3 < 1 ) or (i3 > 9999) then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X} writeln(NUM3 + MSG05 + ' 1-9999'); {$ELSE} Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 1-9999'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if length(s4) = 0 then s4 := p4;
  if length(s4) > 0 then
  begin
    i4 := strtointdef(s4, -1);
    if (i4 < 1 ) or (i4 > 125) then
    begin
      // What is the 3rd parameter?
      {$IFNDEF X} writeln(NUM4 + MSG05 + ' 1-125'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 1-125'); {$ENDIF}
      result := 1;
      exit;
    end;
  end else i4 := 1;
  // PRIMARY MISSION
  case rt of
    1: mb_writecoil(i1, i3, i4);
    3: mb_writehreg(i1, i3, i4);
  end;
end;
