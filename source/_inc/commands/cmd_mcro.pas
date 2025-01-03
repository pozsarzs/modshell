{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mcro.pas                                                             | }
{ | command 'macro'                                                          | }
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
  ----------------------------------
  macro
  macro NAME command with parameters
     | var |const|varr |carr |text |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  +  |  +  |  +  |  +  |  -  |  -  |
  p2 |  +  |  +  |  +  |  +  |  +  |  -  |
  p3 |  +  |  +  |  +  |  +  |  -  |  -  |
  p4 |  +  |  +  |  +  |  +  |  -  |  -  |
  p5 |  +  |  +  |  +  |  +  |  -  |  -  |
  p6 |  +  |  +  |  +  |  +  |  -  |  -  |
  p7 |  +  |  +  |  +  |  +  |  -  |  -  |
}

// SET PREDEFINED MACROS
procedure setdefaultmacros;
begin
  with macros[0] do
  begin
    mname := 'mydev0';
    mcommand := 'set dev0 ser /dev/ttyUSB1 9600 8 n 1';
  end;
  with macros[1] do
  begin
    mname := 'mypro0';
    mcommand := 'set pro0 rtu 1';
  end;
  with macros[2] do
  begin
    mname := 'mycon0';
    mcommand := 'set con0 dev0 pro0';
  end;
end;

// CLEAR ALL MACROS
procedure clearallmacros;
var
  i: byte;
begin
  for i := 0 to MCRBUFFSIZE - 1 do
    with macros[i] do
    begin
      mname := '';
      mcommand := '';
    end;
  setdefaultmacros;
end;

// IF IT IS A MACRO, IT RETURNS THEIRS NUMBER
function intisitmacro(s: string): integer;
var
  i: integer;
begin
  result := 0;
  if length(s) > 1 then
    for i := 0 to MCRBUFFSIZE - 1 do
      if macros[i].mname = lowercase(s) then result := i;
end;

// IF IT IS A MACRO, IT RETURNS TRUE
function boolisitmacro(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if length(s) > 1 then
    for i := 0 to MCRBUFFSIZE - 1 do
      if (macros[i].mname = lowercase(s)) then result := true;
end;

// IF IT IS A MACRO, IT RETURNS ITS VALUE
function isitmacro(s: string): string;
var
  i: integer;
begin
  result := '';
  if length(s) > 1 then
    for i := 0 to MCRBUFFSIZE - 1 do
      if (macros[i].mname = lowercase(s))
        then result := macros[i].mcommand;
end;

// COMMAND 'macro'
function cmd_macro(p1, p2: string): byte;
var
  b, bb: byte;
  l: byte;
  {$IFNDEF X} line: integer; {$ENDIF}
  {$IFDEF X} s: string; {$ENDIF}
  s1, s2: string; // parameters in other type
  valid: boolean = true;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if length(p1) = 0 then
  begin
    {$IFNDEF X} line := 0; {$ENDIF}
    for l := 0 to MCRBUFFSIZE - 1 do
      if length(macros[l].mname) > 0 then
      begin
        {$IFNDEF X}
          xywrite(2, wherey, false,  macros[l].mname);
          xywrite(20, wherey, false, macros[l].mcommand);
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
          s := '$' + macros[l].mname;
          for b := 1 to 28 - length(s) do s := s + ' ';
          s := s + macros[l].mcommand;
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
      if verbosity(2) then writeln(ERR59);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR59);
    {$ENDIF}
  end else
  begin
    // COMPARING EXISTING NAMES WITH THE NEW ONE
    valid := true;
    for l := 0 to MCRBUFFSIZE - 1 do
      if macros[l].mname = lowercase(p1) then
      begin
        valid := false;
        break;
      end;
    if valid then
    begin
      // CHECK EMPTY SPACE IN VARIABLE TABLE
      valid := false;
      for l := 0 to MCRBUFFSIZE - 1 do
        if length(macros[l].mname) = 0 then
        begin
          valid := true;
          break;
        end;
      if not valid then
      begin
        // Cannot define more variable!
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR60);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR60);
        {$ENDIF}
        result := 1;
        exit;
      end;
    end;
    s2 := p2;
    s2 := stringreplace(s2, 'macro' + #32, '', [rfReplaceAll]);
    s2 := stringreplace(s2, s1 + #32, '', [rfReplaceAll]);
    // PRIMARY MISSION
    with macros[l] do
    begin
      mname := lowercase(s1);
      mcommand := s2;
    end;
  end;
end;
