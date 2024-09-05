{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_cons.pas                                                             | }
{ | command 'const'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1   p2
  -------------------
  const
  const NAME [$]VALUE
}

// SET PREDEFINED CONSTANTS
procedure setdefaultconstants;
begin
  with vars[0] do
  begin
    vname := '?';
    vvalue := '0';
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[1] do
  begin
    vname := 'pi';
    vvalue := floattostr(pi);
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[2] do
  begin
    vname := 'euler';
    vvalue := floattostr(exp(1));
    vreadonly := true;
    vmonitored := false;
  end;
end;

// IF S IS A CONSTANT, IT RETURNS theirs number
function intisitconstant(s: string): integer;
var
  i: integer;
begin
  result := 0;
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE-1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
      then result := i;
  end;
end;

// IF S IS A CONSTANT, IT RETURNS TRUE
function boolisitconstant(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE-1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
      then result := true;
  end;
end;

// IF S IS A CONSTANT, IT RETURNS ITS VALUE
function isitconstant(s: string): string;
var
  i: integer;
begin
  result := '';
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE-1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
      then result := stringreplace(vars[i].vvalue, #92 + #32 , #32, [rfReplaceAll]);
  end;
end;

// COMMAND 'CONS'
function cmd_const(p1, p2: string): byte;
var
  b, bb: byte;
  l: byte;
  line: byte;
  s1, s2: string;         // parameters in other type
  valid: boolean = true;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    line := 0;
    for l := 0 to VARBUFFSIZE-1 do
      if (length(vars[l].vname) > 0) and vars[l].vreadonly  then
      begin
        xywrite(2, wherey, false, '$' + uppercase(vars[l].vname));
        xywrite(20, wherey, false, vars[l].vvalue);
        writeln;
        inc(line);
        if line >= (termheight - 4) then
        begin
          write(MSG23); readkey;
          write(#13); clreol;
          writeln;
          line := 0;
        end;
      end;        
    exit;
  end;
  if (length(p1) > 0) and (length(p2) = 0) then
  begin
    writeln(ERR05);
    result := 1;
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
  if not valid then writeln(ERR33) else
  begin
    // COMPARING EXISTING NAMES WITH THE NEW ONE
    valid := true;
    for l := 0 to VARBUFFSIZE-1 do
      if vars[l].vname = lowercase(p1) then valid := false;
    if not valid then
    begin
      writeln(ERR17);
      result := 1;
      exit;
    end;
    // CHECK EMPTY SPACE IN VARIABLE TABLE
    valid := false;
    for l := 0 to VARBUFFSIZE-1 do
      if length(vars[l].vname) = 0 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      writeln(ERR34);
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
    begin
      if boolisitconstant(p2) then s2 := isitconstant(p2);
      if boolisitvariable(p2) then s2 := isitvariable(p2);
      if length(s2) = 0 then s2 := p2;
    end;
    // CHANGE '\ ' TO SPACE IN P2
    s2 := stringreplace(s2, #92 + #32, #32, [rfReplaceAll]);
    // PRIMARY MISSION
    vars[l].vname := lowercase(s1);
    vars[l].vvalue := s2;
    vars[l].vreadonly := true;
    vars[l].vmonitored := false;
  end;
end;
