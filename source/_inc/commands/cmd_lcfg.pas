{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_lcfg.pas                                                             | }
{ | command 'loadcfg'                                                        | }
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
  loadcfg [$]PATH_AND_FILENAME

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'LOADCFG'
function cmd_loadcfg(p1: string): byte;
var
  b, bb: byte;
  fpn, fp, fn, fx: string;
  ftc: file of tconnection;
  ftd: file of tdevice;
  ftp: file of tprotocol;
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
  if boolisitconstantarray(p1) then
    if boolvalidconstantarraycell(p1)
      then s1 := isitconstantarray(p1)
      else result := 1;
  if boolisitvariablearray(p1) then
    if boolvalidvariablearraycell(p1)
      then s1 := isitvariablearray(p1)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
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
    // PRIMARY MISSION
    case b of
      0: begin
           assignfile(ftd, fpn);
           try 
             reset(ftd);
             for bb := 0 to 7 do
               read(ftd, dev[bb]);
             closefile(ftd);
           except
             // Cannot load settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR09 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR09 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG17 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG17 + fpn + '.');
           {$ENDIF}
         end;
      1: begin
           assignfile(ftp, fpn);
           try 
             reset(ftp);
             for bb := 0 to 7 do
               read(ftp, prot[bb]);
             closefile(ftp);
           except
             // Cannot load settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR09 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR09 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG17 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG17 + fpn + '.');
           {$ENDIF}
         end;
      2: begin
           assignfile(ftc, fpn);
           try 
             reset(ftc);
             for bb := 0 to 7 do
               read(ftc, conn[bb]);
             closefile(ftc);
           except
             // Cannot load settings!
             {$IFNDEF X}
               if verbosity(2) then writeln(ERR09 + fpn + '!');
             {$ELSE}
               Form1.Memo1.Lines.Add(ERR09 + fpn + '!');
             {$ENDIF}
             result := 1;
             exit;
           end;
           {$IFNDEF X}
             if verbosity(1) then writeln(MSG17 + fpn + '.');
           {$ELSE}
             Form1.Memo1.Lines.Add(MSG17 + fpn + '.');
           {$ENDIF}
         end;
      end;
  end;
end;
