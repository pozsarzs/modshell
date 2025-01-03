{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  
     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |     |  x  |     |     |     |
}

// COMMAND 'DATE'
function cmd_date(p1: string): byte;
var
  dt: string;
  s1: string;
  y, mh, d, w, h, m, s, cs: word;
begin
  result := 0;
  y := 0; mh := 0; d := 0; w := 0;
  h := 0; m := 0; s := 0; cs := 0;
  getdate(y, mh, d, w);
  gettime(h, m, s, cs);
  dt := inttostr(y) + '.' + addzero(mh) + '.' + addzero(d)+ '. ' +
        addzero(h) + ':' + addzero(m) + ':' + addzero(s);
  if length(p1) = 0
    then
      {$IFNDEF X}
        writeln(dt)
      {$ELSE}
        Form1.Memo1.Lines.Add(dt)
      {$ENDIF}
    else
    begin
      // CHECK P1 PARAMETER
      if (not boolisitvariable(p1)) and
         (not boolisitvariablearray(p1)) then
      begin
        // No such variable!
        {$IFNDEF X}
          if verbosity(2) then writeln(ERR19 + p1);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR19 + p1);
        {$ENDIF}
        result := 1;
        exit;
      end;
      if boolisitvariablearray(p1) then
        if not boolvalidvariablearraycell(p1) then
        begin
          // No such array cell!
          result := 1;
          exit;
        end;
      // PRIMARY MISSION
      if boolisitvariable(p1)
        then vars[intisitvariable(p1)].vvalue := dt
        else arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := dt;
    end;
end;
