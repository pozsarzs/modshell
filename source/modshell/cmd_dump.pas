{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_dump.pas                                                             | }
{ | command 'dump'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1                   p2
  -------------------------------------
  dump [dinp|coil|ireg|hreg [$]ADDRESS]
}

// COMMAND 'DUMP'
procedure cmd_dump(p1, p2: string);
var
  b, line, column: byte;
  c: char;
  i2: integer = 0;        // parameter in other type
  s2: string = '';        // parameter in other type
  rt: byte;               // register type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    // ASKS FOR REGISTER TYPE
    write(MSG26);
    repeat
      rt := ord(readkey);
      if rt = 27 then  begin writeln; exit; end;
    until (rt > 48) and (rt < 53);
    writeln(chr(rt));
    rt := rt - 49;
    // ASKS FOR START ADDRESS
    write(MSG27);
    repeat
      c := readkey;
      if c = #27 then begin writeln; exit; end;
      if length(s2) > 0 then
        if c = #8 then delete(s2, length(s2), 1);
      if length(s2) < 4 then
        if (c >= #48) and (c <= #57) then s2 := s2 + c;
      if strtointdef(s2, 0) > 9990 then s2 := '9990';
      xywrite(length(MSG27) + 1, wherey, true, s2);
    until (c = #13) and (length(s2) > 0);
    writeln;
    i2 := strtointdef(s2, 0);
  end else
  begin
    // CHECK P1 PARAMETER
    for rt := 0 to 3 do
      if REG_TYPE[rt] = p1 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      write('1st ' + MSG05); // What is the 2nd parameter?
      for rt := 0 to 3 do write(' ' + REG_TYPE[rt]);
      writeln;
      exit;
    end;
    // CHECK P2 PARAMETER
    s2 := isitvariable(p2);
    if length(s2) = 0 then s2 := p2;
    i2 := strtointdef(s2, -1);
    if (i2 < 1) or (i2 > 9990) then
    begin
      writeln('2nd ' + MSG05 + ' 1-9990'); // What is the 3rd parameter?
      exit;
    end;
  end;
  // PRIMARY MISSION
  i2 := (i2 div 10) * 10;
  for b := 0 to 9 do xywrite((5 * (b + 1)) + 2, wherey, false, inttostr(b)); // header
  writeln;
  for line := 0 to screenheight - 5 do
  begin
    write(addsomezero(4, inttostr(i2 + (line * 10)))); // address
    for column := 0 to 9 do  // content
      if ((i2 + column) + line * 10) < 10000 then
      begin
        case rt of
          0: xywrite((5 * (column + 1)) + 2, wherey, false, inttostr(booltoint(dinp[(i2 + column) + line * 10])));
          1: xywrite((5 * (column + 1)) + 2, wherey, false, inttostr(booltoint(coil[(i2 + column) + line * 10])));
          2: xywrite((5 * (column + 1)) + 2, wherey, false, addsomezero(4, deztohex(inttostr(ireg[(i2 + column) + line * 10]))));
          3: xywrite((5 * (column + 1)) + 2, wherey, false, addsomezero(4, deztohex(inttostr(hreg[(i2 + column) + line * 10]))));
        end;
      end else exit;
    writeln;
  end;
end;
