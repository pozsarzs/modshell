{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uconfig.pas                                                              | }
{ | Configuration file handler                                               | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}{$MACRO ON}
unit uconfig;
interface
uses
 ucommon,
 sysutils,
 inifiles;
var
  b: byte;
  confdir: string;
  ini: TINIFile;
  // settings from/to ini file
  backgroundcolor, foregroundcolor: integer;
  histbuff: array[0..255] of string;
  histitem: byte;
  histlast: byte;
const
  SECTION: array[0..1] of string = ('cmdline-colors','cmdline-history');

{$IFDEF UNIX}
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}

function saveconfiguration(basename, extension: string): boolean;
function loadconfiguration(basename, extension: string): boolean;

implementation

// set configuration directories
procedure setconfdir(basename: string; mkdirs: boolean);
begin
  {$IFDEF GO32V2}
    confdir := getexedir + 'settings';
  {$ELSE}
    {$IFDEF WINDOWS}
      confdir := getuserdir + '\Appdata\Local\' + basename;
    {$ELSE}
      {$IFDEF UNIX}
        confdir := getuserdir + '/.config/' + basename;
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  if mkdirs then forcedirectories(confdir);
end;

// save configuration
function saveconfiguration(basename, extension: string): boolean;
var
  fn: string;
begin
  result := false;
  setconfdir(basename, true);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    ini.writeinteger(SECTION[0], 'foreground', foregroundcolor);
    ini.writeinteger(SECTION[0], 'background', backgroundcolor);
    ini.writeinteger(SECTION[1], 'histitem', histitem);
    ini.writeinteger(SECTION[1], 'histlast', histlast);
    for b := 0 to 255 do
      ini.writestring(SECTION[1], 'line' + inttostr(b), histbuff[b]);
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

// load configuration
function loadconfiguration(basename, extension: string): boolean;
var
  fn: string;
begin
  setconfdir(basename, false);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    foregroundcolor := ini.readinteger(SECTION[0], 'foregroundcolor', 7);
    backgroundcolor := ini.readinteger(SECTION[0], 'backgroundcolor', 0);
    histitem := ini.readinteger(SECTION[1], 'histitem', 0);
    histlast := ini.readinteger(SECTION[1], 'histlast', 0);
    for b := 0 to 255 do
      histbuff[b] := ini.readstring(SECTION[1], 'line' + inttostr(b), '');
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

end.
