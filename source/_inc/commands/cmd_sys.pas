{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  p0   p1
  --------------------------------------------------
  dir  [[$]PATH_AND_DIRECTORYNAME]
  cd   [[$]PATH_AND_DIRECTORYNAME]
  md   [$]PATH_AND_DIRECTORYNAME
  rd   [$]PATH_AND_DIRECTORYNAME
  del  [$]PATH_AND_FILENAME
  type [$]PATH_AND_FILENAME
  copy [$]PATH_AND_FILENAME [$]NEW_PATH_AND_FILENAME
  ren  [$]PATH_AND_FILENAME [$]NEW_FILENAME
}

// LIST DIRECTORY CONTENT
function cmd_dir(p1: string): byte;
var
  s: string;
begin
  result := 0;
  try
    if length(p1) = 0 then
    begin
      getdir(0, s);
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    end else chdir(p1);
  except
    {$IFNDEF X} writeln(ERR39); {$ELSE} Form1.Memo1.Lines.Add(ERR39); {$ENDIF}
    result := 1;
  end;
end;

// CHANGE DIRECTORY OR GET NAME
function cmd_cd(p1: string): byte;
var
  s: string;
begin
  result := 0;
  try
    if length(p1) = 0 then
    begin
      getdir(0, s);
      {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    end else chdir(p1);
  except
    {$IFNDEF X} writeln(ERR40); {$ELSE} Form1.Memo1.Lines.Add(ERR40); {$ENDIF}
    result := 1;
  end;
end;

// MAKE DIRECTORY
function cmd_md(p1: string): byte;
begin
  if CreateDir(p1) then result := 0 else
  begin
    {$IFNDEF X} writeln(ERR41); {$ELSE} Form1.Memo1.Lines.Add(ERR41); {$ENDIF}
    result := 1;
  end;
end;

// REMOVE EMPTY DIRECTORY
function cmd_rd(p1: string): byte;
begin
  if RemoveDir(p1) then result := 0 else
  begin
    {$IFNDEF X} writeln(ERR42); {$ELSE} Form1.Memo1.Lines.Add(ERR42); {$ENDIF}
    result := 1;
  end;
end;

// ERASE FILE
function cmd_del(p1: string): byte;
begin
  if not DeleteFile(p1) then
  begin
    {$IFNDEF X} writeln(ERR43); {$ELSE} Form1.Memo1.Lines.Add(ERR43); {$ENDIF}
    result := 1;
  end else result := 0;
end;

// TYPE FILE
function cmd_type(p1: string): byte;
var
  f: text;
  s: string;
begin
  result := 0;
  try
    assign(f, p1);
    reset(f);
    repeat
      {$IFNDEF X}
        readln(f, s);
        writeln(s);
      {$ELSE}
        readln(f, s);
        Form1.Memo1.Lines.Add(s);
      {$ENDIF}
    until eof(f);
    close(f);
  except
    {$IFNDEF X} writeln(ERR44); {$ELSE} Form1.Memo1.Lines.Add(ERR44); {$ENDIF}
    result := 1;
  end;
end;

// COPY FILE
function cmd_copy(p1, p2: string): byte;
begin
  if not CopyFile(p1, p2) then
  begin
    {$IFNDEF X} writeln(ERR45); {$ELSE} Form1.Memo1.Lines.Add(ERR45); {$ENDIF}
    result := 1;
  end else result := 0;
end;

// RENAME FILE
function cmd_ren(p1, p2: string): byte;
begin
  if not RenameFile(p1, p2) then
  begin
    {$IFNDEF X} writeln(ERR46); {$ELSE} Form1.Memo1.Lines.Add(ERR46); {$ENDIF}
    result := 1;
  end else result := 0;
end;

function cmd_sys(op: byte; p1, p2: string): byte;
var
  s1, s2: string; // parameters in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (op >= 99) and (op <= 101) then
  begin
    if (length(p1) = 0) or (length(p2) = 0) then
    begin
      {$IFNDEF X}
        writeln(ERR05); // Parameters required!
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR05);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end else
  begin
    if (length(p1) = 0) and (op >= 96)  then
    begin
      {$IFNDEF X}
        writeln(ERR05); // Parameters required!
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
    if length(s1) = 0 then s1 := p1;
  end;
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
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
  end;
end;
