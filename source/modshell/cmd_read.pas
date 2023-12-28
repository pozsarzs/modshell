{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_read.pas                                                             | }
{ | command 'read'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2                  p3      p4
  ---------------------------------------------
  read con? dinp|coil|ireg|hreg ADDRESS [COUNT]
}

//command 'read'
procedure cmd_read(p1, p2, p3, p4: string);
var
  i1, i3, i4: integer;
  rt: byte;
  s1: string;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // check p1 parameter
  if PREFIX[2] <> s1 then
  begin
    write('1st ' + MSG05); // What is the 1nd parameter?
    writeln(' ' + PREFIX[2]+'[0-7]');
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    writeln(ERR01); // Device number must be 0-7!
    exit;
  end;
  // check p2 parameter
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('2nd ' + MSG05); // What is the 2nd parameter?
    for rt := 0 to 3 do write(' ' + REG_TYPE[rt]);
    writeln;
    exit;
  end;
  // check p3 parameter
  i3 := strtointdef(p3, -1);
  if (i3 < 1) or (i3 > 9999) then
  begin
    writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
    exit;
  end;
  // check p4 parameter
  if length(p4) > 0 then
  begin
    i4 := strtointdef(p4, -1);
    if (i4 < 1 ) or (i4 > 125) then
    begin
      writeln('4th ' + MSG05 + ' 1-125'); // What is the 3rd parameter?
      exit;
    end;
  end else i4 := 1;
  // primary mission
  case rt of
    0: mbreaddinp(i1, i3, i4);
    1: mbreadcoil(i1, i3, i4);
    2: mbreadireg(i1, i3, i4);
    3: mbreadhreg(i1, i3, i4);
  end;
end;