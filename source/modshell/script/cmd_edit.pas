{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_edit.pas                                                             | }
{ | command 'edit'                                                           | }
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
  ------------------
  edit [LINE_NUMBER]
}

// COMMAND 'EDIT'
function cmd_edit(p1: string): byte;
var
  c: char;
  i1: integer;       // parameter in other format
  s1: string;        // parameter in other format
  line: integer;
  editline: string;

begin
  result := 0;
  if not scriptisloaded then
  begin
    writeln(MSG38);  // No script loaded.
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  if length(s1) = 0 then s1 := p1;
  i1 := strtointdef(s1, -1);
  if (i1 < 1) or (i1 > SCRBUFFSIZE) then
  begin
    writeln('1st ' + MSG05 + ' 1-' + inttostr(SCRBUFFSIZE)); // What is the 1st parameter?
    result := 1;
    exit;
  end;
  writeln('Keys: [up][down][left][right][Ins][Del][Backspace][Enter][Esc]');
  //repeat
    //repeat
      //sbuffer[line]
    //until c = #13
  //until c = #27
end;
