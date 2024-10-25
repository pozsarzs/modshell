{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  p0     p1                   p2                  p3         p4
  ---------------------------------------------------------------------
  expreg [$]PATH_AND_FILENAME dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]
}

// COMMAND 'EXPREG'
function cmd_expreg(p1, p2, p3, p4: string): byte;
var
  // appendfile: boolean = false;
  {$IFNDEF X} c: char; {$ENDIF}
  i: integer;
  i3, i4: integer; // parameters in other type
  ini: tinifile;
  fpn, fp, fn, fx: string;
  ft: byte;
  rootnode, parentnode, itemnode: TDOMNode; 
  rt: byte; // register type
  s: string;
  s1, s3, s4: string; // parameters in other type
  tf: textfile;
  valid: boolean = false;
  xml: TXMLDocument;
const
  PREFIX: string = 'addr';
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(MSG05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then s1 := isitconstantarray(p1);
  if boolisitvariablearray(p1) then s1 := isitvariablearray(p1);
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
  fpn := fp + fn;
  {$IFNDEF X}
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
  {$ENDIF}
  // CHECK FILE EXTENSION
  for ft := 0 to 2 do
    if '.' + FILE_TYPE[ft] = lowercase(fx) then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the file extension?
    s := MSG22; 
    for ft := 0 to 2 do s := s + ' ' + FILE_TYPE[ft];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
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
    // What is the 2nd parameter?
    s := NUM2 + MSG05;
    for rt := 0 to 3 do s := s + ' ' + REG_TYPE[rt];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P3 PARAMETER
  if boolisitconstant(p3) then s3 := isitconstant(p3);
  if boolisitvariable(p3) then s3 := isitvariable(p3);
  if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
  if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
  if length(s3) = 0 then s3 := p3;
  i3 := strtointdef(s3, -1);
  if (i3 < 1) or (i3 > 9999) then
  begin
    // What is the 3rd parameter?
    {$IFNDEF X} writeln(NUM3 + MSG05 + ' 1-9999'); {$ELSE} Form1.Memo1.Lines.Add(NUM3 + MSG05 + ' 1-9999'); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P4 PARAMETER
  if length(p4) > 0 then
  begin
    if boolisitconstant(p4) then s4 := isitconstant(p4);
    if boolisitvariable(p4) then s4 := isitvariable(p4);
    if boolisitconstantarray(p4) then s4 := isitconstantarray(p4);
    if boolisitvariablearray(p4) then s4 := isitvariablearray(p4);
    if length(s4) = 0 then s4 := p4;
    i4 := strtointdef(s4, -1);
    if (i4 < 1 ) or (i4 > 9999) then
    begin
      // What is the 4rd parameter?
      {$IFNDEF X} writeln(NUM4 + MSG05 + ' 1-9999'); {$ELSE} Form1.Memo1.Lines.Add(NUM4 + MSG05 + ' 1-9999'); {$ENDIF}
      result := 1;
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
           // Cannot export register content!
           {$IFNDEF X}  writeln(ERR10 + fpn + '!'); {$ELSE} Form1.Memo1.Lines.Add(ERR10 + fpn + '!'); {$ENDIF}
           result := 1;
           exit;
         end;
       end;
    1: begin
         sysutils.deletefile(fpn);
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
           // Cannot export register content!
           {$IFNDEF X} writeln(ERR10 + fpn + '!'); {$ELSE} Form1.Memo1.Lines.Add(ERR10 + fpn + '!'); {$ENDIF}
           result := 1;
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
           // Cannot export register content!
           {$IFNDEF X} writeln(ERR10 + fpn + '!'); {$ELSE} Form1.Memo1.Lines.Add(ERR10 + fpn + '!'); {$ENDIF}
           result := 1;
         end;
         xml.free;
       end;
  end;
  {$IFNDEF X} writeln(MSG18 + fpn + '.'); {$ELSE} Form1.Memo1.Lines.Add(MSG18 + fpn + '.'); {$ENDIF}
end;
