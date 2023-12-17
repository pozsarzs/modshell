{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_save.pas                                                             | }
{ | command 'save'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}


// command 'save'
procedure cmd_save(p1: string);
var
  b, bb: byte;
  c: char;
  fn: string;
  ftd: file of tdevice;
  ftp: file of tprotocol;
  ftc: file of tconnection;
  fname: array[0..3] of string = ('dev','pro','con','.dat');

begin
  // check length of parameter
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  {$IFDEF GO32V2}
    p1 := p1 + '\';
  {$ELSE}
    {$IFDEF WINDOWS}
      p1 := p1 + '\';
    {$ELSE}
      {$IFDEF UNIX}
        p1 := p1 + '/';
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  for b := 0 to 2 do
  begin
    fn := p1 + fname[b] + fname[3];
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
    case b of
      0: begin
           assignfile(ftd, fn);
           try 
             rewrite(ftd);
             for bb := 0 to 7 do
               write(ftd, dev[bb]);
             closefile(ftd);
           except
             writeln(ERR08 + fn + '!');
             exit;
           end;
           writeln(MSG16 + fn + '.');
         end;
      1: begin
           assignfile(ftp, fn);
           try 
             rewrite(ftp);
             for bb := 0 to 7 do
               write(ftp, prot[bb]);
             closefile(ftp);
           except
             writeln(ERR08 + fn + '!');
             exit;
           end;
           writeln(MSG16 + fn + '.');
         end;
      2: begin
           assignfile(ftc, fn);
           try 
             rewrite(ftc);
             for bb := 0 to 7 do
               write(ftc, conn[bb]);
             closefile(ftc);
           except
             writeln(ERR08 + fn + '!');
             exit;
           end;
           writeln(MSG16 + fn + '.');
         end;
      end;
  end;
end;
