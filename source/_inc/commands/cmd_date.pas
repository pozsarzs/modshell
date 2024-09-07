{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_date.pas                                                             | }
{ | command 'date'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// COMMAND 'DATE'
function cmd_date: byte;
var
  y, mh, d, w, h, m, s, cs: word;

begin
  result := 0;
  getdate(y, mh, d, w);
  gettime(h, m, s, cs);
  {$IFNDEF X}
    writeln(inttostr(y) + '.' + addzero(mh) + '.' + addzero(d)+ '. ' +
      addzero(h) + ':' + addzero(m) + ':' + addzero(s));
  {$ELSE}
    Form1.Memo1.Lines.Add(inttostr(y) + '.' + addzero(mh) + '.' + addzero(d)+ '. ' +
      addzero(h) + ':' + addzero(m) + ':' + addzero(s));
  {$ENDIF}
  {$IFNDEF X}
    writeln;
  {$ELSE}
    Form1.Memo1.Lines.Add('');
  {$ENDIF}
end;
