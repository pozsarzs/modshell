{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_lscr.pas                                                             | }
{ | command 'loadscr'                                                        | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0      p1
  ----------------------------
  loadscr [$]PATH_AND_FILENAME

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'LOADSCR'
function cmd_loadscr(p1: string): byte;
var
  line: integer;
  fpn, fp, fn: string;
  s: string;
  sf: textfile;
  s1: string;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
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
  if length(fp) = 0 then
  begin
    fp := vars[13].vvalue;
    ForceDirectories(fp);
    fp := fp + SLASH;
  end;
  fpn := fp + fn;
  // PRIMARY MISSION
  for line := 0 to SCRBUFFSIZE - 1 do sbuffer[line] := '';
  assignfile(sf, fpn);
  try
    reset(sf);
    line := 0;
    repeat
      readln(sf,s);
      if length(s) > 0 then
      begin
        // REMOVE SPACE AND TAB FROM START OF LINE
        while (s[1] = #32) or (s[1] = #9) do
          delete(s, 1, 1);
          if line <= int(SCRBUFFSIZE - 1) then
          begin
            sbuffer[line] := s;
            if line < int(SCRBUFFSIZE - 1) then inc(line);
          end else
          begin
            // Script buffer is full!
            {$IFNDEF X}
              if verbosity(2) then writeln(ERR23);
            {$ELSE}
              Form1.Memo1.Lines.Add(ERR23);
            {$ENDIF}
            result := 1;
            exit;
          end;
      end;
    until eof(sf);
    closefile(sf);
    scriptisloaded := true;
    scriptlastline := line;
  except
    // Cannot load script!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR22 + fpn);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR22 + fpn);
    {$ENDIF}
    result := 1;
  end;
end;
