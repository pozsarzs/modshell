{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_stack.pas                                                            | }
{ | use an variable array as a LIFO storage                                  | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0    p1    p2   p3
  ------------------------
  stack ARRAY push [$]DATA
  stack ARRAY pop  $TARGET

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |  x  |     |
  p2 |     |     |     |     |     |  x  |
  p3 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'STACK'
function cmd_stack(p1, p2, p3: string): integer;
begin
  result := 0;
end;
