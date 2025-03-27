{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_stack.pas                                                            | }
{ | use an variable array as a LIFO storage                                  | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0    p1    p2   p3
  ------------------------
  stack ARRAY push [$]DATA
  stack ARRAY pop  $TARGET

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |     |
  p2 |  x  |  x  |  x  |  x  |     |  x  |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'STACK'
function cmd_stack(p1, p2, p3: string): integer;
var
  b, bb: byte;
  i: integer;
  op: byte;
  s, s1, s2, s3: string;
  stlastpos, stnextpos, stmaxpos: integer;
  valid: boolean;
  stempty, stfull: boolean;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
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
  // search illegal characters in p1
  s1 := p1;
  valid := true;
  for b := 1 to length(s1) do
  begin
    for bb := 0 to 44 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 46 to 47 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 58 to 64 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 91 to 94 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 96 to 96 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 123 to 255 do
      if s1[b] = chr(bb) then valid := false;
  end;
  if not valid then
  begin
    // Illegal character in the variable name!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR15);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR15);
    {$ENDIF}
    exit;
  end;
  if not boolisitvariablearray(p1) then
  begin
    // No such array!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR52 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR52 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if boolisitconstantarray(p2) then
    if boolvalidconstantarraycell(p2)
      then s2 := isitconstantarray(p2)
      else result := 1;
  if boolisitvariablearray(p2) then
    if boolvalidvariablearraycell(p2)
      then s2 := isitvariablearray(p2)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p2);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p2);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if length(s2) = 0 then s2 := p2;
  for op := 0 to 1 do
    if XIFO_OP[op] = s2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    for op := 0 to 3 do s := s + ' ' + XIFO_OP[op];
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if op = 0 then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then
      if boolvalidconstantarraycell(p3)
        then s3 := isitconstantarray(p3)
        else result := 1;
    if boolisitvariablearray(p3) then
      if boolvalidvariablearraycell(p3)
        then s3 := isitvariablearray(p3)
        else result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p3);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p3);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if length(s3) = 0 then s3 := p3;
  end else
  begin
    if (not boolisitvariable(p3)) and
       (not boolisitvariablearray(p3)) then
    begin
      // No such variable!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR19 + p3);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR19 + p3);
      {$ENDIF}
      result := 1;
      exit;
    end;
    if boolisitvariablearray(p3) then
      if not boolvalidvariablearraycell(p3) then result := 1;
    if result = 1 then
    begin
      // No such array cell!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR66 + p3);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR66 + p3);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  result := 0;
  stmaxpos := length(arrays[intisitvariablearray(p1)].aitems) - 1;
  if op = 0 then
  begin
    stfull := true;
    // next empty position
    for stnextpos := 0 to stmaxpos do
      if arrays[intisitvariablearray(p1)].aitems[stnextpos] = '' then
      begin
        stfull := false;
        break;
      end;
    // push data to the next empty position
    if not stfull
      then arrays[intisitvariablearray(p1)].aitems[stnextpos] := s3
      else result := 1;
  end else
  begin
    stempty := true;
    // next empty position
    for stlastpos := stmaxpos downto 0 do
      if arrays[intisitvariablearray(p1)].aitems[stlastpos] <> '' then
      begin
        stempty := false;
        break;
      end;
    // pop data from the last filled position
    if not stempty then
    begin
      if boolisitvariable(p3)
        then vars[intisitvariable(p3)].vvalue :=
               arrays[intisitvariablearray(p1)].aitems[stlastpos]
        else arrays[intisitvariablearray(p3)].aitems[intisitvariablearrayelement(p3)] :=
               arrays[intisitvariablearray(p1)].aitems[stlastpos];
      arrays[intisitvariablearray(p1)].aitems[stlastpos] := '';
    end
    else result := 1;
  end;
end;
