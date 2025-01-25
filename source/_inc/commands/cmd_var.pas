{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// SET PREDEFINED VARIABLES
procedure setdefaultvariables;
begin
  with vars[14] do
  begin
    vname := 'verbose';
    vvalue := 'ALL';
    vreadonly := false;
    vmonitored := false;
  end;
end;

// CLEAR ALL VARIABLES AND SET PREDEFINED ONES
procedure clearallvariables;
var
  i: byte;
begin
  for i := 0 to VARBUFFSIZE - 1 do
    with vars[i] do
    begin
      if not vreadonly then
      begin
        vname := '';
        vvalue := '';
        vmonitored := false;
      end;
    end;
  setdefaultvariables;
end;

// IF IT IS A VARIABLE, IT RETURNS THEIRS NUMBER
function intisitvariable(s: string): integer;
var
  i: integer;
begin
  result := 0;
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and not vars[i].vreadonly
        then result := i;
  end;
end;

// IF IT IS A VARIABLE, IT RETURNS TRUE
function boolisitvariable(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and not vars[i].vreadonly
        then result := true;
  end;
end;

// IF IT IS A VARIABLE, IT RETURNS ITS VALUE
function isitvariable(s: string): string;
var
  i: integer;
begin
  result := '';
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and not vars[i].vreadonly
        then result := stringreplace(vars[i].vvalue,
               #92 + #32 , #32, [rfReplaceAll]);
  end;
end;

// COMMAND 'var'
function cmd_var(p1, p2: string): byte;
var
  b, bb: byte;
  l: byte;
  {$IFNDEF X} line: integer; {$ENDIF}
  {$IFDEF X} s: string; {$ENDIF}
  s1, s2: string;
  valid: boolean = true;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    {$IFNDEF X} line := 0; {$ENDIF}
    for l := 0 to VARBUFFSIZE - 1 do
      if (length(vars[l].vname) > 0) and not vars[l].vreadonly then
      begin
        {$IFNDEF X}
          xywrite(2, wherey, false, '$' + vars[l].vname);
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
        {$ELSE}
          s := '$' + vars[l].vname;
          for b := 1 to 28 - length(s) do s := s + ' ';
          s := s + vars[l].vvalue;
          Form1.Memo1.Lines.Add(s);
        {$ENDIF}
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
  if not valid then
  begin
    // Illegal character in the variable name!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR15);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR15);
    {$ENDIF}
  end else
  begin
    // COMPARING EXISTING NAMES WITH THE NEW ONE
    valid := true;
    for l := 0 to ARRBUFFSIZE - 1 do
      if arrays[l].aname = lowercase(p1) then valid := false;
    for l := 0 to VARBUFFSIZE - 1 do
      if vars[l].vname = lowercase(p1) then valid := false;
    if not valid then
    begin
      // There is already a variable or a constant with that name.
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR17);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR17);
      {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK EMPTY SPACE IN VARIABLE TABLE
    valid := false;
    for l := 0 to VARBUFFSIZE - 1 do
      if length(vars[l].vname) = 0 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // Cannot define more variable!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR16);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR16);
      {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
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
    // CHANGE '\ ' TO SPACE IN P2
    s2 := stringreplace(s2, #92 + #32, #32, [rfReplaceAll]);
    // PRIMARY MISSION
    with vars[l] do
    begin
      vname := lowercase(s1);
      vvalue := s2;
      vreadonly := false;
      vmonitored := false;
    end;
  end;
end;
