{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mbcv.pas                                                             | }
{ | command 'mbconv'                                                         | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0     p1      p2
  ---------------------
  mbconv n2a|a2n $ARRAY

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
  p2 |     |     |  x  |     |     |     |

  Variables in the array:
  [0]  register number
  [1]  register type
  [2]  address
}

// COMMAND 'MBCONV'
function cmd_mbconv(p1, p2: string): byte;
var
  address: integer;
  b: byte;
  direction: byte;
  regnumber: integer;
  regtype: byte;
  s: string;
  valid: boolean;
const
  OFFSET: integer = 10000;
  P1S: array[0..1] of string = ('n2a', 'a2n');
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
  // CHECK P1 PARAMETER
  valid := false;
  for direction := 0 to 1 do
    if P1S[direction] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for b := 0 to 1 do s := s + ' ' + P1S[b];
    s := s + MSG83;
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if not boolisitvariablearray(p2) then
  begin
    // No such variable array!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR55 + p2);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR55 + p2);
    {$ENDIF}
    result := 1;
    exit;
  end else
    if length(arrays[intisitvariablearray(p2)].aitems) < 3
      then setlength(arrays[intisitvariablearray(p2)].aitems, 3);
  // PRIMARY MISSION
  try
    if inttobool(direction) then
    begin
      // n2a
      // check length of values
      if length(arrays[intisitvariablearray(p2)].aitems[0]) = 0 then
      begin
        // There is no value in the array cell
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR62 + p2 + '[0]');
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR62 + p2 + '[0]');
        {$ENDIF}
        result := 1;
        exit;
      end;
      // check value in cell [0]
      b := 255;
      regnumber := strtointdef(arrays[intisitvariablearray(p2)].aitems[0], -1);
      if (regnumber >= 1) and (regnumber <= 9999 ) then b := 0;
      if (regnumber >= 10001) and (regnumber <= 19999 ) then b := 1;
      if (regnumber >= 30001) and (regnumber <= 39999 ) then b := 3;
      if (regnumber >= 40001) and (regnumber <= 49999 ) then b := 4;
      if b = 255 then
      begin
        // Wrong register number
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR63);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR63);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // register type
      if b > 1 then regtype := b - 1 else regtype := b;
      // address
      address := OFFSET * b;
      inc(address);
      address := regnumber - address;
      // result  
      arrays[intisitvariablearray(p2)].aitems[1] := REG_TYPE[regtype];
      arrays[intisitvariablearray(p2)].aitems[2] := inttostr(address);
    end else
    begin
      // a2n
      // check length of values
      for b := 1 to 2 do
        if (length(arrays[intisitvariablearray(p2)].aitems[b]) = 0) then
        begin
          // There is no value in the array cell
          {$IFNDEF X}
            if verbosity(2) then writeln(ERR62 + p2 + '[' + inttostr(b) + ']');
          {$ELSE}
            Form1.Memo1.Lines.Add(ERR62 + p2 + '[' + inttostr(b) + ']');
          {$ENDIF}
          result := 1;
          exit;
        end;
      // check value in cell [1]
      valid := false;
      for regtype := 0 to 3 do
        if REG_TYPE[regtype] = arrays[intisitvariablearray(p2)].aitems[2] then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // Wrong address
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR64);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR64);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // check value in cell [2]
      address := strtointdef(arrays[intisitvariablearray(p2)].aitems[2], -1);
      if not ((address >= 0) and (address <= 9998 )) then
      begin
        // Wrong address
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR65);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR65);
        {$ENDIF}
        result := 1;
        exit;
      end;
      // register number
      if regtype > 1 then inc(regtype);
      regnumber := OFFSET * regtype;
      inc(regnumber);
      regnumber := regnumber + address;
      // result  
      arrays[intisitvariablearray(p2)].aitems[0] := inttostr(regnumber);  
    end;
    result := 0;
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
