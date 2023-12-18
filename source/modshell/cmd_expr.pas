{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_expr.pas                                                             | }
{ | command 'expreg'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1                p2                  p3      p4
  ------------------------------------------------------------
  expreg PATH_AND_FILENAME dinp|coil|ireg|hreg ADDRESS [COUNT]
}

// command 'expreg'
procedure cmd_expreg(p1, p2, p3, p4: string);
var
  c: char;
  i, i3, i4: integer;
  fp, fn: string;
  rt: byte;
  tf: textfile;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check p1
  fp := extractfilepath(p1);
  fn := extractfilename(p1);
  if length(fp) = 0
  then
  {$IFDEF GO32V2}
    fp := getexepath;
  {$ELSE}
    fp := getuserdir;
  {$ENDIF}
  fn := fp + fn;
  // check exist
  if fileexists(fn) then
  begin
    writeln(MSG14);
    repeat
      c:= lowercase(readkey);
      if c = 'n' then exit;
    until c = 'y';
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
    if (i4 < 1 ) or (i4 > 9999) then
    begin
      writeln('4th ' + MSG05 + ' 1-9999'); // What is the 4rd parameter?
      exit;
    end;
  end else i4 := 1;
  // primary mission
  writeln(p1, p2, p3, p4);
  assignfile(tf, fn);
  rewrite(tf);
  try
    case rt of
      0: for i := i3 to i3 + i4 -1 do
           if i < 10000 then writeln(tf, inttostr(i) + ',' + booltostr(dinp[i]));
      1: for i := i3 to i3 + i4 do
           if i < 10000 then writeln(tf, inttostr(i) + ',' + booltostr(coil[i]));
      2: for i := i3 to i3 + i4 -1 do
           if i < 10000 then writeln(tf, inttostr(i) + ',' + inttostr(ireg[i]));
      3: for i := i3 to i3 + i4 - 1 do
           if i < 10000 then writeln(tf, inttostr(i) + ',' + inttostr(hreg[i]));
    end;
    closefile(tf);  
  except
    writeln(ERR10 + fn + '!');
    exit;
  end;
  writeln(MSG18 + fn + '.');
end;
