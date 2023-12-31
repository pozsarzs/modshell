{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_exph.pas                                                             | }
{ | command 'exphis'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1
  ---------------------------
  exphis [$]PATH_AND_FILENAME
}

// COMMAND 'EXPHIS'
procedure cmd_exphis(p1: string);
var
  b: byte;
  c: char;
  fpn, fp, fn: string;
  s1: string = '';      // parameter in other type
  tf: text;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
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
  fpn := fp + fn;
  // CHECK EXIST
  if fileexists(fpn) then
  begin
    writeln(MSG14);
    repeat
      c:= lowercase(readkey);
      if c = 'n' then exit;
    until c = 'y';
  end;
  // PRIMARY MISSION
  assignfile(tf, fpn);
  try
    rewrite(tf);
    writeln(tf, SHEBANG);    
    for b := 0 to 255 do
      if length(histbuff[b]) > 0 then writeln(tf, histbuff[b]);
    closefile(tf);  
  except
    writeln(ERR07 + fpn + '!');
    exit;
  end;
  writeln(MSG15 + fpn + '.');
end;
