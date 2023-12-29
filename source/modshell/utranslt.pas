{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | utranslt.pas                                                             | }
{ | Translate messages                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}{$MACRO ON}
unit utranslt;
interface
uses
 gettext,
 ucommon,
 sysutils;

{$IFDEF UNIX}  
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}

function translatemessages(lang, basename, extension: string): boolean;

implementation

// TRY TO TRANSLATE MESSAGES
function translatemessages(lang, basename, extension: string): boolean;
var
  b: byte;
  fn: string;
  i18dir: array[0..2] of string;
begin
  result := false;
  fn := SLASH + lang + SLASH + basename + extension;
  i18dir[0] := getexedir + 'message'; // DOS, Windows, Unix-like
  i18dir[1] := '/usr/share/locale/'; // Unix-like only
  i18dir[2] := '/usr/local/share/locale/'; // Unix-like only
  for b := 0 to 2 do
    if fileexists(i18dir[b] + fn) then
    begin
      translateresourcestrings(i18dir[b] + fn);
      result := true;
    end;
end;

end.
