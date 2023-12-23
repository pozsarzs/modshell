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
  fpn, fp, fn: string;
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
  if length(fp) = 0
  then
  {$IFDEF GO32V2}
    fp := getexepath;
  {$ELSE}
    fp := getuserdir;
  {$ENDIF}
  fpn := '';
  fpn := fp + 'regs_' + fn;
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
  assignfile(ftw, fpn);
  try 
    rewrite(ftw);
    // ezt átalakítani: 16 bitenként menteni

    for i := 1 to 9999 do write(ftw, booltoint(dinp[i]));
    for i := 1 to 9999 do write(ftw, booltoint(coil[i]));



    for i := 1 to 9999 do write(ftw, ireg[i]);
    for i := 1 to 9999 do write(ftw, hreg[i]);
    closefile(ftw);
  except
    writeln(ERR12 + fpn + '!');
    exit;
  end;
  writeln(MSG20 + fpn + '.');
end;
