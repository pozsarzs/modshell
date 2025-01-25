{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_run.pas                                                              | }
{ | command 'run'                                                            | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0  p1
  -------------
  run [-h] [-s]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
}

// COMMAND 'RUN'
function cmd_run(p1, p2: string): byte;
var
  holdvariables: boolean;
  projectname: string;
  stepbystep: boolean;
begin
  result := 0;
  if not scriptisloaded then
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
  // CHECK LENGTH OF PARAMETERS
  if ((length(p1) > 0) and (p1 = '-h')) or 
     ((length(p2) > 0) and (p2 = '-h')) 
    then holdvariables := true 
    else holdvariables := false;
  if ((length(p1) > 0) and (p1 = '-s')) or 
     ((length(p2) > 0) and (p2 = '-s')) 
    then stepbystep := true 
    else stepbystep := false;
  projectname := vars[12].vvalue;
  clearallconstants;
  clearallmacros;
  clearallvariables;
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
    if stepbystep then
    begin
      {$IFNDEF X}
        readkey;
      {$ELSE}
        ShowMessage(MSG78);
      {$ENDIF}
    end;
  until (scriptline = SCRBUFFSIZE - 1) or (splitted[0] = COMMANDS[1]);
  if not holdvariables then
  begin
    clearallconstants;
    clearallmacros;
    clearallvariables;
  end;
  cmd_set('project', projectname, '', '', '', '', '');
end;
