{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

{$MODE OBJFPC} {$H+} {$MACRO ON}

unit utranslt;
interface
uses
  GetText,
  SysUtils,
  ucommon;

{$DEFINE SLASH := DirectorySeparator}

function translatemessages(lang, basename, extension: string): boolean;

implementation

// TRY TO TRANSLATE MESSAGES
function translatemessages(lang, basename, extension: string): boolean;
var
  b: byte;
  i18file: array[0..3] of string;
begin
  result := false;
  i18file[1] := getexedir + 'message' + SLASH + lang + SLASH +
                basename + extension;
  {$IFDEF WINDOWS}
    i18file[0] := getexedir + 'message\' + lang + '-windows\' +
                  basename + extension;
  {$ENDIF}
  {$IFDEF UNIX}
    i18file[2] := '/usr/share/locale/' + lang + '/LC_MESSAGES/' +
                  basename + extension;
    i18file[3] := '/usr/local/share/locale/' + lang + '/LC_MESSAGES/' +
                  basename + extension;
  {$ENDIF}
  for b := 0 to 3 do
    if fileexists(i18file[b]) then
    begin
      translateresourcestrings(i18file[b]);
      break;
      result := true;
    end;
end;

end.
