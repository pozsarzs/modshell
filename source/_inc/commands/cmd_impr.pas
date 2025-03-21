{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'IMPREG'
function cmd_impreg(p1: string): byte;
var
  i, j: integer;
  ini: TINIFile;
  fpn, fp, fn, fx: string;
  ft: byte;
  childnode: TDOMNode; 
  rt: byte; // register type
  s: string;
  s1: string;
  valid: boolean = false;
  xml: TXMLDocument;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if boolisitconstant(p1) then s1 := isitconstant(p1);
  if boolisitvariable(p1) then s1 := isitvariable(p1);
  if boolisitconstantarray(p1) then
    if boolvalidconstantarraycell(p1)
      then s1 := isitconstantarray(p1)
      else result := 1;
  if boolisitvariablearray(p1) then
    if boolvalidvariablearraycell(p1)
      then s1 := isitvariablearray(p1)
      else result := 1;
  if result = 1 then
  begin
    // No such array cell!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR66 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR66 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
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
  // CHECK FILE EXTENSION
  for ft := 1 to 2 do
    if '.' + FILE_TYPE[ft] = lowercase(fx) then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the file extension?
    s := MSG22;
    for ft := 1 to 2 do s := s + ' ' + FILE_TYPE[ft];
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  valid := false;
  // PRIMARY MISSION
  case ft of
    1: begin
         ini := tinifile.create(fpn);
         try
           for rt := 0 to 3 do
             for i := 0 to 9998 do
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
           // Cannot import register content!
           {$IFNDEF X}
             if verbosity(2) then writeln(ERR11 + fpn + '!');
           {$ELSE}
             Form1.Memo1.Lines.Add(ERR11 + fpn + '!');
           {$ENDIF}
           result := 1;
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
                     if REG_TYPE[rt] = lowercase(utf8encode(childnode.nodename))
                     then
                     begin
                       valid := true;
                       break;
                     end;
                   if valid then
                     if (strtointdef(utf8encode(item[j].attributes.item[0].textcontent), 0) > 0) and
                        (strtointdef(utf8encode(item[j].attributes.item[0].textcontent), 0) < 10000) then
                       case rt of
                         0: dinp[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] :=
                              strtobooldef(utf8encode(item[j].firstchild.nodevalue), false);
                         1: coil[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] :=
                              strtobooldef(utf8encode(item[j].firstchild.nodevalue), false);
                         2: ireg[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] :=
                              strtointdef(utf8encode(item[j].firstchild.nodevalue), 0);
                         3: hreg[strtoint(utf8encode(item[j].attributes.item[0].textcontent))] :=
                              strtointdef(utf8encode(item[j].firstchild.nodevalue), 0);
                       end;
                 end;
               end;
             except
               {$IFNDEF X}
                 if verbosity(2) then writeln(ERR11 + fpn + '!');
               {$ELSE}
                 Form1.Memo1.Lines.Add(ERR11 + fpn + '!');
               {$ENDIF}
               result := 1;
               exit;
             end;
           childnode := childnode.nextsibling;
         end;
         xml.free;
       end;
  end;
  {$IFNDEF X}
    if verbosity(1) then writeln(MSG19 + fpn + '.');
  {$ELSE}
    Form1.Memo1.Lines.Add(MSG19 + fpn + '.');
  {$ENDIF}
end;
