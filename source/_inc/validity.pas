{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | validity.pas                                                             | }
{ | a function                                                               | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// CHECK VALIDITY OF DEV?/PRO?/CON?'
function validity(sets, number: byte): boolean;
begin
  case sets of
    0: result := dev[number].valid;
    1: result := prot[number].valid;
    2: result := conn[number].valid;
  else
    result := false;
  end;
  if not result then
    {$IFNDEF X}
      writeln(PREFIX[sets], number, MSG06);
    {$ELSE}
      Form1.Memo1.Lines.Add(PREFIX[sets] + inttostr(number) + MSG06);
    {$ENDIF}
end;
