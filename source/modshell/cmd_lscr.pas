{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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
}

// COMMAND 'LOADSCR'
procedure cmd_loadscr(p1: string);
var
  line: byte;
  fpn, fp, fn: string;
  s: string;
  sf: textfile;
  s1: string;               // parameters in other type

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := isitvariable(p1);
  if length(s1) = 0 then s1 := p1;
  fp := extractfilepath(s1);
  fn := extractfilename(s1);
  if length(fp) = 0 then
  begin
    {$IFDEF GO32V2}
      fp := getexedir + proj;
      createdir(fp);
    {$ELSE}
      fp := getuserdir + PRGNAME;
      createdir(fp);
      fp := getuserdir + PRGNAME + SLASH + proj;
      createdir(fp);
    {$ENDIF}
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
        if s[1] <> COMMENT then
        begin
          if line <= int(SCRBUFFSIZE - 1) then
          begin
            sbuffer[line] := s;
            if line < int(SCRBUFFSIZE - 1) then inc(line);
          end else
          begin
            writeln(ERR23);
            exit;
          end;
        end;
      end;
    until eof(sf);
    closefile(sf);
  except
    writeln(ERR22 + fpn);
  end;
end;
