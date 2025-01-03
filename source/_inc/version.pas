{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | version.pas                                                              | }
{ | show version and build information                                       | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// SHOW VERSION AND BUILD INFORMATION
procedure version(h: boolean);
var
  {$IFDEF UNIX}
    hostname: string = {$I %HOSTNAME%};
    username: string = {$I %USER%};
  {$ELSE}
    hostname: string = {$I %COMPUTERNAME%};
    username: string = {$I %USERNAME%};
  {$ENDIF}
begin
  {$IFNDEF X}
    writeln(PRGNAME + ' v' + PRGVERSION + ' * ' + MSG02);
    writeln(PRGCOPYRIGHT);
    writeln;
    writeln(MSG94, {$I %DATE%}, ' ', {$I %TIME%});
    if length(username) > 0 then
    begin
      if length(hostname) > 0
        then writeln(MSG95, username + '@' + hostname)
        else writeln(MSG95, username);
    end;
    writeln(MSG96, {$I %FPCVERSION%});
    write(MSG97, {$I %FPCTARGETOS%});
    if lowercase({$I %FPCTARGETOS%}) = 'go32v2' then write(' (DOS)');
    writeln;
    writeln(MSG98, {$I %FPCTARGETCPU%});
  {$ELSE}
    with Form1 do
    begin
      Memo1.Lines.Add(PRGNAME + ' v' + PRGVERSION + ' * ' + MSG02);
      Memo1.Lines.Add(PRGCOPYRIGHT);
      Memo1.Lines.Add('');
      Memo1.Lines.Add(MSG94 + {$I %DATE%} + ' ' + {$I %TIME%});
      if length(username) > 0 then
      begin
        if length(hostname) > 0
          then Memo1.Lines.Add(MSG95 + username + '@' + hostname)
          else Memo1.Lines.Add(MSG95 + username);
      end;
      Memo1.Lines.Add(MSG96 + {$I %FPCVERSION%});
      Memo1.Lines.Add(MSG97 + {$I %FPCTARGETOS%});
      Memo1.Lines.Add(MSG98 + {$I %FPCTARGETCPU%});
    end;
  {$ENDIF}
  if h then quit(0, false, '');
end;
