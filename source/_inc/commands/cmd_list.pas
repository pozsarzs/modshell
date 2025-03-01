{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
function cmd_list: byte;
var
  line: integer;
  {$IFNDEF X} y: integer; {$ENDIF}
begin
  result := 0;
  if not scriptisloaded then
  begin
    // No script loaded.
    {$IFNDEF X}
      writeln(MSG38);
    {$ELSE}
      Form1.Memo1.Lines.Add(MSG38);
    {$ENDIF}
    result := 1;
    exit;
  end;
  {$IFNDEF X} y := 0; {$ENDIF}
  for line := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[line]) > 0 then
    begin
      {$IFNDEF X}
        textcolor(colors[1]); textbackground(colors[0]);
        write(addsomezero(4, inttostr(line + 1)));
        textcolor(colors[0]); textbackground(colors[1]);
        writeln(' ' + sbuffer[line]);
        inc(y);
        if y >= (termheight - 6) then
        begin
          write(MSG23); readkey;
          write(#13); clreol;
          y := 0;
        end;
      {$ELSE}
        Form1.Memo1.Lines.Add(addsomezero(4, inttostr(line + 1)) + ' ' +
                              sbuffer[line]);
      {$ENDIF}
    end;
end;
