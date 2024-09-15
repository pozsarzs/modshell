{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_sscr.pas                                                             | }
{ | command 'savescr'                                                        | }
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
  savescr [$]PATH_AND_FILENAME
}

// COMMAND 'SAVESCR'
function cmd_savescr(p1: string): byte;
var
  {$IFNDEF X} c: char; {$ENDIF}
  line: integer;
  fpn, fp, fn: string;
  sf: textfile;
  s1: string; // parameters in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    {$IFNDEF X}
      writeln(ERR05); // Parameters required!
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
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
  fpn := fp + fn;
  {$IFNDEF X}
    // CHECK EXIST
    if fileexists(fpn) then
    begin
      writeln(MSG14);
      repeat
        c:= lowercase(readkey);
        if c = 'n' then exit;
      until c = 'y';
    end;
  {$ENDIF}
  // PRIMARY MISSION
  assignfile(sf, fpn);
  try
    rewrite(sf);
    for line := 0 to SCRBUFFSIZE - 1 do
      if length(sbuffer[line]) > 0 then writeln(sf, sbuffer[line]);
    closefile(sf);
  except
    {$IFNDEF X}
      writeln(ERR37 + fpn);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR37 + fpn);
    {$ENDIF}
    result := 1;
  end;
end;
