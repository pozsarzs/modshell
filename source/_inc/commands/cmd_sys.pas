{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_sys.pas                                                              | }
{ | directory and file handler commands                                      | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0    p1                          p2
  ----------------------------------------------------------
  cd    [[$]PATH_AND_DIRECTORYNAME]
  copy  [$]PATH_AND_FILENAME        [$]NEW_PATH_AND_FILENAME
  del   [$]PATH_AND_FILENAME
  dir   [[$]PATH_AND_DIRECTORYNAME]
  exist [$]PATH_AND_FILENAME
  md    [$]PATH_AND_DIRECTORYNAME
  rd    [$]PATH_AND_DIRECTORYNAME
  ren   [$]PATH_AND_FILENAME        [$]NEW_FILENAME
  type  [$]PATH_AND_FILENAME

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// LIST DIRECTORY CONTENT
function cmd_dir(p1: string): byte;
var
  SearchRec1: TSearchRec;
  StringList1, StringList2: TStringList;
  i: integer;
  {$IFNDEF X} line: integer; {$ENDIF}
  s1: string;
begin
  if length(p1) > 0 then
    if (p1 <> SLASH) then
      s1 := p1 + SLASH + '*' else s1 := p1 + '*'
  else s1 := '*';
  StringList1 := TStringList.Create;
  StringList2 := TStringList.Create;
  if SysUtils.FindFirst(s1, faAnyFile, SearchRec1) = 0 then
  begin
    repeat
      with SearchRec1 do
      begin
        if (Attr and faDirectory) = faDirectory
          then StringList1.Add(' [' + Name + ']')
          else StringList2.Add(' ' + Name); 
      end;
    until SysUtils.FindNext(SearchRec1) <> 0;
    SysUtils.FindClose(SearchRec1);
  end;
  StringList1.Sort;
  StringList2.Sort;
  for i := 0 to StringList2.Count - 1 do
    StringList1.Add(StringList2.Strings[i]);
  StringList2.Free;
  {$IFNDEF X}
    line := 0;
  {$ENDIF}
  for i := 0 to StringList1.Count - 1 do
  {$IFNDEF X}
    begin
      writeln(StringList1.Strings[i]);
      inc(line);
      if line >= (termheight - 6) then
      begin
        write(MSG23); readkey;
        write(#13); clreol;
        line := 0;
      end;
    end;
  {$ELSE}
    Form1.Memo1.Lines.Add(StringList1.Strings[i]);
  {$ENDIF}
  StringList1.Free;
  result := 0;
end;

// CHANGE DIRECTORY OR GET NAME
function cmd_cd(p1: string): byte;
begin
  result := 0;
  try
    if length(p1) = 0
      then
        {$IFNDEF X}
          writeln(GetCurrentDir)
        {$ELSE}
          Form1.Memo1.Lines.Add(GetCurrentDir)
        {$ENDIF}
      else SetCurrentDir(p1);
  except
    // Cannot change directory!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR40);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR40);
    {$ENDIF}
    result := 1;
  end;
end;

// MAKE DIRECTORY
function cmd_md(p1: string): byte;
begin
  if CreateDir(p1) then result := 0 else
  begin
    // Cannot make directory!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR41);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR41);
    {$ENDIF}
    result := 1;
  end;
end;

// REMOVE EMPTY DIRECTORY
function cmd_rd(p1: string): byte;
begin
  if RemoveDir(p1) then result := 0 else
  begin
    // Cannot remove directory!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR42);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR42);
    {$ENDIF}
    result := 1;
  end;
end;

// ERASE FILE
function cmd_del(p1: string): byte;
begin
  if not SysUtils.DeleteFile(p1) then
  begin
    // Cannot remove file!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR43);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR43);
    {$ENDIF}
    result := 1;
  end else result := 0;
end;

// TYPE FILE
function cmd_type(p1: string): byte;
var
  StringList1: TStringList;
  i: integer;
  {$IFNDEF X} line: integer; {$ENDIF}
begin
  result := 0;
  StringList1 := TStringList.Create;
  try
    StringList1.LoadFromFile(p1);
    {$IFNDEF X}
      line := 0;
    {$ENDIF}
    for i := 0 to StringList1.Count - 1 do
    {$IFNDEF X}
      begin
        writeln(StringList1.Strings[i]);
        inc(line);
        if line >= (termheight - 6) then
        begin
          write(MSG23); readkey;
          write(#13); clreol;
          line := 0;
        end;
      end;
    {$ELSE}
      Form1.Memo1.Lines.Add(StringList1.Strings[i]);
    {$ENDIF}
  except
    // Cannot type file content!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR44);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR44);
    {$ENDIF}
    result := 1;
  end;
  StringList1.Free;
end;

// COPY FILE
function cmd_copy(p1, p2: string): byte;
var
  MemoryStream1: TMemoryStream;
begin
  result := 1;
  MemoryStream1 := TMemoryStream.Create;
  try
    MemoryStream1.LoadFromFile(p1);
    MemoryStream1.SaveToFile(p2); 
    result := 0;
  except
    // Cannot copy file!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR45);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR45);
    {$ENDIF}
  end;
  MemoryStream1.Free
end;

// RENAME FILE
function cmd_ren(p1, p2: string): byte;
begin
  if not RenameFile(p1, p2) then
  begin
    // Cannot rename file!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR46);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR46);
    {$ENDIF}
    result := 1;
  end else result := 0;
end;

// EXIST  FILE
function cmd_exist(p1: string): byte;
begin
  result := booltoint(SysUtils.FileExists(p1));
end;


function cmd_sys(op: byte; p1, p2: string): byte;
var
  s1, s2: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (op >= 100) and (op <= 101) then
  begin
    if (length(p1) = 0) or (length(p2) = 0) then
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
  end else
  begin
    if (length(p1) = 0) and (op >= 96) then
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
  end;
  // CHECK P1 PARAMETER
  if length(p1) > 0 then
  begin
    if boolisitconstant(p1) then s1 := isitconstant(p1);
    if boolisitvariable(p1) then s1 := isitvariable(p1);
    // No such array cell!
    if boolisitconstantarray(p1) then
      if boolvalidconstantarraycell(p1)
        then s1 := isitconstantarray(p1)
        else result := 1;
    if boolisitvariablearray(p1) then
      if boolvalidvariablearraycell(p1)
        then s1 := isitvariablearray(p1)
        else result := 1;
    if result = 1 then exit;
    if length(s1) = 0 then s1 := p1;
  end;
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    // No such array cell!
    if boolisitconstantarray(p2) then
      if boolvalidconstantarraycell(p2)
        then s2 := isitconstantarray(p2)
        else result := 1;
    if boolisitvariablearray(p2) then
      if boolvalidvariablearraycell(p2)
        then s2 := isitvariablearray(p2)
        else result := 1;
    if result = 1 then exit;
    if length(s2) = 0 then s2 := p2;
  end;
  // PRIMARY MISSION
  case op of
     94: result := cmd_dir(s1);
     95: result := cmd_cd(s1);
     96: result := cmd_md(s1);
     97: result := cmd_rd(s1);
     98: result := cmd_del(s1);
     99: result := cmd_type(s1);
    100: result := cmd_copy(s1, s2);
    101: result := cmd_ren(s1, s2);
    102: result := cmd_exist(s1);
  end;
end;
