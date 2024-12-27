{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_labl.pas                                                             | }
{ | command 'label'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1  
  ----------
  label NAME
}

// COMMAND 'LABEL'
function cmd_label: byte;
begin
  result := 0;
  if appmode <> 4 then
  begin
    {$IFNDEF X}
      if verbosity(2) then writeln(MSG33);
    {$ELSE}
      Form1.Memo1.Lines.Add(MSG33);
    {$ENDIF}
    result := 1;
  end;
end;
