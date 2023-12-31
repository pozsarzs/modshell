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
  ---------------------------
  impreg [$]PATH_AND_FILENAME
}

// COMMAND 'IMPREG'
procedure cmd_impreg(p1: string);
var
  i, j: integer;
  ini: TINIFile;
  fpn, fp, fn, fx: string;
  ft: byte;
  childnode: tdomnode; 
  rt: byte;               // register type
  s: string;
  s1: string;             // parameters in other type
  valid: boolean = false;
  xml: txmldocument;

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
  fx := extractfileext(s1);
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
  // CHECK FILE EXTENSION
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
  // PRIMARY MISSION
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
         readxmlfile(xml, fpn);
         childnode := xml.documentelement.firstchild;
         while assigned(childnode) do
         begin
           with childnode.childnodes do
             try
               for j := 0 to (count - 1) do
               begin
                 if item[j].NodeName = 'reg' then
                 begin
                   valid := false;
                   for rt := 0 to 3 do
                     if REG_TYPE[rt] = lowercase(utf8encode(childnode.nodename)) then
                     begin
                       valid := true;
                       break;
                     end;
                   if valid then
                     if (strtointdef(utf8encode(item[j].attributes.item[0].textcontent), 0) > 0) and
                        (strtointdef(utf8encode(item[j].attributes.item[0].textcontent), 0) < 10000) then
                       case rt of
                         0: dinp[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] := strtobooldef(utf8encode(item[j].firstchild.nodevalue), false);
                         1: coil[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] := strtobooldef(utf8encode(item[j].firstchild.nodevalue), false);
                         2: ireg[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] := strtointdef(utf8encode(item[j].firstchild.nodevalue), 0);
                         3: hreg[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] := strtointdef(utf8encode(item[j].firstchild.nodevalue), 0);
                       end;
                 end;
               end;
             except
               writeln(err10 + fpn + '!');
               exit;
             end;
           childnode := childnode.nextsibling;
         end;
         xml.free;
       end;
  end;
  writeln(MSG19 + fpn + '.');
end;
