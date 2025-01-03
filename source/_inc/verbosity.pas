{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | verbosity.pas                                                            | }
{ | enable/disable a message                                                 | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// ENABLE/DISABLE A MESSAGE
function verbosity(messagelevel: byte): boolean;
{ 
 messagelevel:
   1: normal message
   2: error message
}
var
  b: byte;
  verbositylevel: byte = 0;
const
  LEVELS: array[0..2] of string = ('all', 'error', 'nothing');
begin
  result := true;
  if appmode = 4 then
  begin
    for b := 0 to 2 do
      if lowercase(vars[16].vvalue) = LEVELS[b] then verbositylevel := b;
    case verbositylevel of
      1: if messagelevel < 2 then result := false;
      2: result := false;
    end;
  end;
end;
