{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_conv.pas                                                             | }
{ | command 'conv'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1      p2              p3              p4
  -----------------------------------------------------
  conv $TARGET bin|dec|hex|oct bin|dec|hex|oct [$]VALUE
}

// COMMAND 'CONV'
function cmd_conv(p1, p2, p3, p4: string): byte;
var
  ns1, ns2: byte; // numerical system
  s: string;
  s4: string; // parameter in other type
  valid: boolean = false;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or (length(p4) = 0)then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if not boolisitvariable(p1) then
  begin
    // No such variable!
    {$IFNDEF X} writeln(ERR19 + p1); {$ELSE} Form1.Memo1.Lines.Add(ERR19 + p1); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  for ns1 := 0 to 3 do
    if NUM_SYS[ns1] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for ns1 := 0 to 3 do s := s + ' ' + NUM_SYS[ns1];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  valid := false;
  // CHECK P3 PARAMETER
  for ns2 := 0 to 3 do
    if NUM_SYS[ns2] = p3 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    for ns2 := 0 to 3 do s := s + ' ' + NUM_SYS[ns2];
    {$IFNDEF X} writeln(s); {$ELSE}  Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if boolisitconstant(p4) then s4 := isitconstant(p4);
  if boolisitvariable(p4) then s4 := isitvariable(p4);
  if length(s4) = 0 then s4 := p4;
  case ns1 of
    0: begin
         s := BinToDez(s4);
         if DezToBin(s) <> s4 then
         begin
           // What is the 3rd parameter?
           {$IFNDEF X}
             writeln(NUM3 + MSG05 + ' 0-1111111111111111');
           {$ELSE}
             Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 0-1111111111111111');
           {$ENDIF}
           result := 1;
           exit;
         end;
       end;
    1: if (strtointdef(s4, -1) < 0 ) or (strtointdef(p4, -1) > 65535) then
       begin
         // What is the 4rd parameter?
         {$IFNDEF X} writeln(NUM4 + MSG05 + ' 0-65535'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-655535'); {$ENDIF}
         result := 1;
         exit;
       end;
    2: begin
         s := HexToDez(s4);
         if DezToHex(s) <> uppercase(s4) then
         begin
           // What is the 4rd parameter?
           {$IFNDEF X} writeln(NUM4 + MSG05 + ' 0-FFFF'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-FFFF'); {$ENDIF}
           result := 1;
           exit;
         end;
       end;
    3: begin
         s := OktToDez(s4);
         if DezToOkt(s) <> s4 then
         begin
           // What is the 4d parameter?
           {$IFNDEF X}  writeln(NUM4 + MSG05 + ' 0-0-177777'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 0-0-177777'); {$ENDIF}
           result := 1;
           exit;
         end;
       end;
  end;
  // PRIMARY MISSION
  {
    y-axis: from (ns1)
    x-axis: to (ns2)
    
     |B  D  H  O 
    -+-----------
    B|   01 02 03
    D|10    12 13
    H|20 21    23
    O|30 31 32    
  }
  b := 10 * ns1 + ns2;
  case b of
    0: s := s4;
    1: s := BinToDez(s4);
    2: s := BinToHex(s4);
    3: s := BinToOkt(s4);
    10: s := DezToBin(s4);
    11: s := s4;
    12: s := DezToHex(s4);
    13: s := DezToOkt(s4);
    20: s := HexToBin(s4);
    21: s := HexToDez(s4);
    22: s := s4;
    23: s := HexToOkt(s4);
    30: s := OktToBin(s4);
    31: s := OktToDez(s4);
    32: s := OktToHex(s4);
    33: s := s4;
  end;
  vars[intisitvariable(p1)].vvalue := s;
end;
