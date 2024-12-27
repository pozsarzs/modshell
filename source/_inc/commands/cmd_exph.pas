{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
function cmd_exphis(p1: string): byte;
var
  b: byte;
  c: char;
  fpn, fp, fn {$IFDEF GO32V2}, fx{$ENDIF}: string;
  s1: string = ''; // parameter in other type
  tf: text;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then s1 := isitconstantarray(p1);
  if boolisitvariablearray(p1) then s1 := isitvariablearray(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
  {$IFDEF GO32V2} fx := extractfileext(s1); {$ENDIF}
  if length(fp) = 0 then
  begin
    fp := vars[13].vvalue;
    ForceDirectories(fp);
    fp := fp + SLASH;
  end;
  {$IFDEF GO32V2}
    if length(fx) > 0
      then fn := stringreplace(fn, fx , '.bat', [rfReplaceAll])
      else fn := fn + '.bat';
  {$ENDIF}
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
    writeln(tf,'');
    for b := 0 to 255 do
      if length(histbuff[b]) > 0 then writeln(tf, histbuff[b]);
    {$IFDEF LABELEOF}
      writeln(tf,'');
      writeln(tf, LABELEOF);
    {$ENDIF}
    closefile(tf);
  except
    // Cannot export command line history!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR07 + fpn + '!');
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR07 + fpn + '!');
    {$ENDIF}
    result := 1;
    exit;
  end;
  {$IFNDEF X}
    if verbosity(1) then writeln(MSG15 + fpn + '.');
  {$ELSE}
    Form1.Memo1.Lines.Add(MSG15 + fpn + '.');
  {$ENDIF}
end;
