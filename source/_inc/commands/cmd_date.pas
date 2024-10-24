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
{
  p0   p1
  --------------
  date [$TARGET]
}

// COMMAND 'DATE'
function cmd_date(p1: string): byte;
var
  dt: string;
  y, mh, d, w, h, m, s, cs: word;
begin
  result := 0;
  getdate(y, mh, d, w);
  gettime(h, m, s, cs);
  dt := inttostr(y) + '.' + addzero(mh) + '.' + addzero(d)+ '. ' + addzero(h) + ':' + addzero(m) + ':' + addzero(s);
  if length(p1) = 0
    then {$IFNDEF X} writeln(dt) {$ELSE} Form1.Memo1.Lines.Add(dt) {$ENDIF} else
    begin
      // CHECK P1 PARAMETER
      if not boolisitvariable(p1) then
      begin
        // No such variable!
        {$IFNDEF X} writeln(ERR19 + p1); {$ELSE} Form1.Memo1.Lines.Add(ERR19 + p1); {$ENDIF}
        result := 1;
        exit;
      end;
      vars[intisitvariable(p1)].vvalue := dt;
    end;
end;
