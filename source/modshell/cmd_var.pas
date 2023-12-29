{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_var.pas                                                              | }
{ | command 'var'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1   p2
  -------------------
  var
  var NAME [[$]VALUE]
}

// COMMAND 'VAR'
procedure cmd_var(p1, p2: string);
var
  b, bb: byte;
  l: byte;
  line: byte;
  s1, s2: string;         // parameters in other type
  valid: boolean = true;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    line := 0;
    for l := 0 to 63 do
      if length(vars[l].vname) > 0 then
      begin
        xywrite(2, wherey, false, '$' + vars[l].vname);
        xywrite(20, wherey, false, vars[l].vvalue);
        writeln;
        inc(line);
        if line >= (screenheight - 4) then
        begin
          write(MSG23); readkey;
          writeln;
          line := 0;
        end;
      end;        
    exit;
  end;
  // SEARCH ILLEGAL CHARACTERS IN P1
  s1 := p1;
  for b := 1 to length(s1) do
  begin
    for bb := 0 to 44 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 46 to 47 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 58 to 64 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 91 to 94 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 96 to 96 do
      if s1[b] = chr(bb) then valid := false;
    for bb := 123 to 255 do
      if s1[b] = chr(bb) then valid := false;
  end;
  if not valid then writeln(ERR15) else
  begin
    // COMPARING EXISTING NAMES WITH THE NEW ONE
    valid := true;
    for l := 0 to 63 do
      if vars[l].vname = lowercase(p1) then valid := false;
    if not valid then
    begin
      writeln(ERR17);
      exit;
    end;
    // CHECK EMPTY SPACE IN VARIABLE TABLE
    valid := false;
    for l := 0 to 63 do
      if length(vars[l].vname) = 0 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      writeln(ERR16);
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
    begin
      s2 := isitvariable(p2);
      if length(s2) = 0 then s2 := p2;
    end;
    // CHANGE '\ ' TO SPACE IN P2
    s2 := stringreplace(s2, #92+#32, #32, [rfReplaceAll]);
    // PRIMARY MISSION
    vars[l].vname := lowercase(s1);
    vars[l].vvalue := s2;
  end;
end;
