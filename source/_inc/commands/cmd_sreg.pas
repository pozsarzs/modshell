{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  ----------------------------
  savereg [$]PATH_AND_FILENAME
}

// COMMAND 'SAVECFG'
function cmd_savereg(p1: string): byte;
var
  {$IFNDEF X} c: char; {$ENDIF}
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
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
  fx := extractfileext(s1);
  if length(fp) = 0 then
  begin
    fp := vars[13].vvalue;
    ForceDirectories(fp);
    fp := fp + SLASH;
  end;
  fn := stringreplace(fn, fx , '', [rfReplaceAll]);
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
  // save dinp and coil
  fpn := fp + fn + '.bdt';
  assignfile(ftb, fpn);
  try 
    rewrite(ftb);
    for i := 1 to 9999 do write(ftb, dinp[i]);
    for i := 1 to 9999 do write(ftb, coil[i]);
    closefile(ftb);
  except
    // Cannot save register content!
    {$IFNDEF X} writeln(ERR12 + fpn + '!'); {$ELSE} Form1.Memo1.Lines.Add(ERR12 + fpn + '!'); {$ENDIF}
    result := 1;
    exit;
  end;
  {$IFNDEF X} writeln(MSG20 + fpn + '.'); {$ELSE} Form1.Memo1.Lines.Add(MSG20 + fpn + '.'); {$ENDIF}
  // save ireg and hreg
  fpn := fp + fn + '.wdt';
  assignfile(ftw, fpn);
  try 
    rewrite(ftw);
    for i := 1 to 9999 do write(ftw, ireg[i]);
    for i := 1 to 9999 do write(ftw, hreg[i]);
    closefile(ftw);
  except
    // Cannot save register content!
    {$IFNDEF X} writeln(ERR12 + fpn + '!'); {$ELSE} Form1.Memo1.Lines.Add(ERR12 + fpn + '!'); {$ENDIF}
    result := 1;
    exit;
  end;
  {$IFNDEF X} writeln(MSG20 + fpn + '.'); {$ELSE} Form1.Memo1.Lines.Add(MSG20 + fpn + '.'); {$ENDIF}
end;
