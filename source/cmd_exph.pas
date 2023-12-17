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
  ---------------
  exphis FILENAME
}

// command 'exphis'
procedure cmd_exphis(p1: string);
var
  b: byte;
  c: char;
  fn: string;
  tf: text;

begin
  // check length of parameter
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check path
  {$IFDEF GO32V2}
    if length(extractfilepath(p1)) = 0 then fn := getexepath + '\' + p1;
  {$ELSE}
    {$IFDEF WINDOWS}
      if length(extractfilepath(p1)) = 0 then fn := getuserdir + '\' + p1;
    {$ELSE}
      {$IFDEF UNIX}
        if length(extractfilepath(p1)) = 0 then fn := getuserdir + '/' + p1;
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
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
      writeln(tf, '#!/usr/bin/modshell');    
    {$ENDIF}
    {$IFDEF BSD}
      writeln(tf, '#!/usr/local/bin/modshell');    
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
