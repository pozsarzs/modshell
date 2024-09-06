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
  p0   p1              p2              p3
  ---------------------------------------------
  conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE
}

// COMMAND 'CONV'
function cmd_conv(p1, p2, p3: string): byte;
var
  ns1, ns2: byte; // numerical system
  s: string;
  s3: string; // parameter in other type
  valid: boolean = false;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  for ns1 := 0 to 3 do
    if NUM_SYS[ns1] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write(NUM1 + MSG05); // What is the 1st parameter?
    for ns1 := 0 to 3 do write(' ' + NUM_SYS[ns1]);
    writeln;
    result := 1;
    exit;
  end;
  valid := false;
  // CHECK P2 PARAMETER
  for ns2 := 0 to 3 do
    if NUM_SYS[ns2] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write(NUM2 + MSG05); // What is the 2nd parameter?
    for ns2 := 0 to 3 do write(' ' + NUM_SYS[ns2]);
    writeln;
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if length(s3) = 0 then s3 := p3;
  case ns1 of
    0: begin
         s := BinToDez(s3);
         if DezToBin(s) <> s3 then
         begin
           writeln(NUM3 + MSG05 + ' 0-1111111111111111'); // What is the 3rd parameter?
           result := 1;
           exit;
         end;
       end;
    1: if (strtointdef(s3, -1) < 0 ) or (strtointdef(p3, -1) > 65535) then
       begin
         writeln(NUM3 + MSG05 + ' 0-65535'); // What is the 3rd parameter?
         result := 1;
         exit;
       end;
    2: begin
         s := HexToDez(s3);
         if DezToHex(s) <> uppercase(s3) then
         begin
           writeln(NUM3 + MSG05 + ' 0-FFFF'); // What is the 3rd parameter?
           result := 1;
           exit;
         end;
       end;
    3: begin
         s := OktToDez(s3);
         if DezToOkt(s) <> s3 then
         begin
           writeln(NUM3 + MSG05 + ' 0-177777'); // What is the 3rd parameter?
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
    0: s := s3;
    1: s := BinToDez(s3);
    2: s := BinToHex(s3);
    3: s := BinToOkt(s3);
    10: s := DezToBin(s3);
    11: s := s3;
    12: s := DezToHex(s3);
    13: s := DezToOkt(s3);
    20: s := HexToBin(s3);
    21: s := HexToDez(s3);
    22: s := s3;
    23: s := HexToOkt(s3);
    30: s := OktToBin(s3);
    31: s := OktToDez(s3);
    32: s := OktToHex(s3);
    33: s := s3;
  end;
  writeln(s);
end;
