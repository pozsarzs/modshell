{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_send.pas                                                             | }
{ | command 'sendmeth'                                                       | }
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
  sendmeth [chr|str|swap]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |     |     |     |     |     |  x  |
}

// COMMAND 'SENDMETH'
function cmd_sendmeth(p1: string): byte;
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
      writeln(METHOD[sendmeth]);
    {$ELSE}
      Form1.Memo1.Lines.Add(METHOD[sendmeth]);
    {$ENDIF}
    exit;
  end;
  // CHECK P1 PARAMETER
  valid := false;
  for ea := 3 to 5 do
    if METHOD[ea] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for ea := 3 to 5 do s := s + ' ' + METHOD[ea];
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
    if sendmeth < 4 then sendmeth := 4;
    inc(sendmeth);
    if sendmeth = 6 then sendmeth := 4;
  end else sendmeth := ea;
  {$IFNDEF X}
    writeln(MSG90 + METHOD[sendmeth]);
  {$ELSE}
    Form1.Memo1.Lines.Add(MSG90 + METHOD[sendmeth]);
    Form1.StatusBar1.Panels[2].Text := upcase(METHOD[sendmeth]);
    Form3.StatusBar1.Panels[2].Text := upcase(METHOD[sendmeth]);
    Form4.StatusBar1.Panels[2].Text := upcase(METHOD[sendmeth]);
    Form5.StatusBar1.Panels[2].Text := upcase(METHOD[sendmeth]);
  {$ENDIF}
end;
