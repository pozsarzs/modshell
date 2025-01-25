{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'SAVECFG'
function cmd_savecfg(p1: string): byte;
var
  b, bb: byte;
  {$IFNDEF X} c: char; {$ENDIF}
  fpn, fp, fn, fx: string;
  ftd: file of tdevice;
  ftp: file of tprotocol;
  ftc: file of tconnection;
  s1: string;
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
  // No such array cell!
  if boolisitconstantarray(p1) then
    if boolvalidconstantarraycell(p1)
      then s1 := isitconstantarray(p1)
      else result := 1;
  if boolisitvariablearray(p1) then
    if boolvalidvariablearraycell(p1)
      then s1 := isitvariablearray(p1)
      else result := 1;
  if result = 1 then exit;
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
  for b := 0 to 2 do
  begin
    fn := stringreplace(fn, fx , '', [rfReplaceAll]);
    fpn := fp + fn + '.' + PREFIX[b][1] + 'dt';
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
    case b of
      0: begin
           assignfile(ftd, fpn);
           try 
             rewrite(ftd);
             for bb := 0 to 7 do
               write(ftd, dev[bb]);
             closefile(ftd);
           except
             // Cannot save settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR08 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR08 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG16 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG16 + fpn + '.');
           {$ENDIF}
         end;
      1: begin
           assignfile(ftp, fpn);
           try 
             rewrite(ftp);
             for bb := 0 to 7 do
               write(ftp, prot[bb]);
             closefile(ftp);
           except
             // Cannot save settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR08 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR08 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG16 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG16 + fpn + '.');
           {$ENDIF}
         end;
      2: begin
           assignfile(ftc, fpn);
           try 
             rewrite(ftc);
             for bb := 0 to 7 do
               write(ftc, conn[bb]);
             closefile(ftc);
           except
             // Cannot save settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR08 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR08 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG16 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG16 + fpn + '.');
           {$ENDIF}
         end;
      end;
  end;
end;
