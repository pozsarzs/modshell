{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_load.pas                                                             | }
{ | command 'load'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// command 'load'
procedure cmd_load(p1: string);
var
  b, bb: byte;
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
    // primary mission
    case b of
      0: begin
           assignfile(ftd, fn);
           try 
             reset(ftd);
             for bb := 0 to 7 do
               read(ftd, dev[bb]);
             closefile(ftd);
           except
             writeln(ERR09 + fn + '!');
             exit;
           end;
           writeln(MSG17 + fn + '.');
         end;
      1: begin
           assignfile(ftp, fn);
           try 
             reset(ftp);
             for bb := 0 to 7 do
               read(ftp, prot[bb]);
             closefile(ftp);
           except
             writeln(ERR09 + fn + '!');
             exit;
           end;
           writeln(MSG17 + fn + '.');
         end;
      2: begin
           assignfile(ftc, fn);
           try 
             reset(ftc);
             for bb := 0 to 7 do
               read(ftc, conn[bb]);
             closefile(ftc);
           except
             writeln(ERR09 + fn + '!');
             exit;
           end;
           writeln(MSG17 + fn + '.');
         end;
      end;
  end;
end;
