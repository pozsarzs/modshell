{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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

// command 'date'
procedure cmd_date;
var
  y, mh, d, w, h, m, s, cs: word;

  // insert zero before [0-9]
  function addzero(v: word): string;
  var
    u: string;
  begin
    str(v:0, u);
    if length(u) = 1 then u := '0' + u;
    addzero := u;
  end;

begin
  getdate(y, mh, d, w);
  gettime(h, m, s, cs);
  writeln(inttostr(y) + '.' + inttostr(mh) + '.' + inttostr(d)+ '. ' +
  addzero(h) + ':' + addzero(m) + ':' + addzero(s));
end;
