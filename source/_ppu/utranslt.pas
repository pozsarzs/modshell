{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | utranslt.pas                                                             | }
{ | translate messages                                                       | }
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
  i18file: array[0..2] of string;
begin
  result := false;
  i18file[0] := getexedir + 'message' + SLASH + lang + SLASH + basename + extension; // DOS, Windows, Unix-like
  i18file[1] := '/usr/share/locale/' + lang + '/LC_MESSAGES/' + basename + extension; // Unix-like only
  i18file[2] := '/usr/local/share/locale/' + lang + '/LC_MESSAGES/' + basename + extension; // Unix-like only
  for b := 0 to 2 do
    if fileexists(i18file[b]) then
    begin
      translateresourcestrings(i18file[b]);
      result := true;
    end;
end;

end.
