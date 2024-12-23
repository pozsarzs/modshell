{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | intrprpt.pas                                                             | }
{ | script interpreter                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// SCRIPT INTERPRETER
procedure interpreter(f: string);
var
 s: string;
  sf: textfile;

begin
  if not fileexists(f) then quit(2, false, ERR21 + f + '!');
  for scriptline := 0 to SCRBUFFSIZE - 1 do sbuffer[scriptline] := '';
  assignfile(sf, f);
  try
    reset(sf);
    scriptline := 0;
    repeat
      readln(sf,s);
      if length(s) > 0 then
      begin
        // remove space and tab from start of line
        while (s[1] = #32) or (s[1] = #9) do
          delete(s, 1, 1);
        if s[1] <> COMMENT then
        begin
          if scriptline <= int(SCRBUFFSIZE - 1) then
          begin
            sbuffer[scriptline] := s;
            if scriptline < int(SCRBUFFSIZE - 1) then inc(scriptline);
          end else quit(4, false, ERR23);
        end;
      end;
    until eof(sf);
    closefile(sf);
  except
    quit(3, false, ERR22 + f + '!');
  end;
  // parsing script
  scriptline := 0;
  repeat
    if length(sbuffer[scriptline]) > 0 then parsingcommands(sbuffer[scriptline]);
    // execute goto command
    if scriptlabel = 0 then inc(scriptline) else
    begin
      scriptline := scriptlabel;
      scriptlabel := 0;
    end;
  until (scriptline = SCRBUFFSIZE - 1) or (sbuffer[scriptline] = COMMANDS[1]);
end;
