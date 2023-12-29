{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_expr.pas                                                             | }
{ | command 'expreg'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1                p2                  p3      p3
  ------------------------------------------------------------
  expreg PATH_AND_FILENAME dinp|coil|ireg|hreg ADDRESS [COUNT]
}

// COMMAND 'EXPREG'
procedure cmd_expreg(p1, p2, p3, p4: string);
var
  // appendfile: boolean = false;
  c: char;
  i: integer;
  i3, i4: integer;                          // parameters in other type
  ini: tinifile;
  fpn, fp, fn, fx: string;
  ft: byte;
  rootnode, parentnode, itemnode: tdomnode; 
  rt: byte;                                 // register type
  tf: textfile;
  valid: boolean = false;
  xml: txmldocument;
const
  PREFIX: string = 'addr';

begin
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
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
  // CHECK EXIST
  if fileexists(fpn) then
  begin
    writeln(MSG14);
    repeat
      c:= lowercase(readkey);
      if c = 'n' then exit;
      // if c = 'a' then appendfile := true;
    until (c = 'y') { or (c = 'a') };
  end;
  // CHECK FILE EXTENSION
  for ft := 0 to 3 do
    if '.' + FILE_TYPE[ft] = lowercase(fx) then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write(MSG22); // What is the file extension?
    for ft := 0 to 3 do write(' ' + FILE_TYPE[ft]);
    writeln;
    exit;
  end;
  valid := false;
  // CHECK P2 PARAMETER
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p2 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('2nd ' + MSG05); // What is the 2nd parameter?
    for rt := 0 to 3 do write(' ' + REG_TYPE[rt]);
    writeln;
    exit;
  end;
  // CHECK P3 PARAMETER
  i3 := strtointdef(p3, -1);
  if (i3 < 1) or (i3 > 9999) then
  begin
    writeln('3rd ' + MSG05 + ' 1-9999'); // What is the 3rd parameter?
    exit;
  end;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    i4 := strtointdef(p4, -1);
    if (i4 < 1 ) or (i4 > 9999) then
    begin
      writeln('4th ' + MSG05 + ' 1-9999'); // What is the 4rd parameter?
      exit;
    end;
  end else i4 := 1;
  // PRIMARY MISSION
  case ft of
    0: begin
         assignfile(tf, fpn);
         rewrite(tf);
         try
           case rt of
             0: for i := i3 to i3 + i4 -1 do
                  if i < 10000 then writeln(tf,REG_TYPE[rt] + ',' + inttostr(i) + ',' + booltostr(dinp[i]));
             1: for i := i3 to i3 + i4 do
                  if i < 10000 then writeln(tf,REG_TYPE[rt] + ',' +  inttostr(i) + ',' + booltostr(coil[i]));
             2: for i := i3 to i3 + i4 -1 do
                  if i < 10000 then writeln(tf,REG_TYPE[rt] + ',' +  inttostr(i) + ',' + inttostr(ireg[i]));
             3: for i := i3 to i3 + i4 - 1 do
                  if i < 10000 then writeln(tf,REG_TYPE[rt] + ',' +  inttostr(i) + ',' + inttostr(hreg[i]));
           end;
           closefile(tf);  
         except
           writeln(ERR10 + fpn + '!');
           exit;
         end;
       end;
    1: begin
         deletefile(fpn);
         ini := tinifile.create(fpn);
         try
           case rt of
             0: for i := i3 to i3 + i4 -1 do
                  if i < 10000 then ini.writebool(REG_TYPE[rt], PREFIX + '_' + inttostr(i), dinp[i]);
             1: for i := i3 to i3 + i4 -1 do
                  if i < 10000 then ini.writebool(REG_TYPE[rt], PREFIX + '_' + inttostr(i), coil[i]);
             2: for i := i3 to i3 + i4 -1 do
                  if i < 10000 then ini.writeinteger(REG_TYPE[rt], PREFIX + '_' + inttostr(i), ireg[i]);
             3: for i := i3 to i3 + i4 - 1 do
                  if i < 10000 then ini.writeinteger(REG_TYPE[rt], PREFIX + '_' + inttostr(i), hreg[i]);
           end;
         except
           writeln(ERR10 + fpn + '!');
         end;
         ini.free;
       end;
    2: begin
         xml := txmldocument.create;
         rootnode := xml.createelement('xml');
         xml.appendchild(rootnode); 
         for b := 0 to 3 do
         begin
           rootnode:= xml.documentelement;
           parentnode := xml.createelement(utf8decode(REG_TYPE[b]));
           rootnode.appendchild(parentnode);
         end;
         case rt of
           0: for i := i3 to i3 + i4 -1 do
                if i < 10000 then
                begin
                  parentnode := xml.createelement('reg');               
                  tdomelement(parentnode).setattribute(utf8decode(PREFIX), utf8decode(inttostr(i)));
                  itemnode := xml.createtextnode(utf8decode(booltostr(dinp[i])));
                  parentnode.appendchild(itemnode);
                  rootnode.childnodes.item[rt].appendchild(parentnode);
                end;
           1: for i := i3 to i3 + i4 -1 do
                if i < 10000 then
                begin
                  parentnode := xml.createelement('reg');               
                  tdomelement(parentnode).setattribute(utf8decode(PREFIX), utf8decode(inttostr(i)));
                  itemnode := xml.createtextnode(utf8decode(booltostr(coil[i])));
                  parentnode.appendchild(itemnode);
                  rootnode.childnodes.item[rt].appendchild(parentnode);
                end;
           2: for i := i3 to i3 + i4 -1 do
                if i < 10000 then
                begin
                  parentnode := xml.createelement('reg');               
                  tdomelement(parentnode).setattribute(utf8decode(PREFIX), utf8decode(inttostr(i)));
                  itemnode := xml.createtextnode(utf8decode(inttostr(ireg[i])));
                  parentnode.appendchild(itemnode);
                  rootnode.childnodes.item[rt].appendchild(parentnode);
                end;
           3: for i := i3 to i3 + i4 -1 do
                if i < 10000 then
                begin
                  parentnode := xml.createelement('reg');               
                  tdomelement(parentnode).setattribute(utf8decode(PREFIX), utf8decode(inttostr(i)));
                  itemnode := xml.createtextnode(utf8decode(inttostr(hreg[i])));
                  parentnode.appendchild(itemnode);
                  rootnode.childnodes.item[rt].appendchild(parentnode);
                end;
         end;
         try
           writexmlfile(xml, fpn);
         except
           writeln(ERR10 + fpn + '!');
         end;
         xml.free;
       end;
  end;
  writeln(MSG18 + fpn + '.');
end;
