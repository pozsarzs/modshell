{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_load.pas                                                             | }
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
  -------------------------
  loadcfg PATH_AND_FILENAME
}

// command 'loadcfg'
procedure cmd_loadcfg(p1: string);
var
  b, bb: byte;
  fpn, fp, fn: string;
  ftd: file of tdevice;
  ftp: file of tprotocol;
  ftc: file of tconnection;

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
  for b := 0 to 2 do
  begin
    fpn := '';
    fpn := fp + PREFIX[b] + '_' + fn;
    // primary mission
    case b of
      0: begin
           assignfile(ftd, fpn);
           try 
             reset(ftd);
             for bb := 0 to 7 do
               read(ftd, dev[bb]);
             closefile(ftd);
           except
             writeln(ERR09 + fpn + '!');
             exit;
           end;
           writeln(MSG17 + fpn + '.');
         end;
      1: begin
           assignfile(ftp, fpn);
           try 
             reset(ftp);
             for bb := 0 to 7 do
               read(ftp, prot[bb]);
             closefile(ftp);
           except
             writeln(ERR09 + fpn + '!');
             exit;
           end;
           writeln(MSG17 + fpn + '.');
         end;
      2: begin
           assignfile(ftc, fpn);
           try 
             reset(ftc);
             for bb := 0 to 7 do
               read(ftc, conn[bb]);
             closefile(ftc);
           except
             writeln(ERR09 + fpn + '!');
             exit;
           end;
           writeln(MSG17 + fpn + '.');
         end;
      end;
  end;
end;
