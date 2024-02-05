{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_lreg.pas                                                             | }
{ | command 'loadreg'                                                        | }
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
  ----------------------------
  loadreg [$]PATH_AND_FILENAME
}

// COMMAND 'LOADREG'
function cmd_loadreg(p1: string): byte;
var
  i: integer;
  fpn, fp, fn, fx: string;
  ftb: file of boolean;
  ftw: file of word;
  s1: string; // parameters in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
  fx := extractfileext(s1);
  if length(fp) = 0 then
  begin
    {$IFDEF GO32V2}
      fp := getexedir + proj;
      createdir(fp);
    {$ELSE}
      fp := getuserdir + PRGNAME;
      createdir(fp);
      fp := getuserdir + PRGNAME + SLASH + proj;
      createdir(fp);
    {$ENDIF}
    fp := fp + SLASH;
  end;
  fn := stringreplace(fn, fx , '', [rfReplaceAll]);
  fpn := fp + fn;
  // PRIMARY MISSION
  // load dinp and coil
  fpn := fp + fn + '.bdt';
  assignfile(ftb, fpn);
  try 
    reset(ftb);
    for i := 1 to 9999 do read(ftb, dinp[i]);
    for i := 1 to 9999 do read(ftb, coil[i]);
    closefile(ftb);
  except
    writeln(ERR13 + fpn + '!');
    result := 1;
    exit;
  end;
  writeln(MSG21 + fpn + '.');
  // load ireg and hreg
  fpn := fp + fn + '.idt';
  assignfile(ftw, fpn);
  try 
    reset(ftw);
    for i := 1 to 9999 do read(ftw, ireg[i]);
    for i := 1 to 9999 do read(ftw, hreg[i]);
    closefile(ftw);
  except
    writeln(ERR13 + fpn + '!');
    result := 1;
    exit;
  end;
  writeln(MSG21 + fpn + '.');
end;
