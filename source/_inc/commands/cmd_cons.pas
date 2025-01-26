{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  const NAME [[$]VALUE]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |     |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// SET PREDEFINED CONSTANTS
procedure setdefaultconstants;
var
  b: byte;
  y, mh, d, w: word;
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
  for b:= 3 to 10 do
    with vars[b] do
    begin
      vname := 'b' + inttostr(strtoint(DEV_SPEED[b - 3]) div 1000);
      vvalue := DEV_SPEED[b - 3];
      vreadonly := true;
      vmonitored := false;
    end;
  with vars[11] do
  begin
    vname := 'home';
    vvalue := getuserdir;
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[12] do
  begin
    vname := 'prjname';
    vvalue := '';
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[13] do
  begin
    vname := 'prjdir';
    vvalue := '';
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[14] do
  begin
    vname := 'sqrt2';
    vvalue := floattostr(sqrt(2));
    vreadonly := true;
    vmonitored := false;
  end;
  with vars[15] do
  begin
    vname := 'sqrt3';
    vvalue := floattostr(sqrt(3));
    vreadonly := true;
    vmonitored := false;
  end;
  // Belphegor's prime was first discovered by Harvey Dubner
  // = 10^31 + 666 * 10^14 + 1
  y := 0; mh := 0; d := 0; w := 0;
  getdate(y, mh, d, w);
  if (mh = 10) and (d = 31) then
    with vars[66] do
    begin
      vname := 'belfegor';
      vvalue := '1000000000000066600000000000001';
      vreadonly := true;
      vmonitored := false;
    end;
end;

// CLEAR ALL CONSTANTS AND SET PREDEFINED ONES
procedure clearallconstants;
var
  i: byte;
begin
  for i := 0 to VARBUFFSIZE - 1 do
    with vars[i] do
    begin
      if vreadonly then
      begin
        vname := '';
        vvalue := '';
        vreadonly := false;
        vmonitored := false;
      end;
    end;
  setdefaultconstants;
end;

// IF IT IS A CONSTANT, IT RETURNS THEIRS NUMBER
function intisitconstant(s: string): integer;
var
  i: integer;
begin
  result := 0;
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
        then result := i;
  end;
end;

// IF IT IS A CONSTANT, IT RETURNS TRUE
function boolisitconstant(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
        then result := true;
  end;
end;

// IF IT IS A CONSTANT, IT RETURNS ITS VALUE
function isitconstant(s: string): string;
var
  i: integer;
begin
  result := '';
  if (s[1] = #36) and (length(s) > 1) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to VARBUFFSIZE - 1 do
      if (vars[i].vname = lowercase(s)) and vars[i].vreadonly
        then result := stringreplace(vars[i].vvalue,
                       #92 + #32 , #32, [rfReplaceAll]);
  end;
end;

// COMMAND 'const'
function cmd_const(p1, p2: string): byte;
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
      if (length(vars[l].vname) > 0) and vars[l].vreadonly  then
      begin
        {$IFNDEF X}
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
        {$ELSE}
          s := '$' + uppercase(vars[l].vname);
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
    // Illegal character in the constant name!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR33);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR33);
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
      // Cannot define more constant!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR34);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR34);
      {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if (length(p2) > 0) then
    begin
      if boolisitconstant(p2) then s2 := isitconstant(p2);
      if boolisitvariable(p2) then s2 := isitvariable(p2);
      if boolisitconstantarray(p2) then
        if boolvalidconstantarraycell(p2)
          then s2 := isitconstantarray(p2)
          else result := 1;
      if boolisitvariablearray(p2) then
        if boolvalidvariablearraycell(p2)
          then s2 := isitvariablearray(p2)
          else result := 1;
      if result = 1 then
      begin
        // No such array cell!
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR66 + p2);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR66 + p2);
        {$ENDIF}
        result := 1;
        exit;
      end;
      if length(s2) = 0 then s2 := p2;
    end;
    // CHANGE '\ ' TO SPACE IN P2
    s2 := stringreplace(s2, #92 + #32, #32, [rfReplaceAll]);
    // PRIMARY MISSION
    with vars[l] do
    begin
      vname := lowercase(s1);
      vvalue := s2;
      vreadonly := true;
      vmonitored := false;
    end;
  end;
end;
