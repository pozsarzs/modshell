{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_if.pas                                                               | }
{ | command 'if'                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1       p2              p3        p4   p5
  ---------------------------------------------------
  if [$]VALUE1 RELATIONAL_SIGN [$]VALUE2 then COMMAND
}

// COMMAND 'IF'
function cmd_if(p1, p2, p3, p4, p5: string): byte;
const
  RS: array[0..5] of string = ('<','<=','=','=>','>','<>');
var
  i1, i2, i3: integer; // parameters in other type
  s: string;
  s1, s3: string; // parameters in other type
  valid: boolean = false;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  i1 := strtointdef(s1, -1);
  if (i1 < 0) or (i1 > 65535) then
  begin
    // What is the 1st parameter?
    {$IFNDEF X} writeln(NUM1 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' 0-65535'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  for i2 := 0 to 5 do
    if p2 = RS[i2] then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    s := NUM2 + MSG05;
    for i2 := 0 to 5 do s := s + ' ' + RS[i2];
    // What is the 2nd parameter?
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  i3 := strtointdef(s3, -1);
  if (i3 < 0) or (i3 > 65535) then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X} writeln(NUM3 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 0-65535'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if lowercase(p4) <> 'then' then
  begin
    // What is the 4th parameter?
    {$IFNDEF X} writeln(NUM4 + MSG05+'  then'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05+'  then'); {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  case i2 of
    0: if i1 < i3  then valid := true else valid := false;
    1: if i1 <= i3 then valid := true else valid := false;
    2: if i1 = i3  then valid := true else valid := false;
    3: if i1 >= i3 then valid := true else valid := false;
    4: if i1 > i3  then valid := true else valid := false;
    5: if i1 <> i3 then valid := true else valid := false;
  end;
  p5 := stringreplace(p5, 'if ' + p1 + ' ' + p2 + ' ' + p3 + ' ' + p4 + ' ', '', [rfReplaceAll]);
  if valid then parsingcommands(p5);
end;
