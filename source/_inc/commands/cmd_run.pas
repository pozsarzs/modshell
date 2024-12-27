{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
}

// COMMAND 'RUN'
function cmd_run(p1, p2: string): byte;
var
  line: integer;
  stepbystep: boolean;
  holdvariables: boolean;
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
  clearallconstants;
  clearallmacros;
  clearallvariables;
  for line := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[line]) > 0 then
    begin
      if sbuffer[line][1] <> COMMENT then parsingcommands(sbuffer[line]);
      if stepbystep then
      begin
        {$IFNDEF X} readkey; {$ELSE} ShowMessage(MSG78); {$ENDIF}
      end;
    end;
  if not holdvariables then
  begin
    clearallconstants;
    clearallmacros;
    clearallvariables;
  end;
end;
