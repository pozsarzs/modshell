{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_copy.pas                                                             | }
{ | command 'copy'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2        p3   p4   p5      p6
  ---------------------------------------------
  copy con? di|coil   con? coil ADDRESS [COUNT]
  copy con? ireg|hreg con? hreg ADDRESS [COUNT]
}

// command 'copy'
procedure cmd_copy(p1, p2, p3, p4, p5, p6: string);
var
  i1, i3, i5, i6: integer;
  rt: byte;
  s1, s3: string;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) or
     (length(p4) = 0) or (length(p5) = 0) then
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
  s3 := p3;
  delete(s3, length(s3), 1);
  // check p3 parameter
  if PREFIX[2] <> s1 then
  begin
    write('1st ' + MSG05); // What is the 3rd parameter?
    writeln(' ' + PREFIX[2]+'[0-7]');
    exit;
  end;
  if length(p3) >= 4 then i3 := strtointdef(p3[4],-1) else
  begin
    writeln(ERR01); // Device number must be 0-7!
    exit;
  end;
  valid := false;
  // check p4 parameter
  if rt <= 1 then
  begin
    if REG_TYPE[1] = p4 then valid := true
  end else
  begin
    if REG_TYPE[3] = p4 then valid := true;
  end;
  if not valid then
  begin
    if rt <= 1
    then
      write('4th ' + MSG05 + ' ' + REG_TYPE[1]) // What is the 4th parameter?
    else
      write('4th ' + MSG05 + ' ' + REG_TYPE[3]); // What is the 4th parameter?
  end;
  // check p5 parameter
  i5 := strtointdef(p5, -1);
  if (i5 < 1) or (i5 > 9999) then
  begin
    writeln('5th ' + MSG05 + ' 1-9999'); // What is the 5th parameter?
    exit;
  end;
  // check p6 parameter
  if length(p6) > 0 then
  begin
    i6 := strtointdef(p6, -1);
    if (i6 < 1 ) or (i6 > 125) then
    begin
      writeln('6th ' + MSG05 + ' 1-125'); // What is the 6th parameter?
      exit;
    end;
  end else i6 := 1;
  // primary mission
  case rt of
    0: begin
         mbreaddinp(i1, i5, i6);
         mbwritecoil(i3, i5, i6);
       end;
    1: begin
         mbreadcoil(i1, i5, i6);
         mbwritecoil(i3, i5, i6);
       end;
    2: begin
         mbreadireg(i1, i5, i6);
         mbwritehreg(i3, i5, i6);
       end;
    3: begin
         mbreadhreg(i1, i5, i6);
         mbwritehreg(i3, i5, i6);
       end;
  end;
end;
