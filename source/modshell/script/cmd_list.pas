{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_list.pas                                                             | }
{ | command 'list'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0
  ----
  list
}

// COMMAND 'LIST'
procedure cmd_list;
var
  y, line: byte;

begin
  y := 0;
  for line := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[line]) > 0 then
    begin
      writeln(sbuffer[line]);
      inc(y);
      if y >= (screenheight - 6) then
      begin
        write(MSG23); readkey;
        write(#13); clreol;
        y := 0;
      end;
    end;
end;
