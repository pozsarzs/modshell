{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_aplg.pas                                                             | }
{ | command 'applog'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1         p2                p3       p4          p5          p6          p7
  --------------------------------------------------------------------------------------------
  applog [$]LOGFILE $TEXT             [$]LEVEL [[$]VALUE1] [[$]VALUE2] [[$]VALUE3] [[$]VALUE4]
  applog [$]LOGFILE "TEXT\ $$1\ TEXT" [$]LEVEL [[$]VALUE1] [[$]VALUE2] [[$]VALUE3] [[$]VALUE4]
}

// COMMAND 'CRON'
function cmd_applog(p1, p2, p3, p4, p5, p6, p7: string): byte;
const
  LEVEL: array[0..4] of string=('NOTE   ',
                                'MESSAGE',
                                'WARNING',
                                'ERROR  ',
                                'DEBUG  ');
var
  b: byte;
  i3: integer; // parameter in other type
  fpn, fp, fn, fx: string;
  s: array[1..7] of string; // parameters in other type
  tf: text;

  // CREATE TIMESTAMP
  function timestamp: string;
  var
    y, mh, d, w, h, m, s, cs: word;
    
  begin
    getdate(y, mh, d, w);
    gettime(h, m, s, cs);
    result := inttostr(y) + '.' + inttostr(mh) + '.' + inttostr(d)+ '. ' +
    addzero(h) + ':' + addzero(m) + ':' + addzero(s);
  end;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0) then
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
  if boolisitconstant(p1) then s[1] := isitconstant(p1);
  if boolisitvariable(p1) then s[1] := isitvariable(p1);
  if length(s[1]) = 0 then s[1] := p1;
  // CHECK P2 PARAMETER: IS IT A MESSAGE?
  s[2] := isitmessage(p2);
  if length(s[2]) < 0 then
  begin
    // CHECK P2 PARAMETER: IS IT VARIABLE?
    if boolisitconstant(p2) then s[2] := isitconstant(p2);
    if boolisitvariable(p2) then s[2] := isitvariable(p2);
    if length(s[2]) = 0 then s[2] := p2;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s[3] := isitconstant(p3);
  if boolisitvariable(p3) then s[3] := isitvariable(p3);
  if length(s[3]) = 0 then s[3] := p3;
  i3 := strtointdef(s[3], -1);
  if (i3 < 0) or (i3 > 7) then
  begin
    {$IFNDEF X}
      writeln(NUM1 + MSG05 + ' 0-7'); // What is the 1st parameter?
    {$ELSE}
      Form1.Memo1.Lines.Add(NUM1 + MSG05 + ' 0-7');
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    if boolisitconstant(p4) then s[4] := isitconstant(p4);
    if boolisitvariable(p4) then s[4] := isitvariable(p4);
    if length(s[4]) = 0 then s[4] := p4;
  end;
  // CHECK P5 PARAMETER
  if length(p5) > 0 then
  begin
    if boolisitconstant(p5) then s[5] := isitconstant(p5);
    if boolisitvariable(p5) then s[5] := isitvariable(p5);
    if length(s[5]) = 0 then s[5] := p5;
  end;
  // CHECK P6 PARAMETER
  if length(p6) > 0 then
  begin
    if boolisitconstant(p6) then s[6] := isitconstant(p6);
    if boolisitvariable(p6) then s[6] := isitvariable(p6);
    if length(s[6]) = 0 then s[6] := p6;
  end;
  // CHECK P7 PARAMETER
  if length(p7) > 0 then
  begin
    if boolisitconstant(p7) then s[7] := isitconstant(p7);
    if boolisitvariable(p7) then s[7] := isitvariable(p7);
    if length(s[7]) = 0 then s[7] := p7;
  end;
  fp := extractfilepath(s[1]);
  fn := extractfilename(s[1]);
  fx := extractfileext(s[1]);
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
  if length(fx) > 0
    then fn := stringreplace(fn, fx , '.log', [rfReplaceAll])
    else fn := fn + '.log';
  fpn := fp + fn;
  // PRIMARY MISSION
  assignfile(tf, fpn);
  try
    // CHECK EXIST
    if fileexists(fpn) then append(tf) else rewrite(tf);
    s[2] := timestamp + ' ' + LEVEL[strtoint(s[3])] + ' ' + s[2];
    for b:= 4 to 7 do
      s[2] := stringreplace(s[2], '$$' + inttostr(b - 3) , s[b], [rfReplaceAll]);
    writeln(tf, s[2]);
    closefile(tf);
  except
    {$IFNDEF X}
      writeln(ERR36 + fpn + '!');
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR36 + fpn + '!');
    {$ENDIF}
    result := 1;
    exit;
  end;
end;
