{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_inpt.pas                                                             | }
{ | command 'inputmeth'                                                      | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0        p1
  -----------------------
  inputmeth [an|hex|swap]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
}

// COMMAND 'INPUTMETH'
function cmd_inputmeth(p1: string): byte;
var
  ea: byte;
  s: string = '';
  valid: boolean;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    {$IFNDEF X}
      writeln(METHOD[inputmeth]); {$ELSE} Form1.Memo1.Lines.Add(METHOD[inputmeth]); {$ENDIF}
    exit;
  end;
  // CHECK P1 PARAMETER
  valid := false;
  for ea := 1 to 3 do
    if METHOD[ea] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for ea := 1 to 3 do s := s + ' ' + METHOD[ea];
    {$IFNDEF X}
      if verbosity(2) then writeln(s);
    {$ELSE}
      Form1.Memo1.Lines.Add(s);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  if ea = 3 then
  begin
    inc(inputmeth);
    if inputmeth = 3 then inputmeth := 1;
  end else inputmeth := ea;
  {$IFNDEF X}
    writeln(MSG89 + METHOD[inputmeth]);
  {$ELSE}
    Form1.Memo1.Lines.Add(MSG89 + METHOD[inputmeth]);
    Form1.StatusBar1.Panels[0].Text := upcase(METHOD[inputmeth]);
    Form3.StatusBar1.Panels[0].Text := upcase(METHOD[inputmeth]);
    Form4.StatusBar1.Panels[0].Text := upcase(METHOD[inputmeth]);
    Form5.StatusBar1.Panels[0].Text := upcase(METHOD[inputmeth]);
  {$ENDIF}
end;
