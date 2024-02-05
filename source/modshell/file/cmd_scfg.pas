{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_scfg.pas                                                             | }
{ | command 'savecfg'                                                        | }
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
  savecfg [$]PATH_AND_FILENAME
}

// COMMAND 'SAVECFG'
function cmd_savecfg(p1: string): byte;
var
  b, bb: byte;
  c: char;
  fpn, fp, fn, fx: string;
  ftd: file of tdevice;
  ftp: file of tprotocol;
  ftc: file of tconnection;
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
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
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
  for b := 0 to 2 do
  begin
    fn := stringreplace(fn, fx , '', [rfReplaceAll]);
    fpn := fp + fn + '.' + PREFIX[b][1] + 'dt';
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
    case b of
      0: begin
           assignfile(ftd, fpn);
           try 
             rewrite(ftd);
             for bb := 0 to 7 do
               write(ftd, dev[bb]);
             closefile(ftd);
           except
             writeln(ERR08 + fpn + '!');
             result := 1;
             exit;
           end;
           writeln(MSG16 + fpn + '.');
         end;
      1: begin
           assignfile(ftp, fpn);
           try 
             rewrite(ftp);
             for bb := 0 to 7 do
               write(ftp, prot[bb]);
             closefile(ftp);
           except
             writeln(ERR08 + fpn + '!');
             result := 1;
             exit;
           end;
           writeln(MSG16 + fpn + '.');
         end;
      2: begin
           assignfile(ftc, fpn);
           try 
             rewrite(ftc);
             for bb := 0 to 7 do
               write(ftc, conn[bb]);
             closefile(ftc);
           except
             writeln(ERR08 + fpn + '!');
             result := 1;
             exit;
           end;
           writeln(MSG16 + fpn + '.');
         end;
      end;
  end;
end;
