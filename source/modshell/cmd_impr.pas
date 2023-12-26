{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_impr.pas                                                             | }
{ | command 'impreg'                                                         | }
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
  impreg PATH_AND_FILENAME
}

// command 'impreg'
procedure cmd_impreg(p1: string);
var
  i: integer;
  ini: TINIFile;
  fpn, fp, fn, fx: string;
  ft: byte;
  rt: byte;
  s: string;
  valid: boolean = false;

begin
  // check length of parameters
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // check p1
  fp := extractfilepath(p1);
  fn := extractfilename(p1);
  fx := extractfileext(p1);
  if length(fp) = 0 then
  begin
    {$IFDEF GO32V2}
      fp := getexedir + PRGNAME + SLASH;
      createdir(fp);
      fp := getexedir + PRGNAME + SLASH + proj + SLASH;
      createdir(fp);
    {$ELSE}
      fp := getuserdir + PRGNAME + SLASH;
      createdir(fp);
      fp := getuserdir + PRGNAME + SLASH + proj + SLASH;
      createdir(fp);
    {$ENDIF}
  end;
  fpn := fp + fn;
  // check file extension
  for ft := 1 to 3 do
    if '.' + FILE_TYPE[ft] = lowercase(fx) then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write(MSG22); // What is the file extension?
    for ft := 1 to 3 do write(' ' + FILE_TYPE[ft]);
    writeln;
    exit;
  end;
  valid := false;
  // primary mission
  case ft of
    1: begin
         ini := tinifile.create(fpn);
         try
           for rt := 0 to 3 do
             for i := 1 to 9999 do
             begin
               s := ini.readstring(REG_TYPE[rt], 'reg' + inttostr(i),'x');
               case rt of
                 0: if s <> 'x' then dinp[i] := strtobooldef(s, false);
                 1: if s <> 'x' then coil[i] := strtobooldef(s, false);
                 2: if s <> 'x' then ireg[i] := strtointdef(s, 0);
                 3: if s <> 'x' then hreg[i] := strtointdef(s, 0);
               end;
             end; 
         except
           writeln(ERR11 + fpn + '!');
         end;
         ini.free;
       end;
    2: begin
         writeln(MSG99);
       end;
  end;
  writeln(MSG19 + fpn + '.');
end;
