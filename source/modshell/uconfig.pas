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
const
  SECTION: array[0..0] of string = ('fullscreen-console');

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
    ini.writeinteger(SECTION[0], 'foregroundcolor', foregroundcolor);
    ini.writeinteger(SECTION[0], 'backgroundcolor', backgroundcolor);
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
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

end.
