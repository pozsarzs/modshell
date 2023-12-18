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
  ------------------------
  exphis PATH_AND_FILENAME
}

// command 'exphis'
procedure cmd_exphis(p1: string);
var
  b: byte;
  c: char;
  fp, fn: string;
  tf: text;

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
  fn := fp + fn;
  // check exist
  if fileexists(fn) then
  begin
    writeln(MSG14);
    repeat
      c:= lowercase(readkey);
      if c = 'n' then exit;
    until c = 'y';
  end;
  // primary mission
  assignfile(tf, fn);
  try
    rewrite(tf);
    {$IFDEF LINUX}
      writeln(tf, '#!/usr/bin/modshell -r');    
    {$ENDIF}
    {$IFDEF BSD}
      writeln(tf, '#!/usr/local/bin/modshell -r');    
    {$ENDIF}
    for b := 0 to 255 do
      if length(histbuff[b]) > 0 then writeln(tf, histbuff[b]);
    closefile(tf);  
  except
    writeln(ERR07 + fn + '!');
    exit;
  end;
  writeln(MSG15 + fn + '.');
end;
