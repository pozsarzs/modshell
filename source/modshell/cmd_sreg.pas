{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_sreg.pas                                                             | }
{ | command 'savereg'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1
  -------------------------
  savereg PATH_AND_FILENAME
}

// command 'savecfg'
procedure cmd_savereg(p1: string);
var
  c: char;
  i: integer;
  fpn, fp, fn, fx: string;
  ftb: file of boolean;
  ftw: file of word;
 
begin
  // check length of parameter
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check p1
  fp := extractfilepath(p1);
  fn := extractfilename(p1);
  fx := extractfileext(p1);
  if length(fp) = 0 then
  begin
    {$IFDEF GO32V2}
      fp := getexedir + PRGNAME + SLASH;
      createdir(fp);
      fp := getexedir + PRGNAME + SLASH + proj + SLASH;
      createdir(fp);
    {$ELSE}
      fp := getuserdir + PRGNAME + SLASH;
      createdir(fp);
      fp := getuserdir + PRGNAME + SLASH + proj + SLASH;
      createdir(fp);
    {$ENDIF}
  end;
  fn := stringreplace(fn, fx , '', [rfReplaceAll]);
  fpn := fp + fn;
  // check exist
  if fileexists(fpn) then
  begin
    writeln(MSG14);
    repeat
      c:= lowercase(readkey);
      if c = 'n' then exit;
    until c = 'y';
  end;
  // primary mission
  // save dinp and coil
  fpn := fp + fn + '.bdt';
  assignfile(ftb, fpn);
  try 
    rewrite(ftb);
    for i := 1 to 9999 do write(ftb, dinp[i]);
    for i := 1 to 9999 do write(ftb, coil[i]);
    closefile(ftb);
  except
    writeln(ERR12 + fpn + '!');
    exit;
  end;
  writeln(MSG20 + fpn + '.');
  // save ireg and hreg
  fpn := fp + fn + '.idt';
  assignfile(ftw, fpn);
  try 
    rewrite(ftw);
    for i := 1 to 9999 do write(ftw, ireg[i]);
    for i := 1 to 9999 do write(ftw, hreg[i]);
    closefile(ftw);
  except
    writeln(ERR12 + fpn + '!');
    exit;
  end;
  writeln(MSG20 + fpn + '.');
end;
