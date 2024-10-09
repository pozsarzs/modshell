{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | uconfig.pas                                                              | }
{ | configuration file handler                                               | }
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
  colors: array[0..4] of integer;
  formpositions: array[0..3, 0..3] of integer;
  guicolors: array[0..1] of integer;
  histbuff: array[0..255] of string;
  histitem: integer;
  histlast: integer;
  echo: byte;
const
  SECTION: array[0..4] of string = ('cmdline-colors',
                                    'gui-colors',
                                    'connection',
                                    'cmdline-history',
                                    'positions');
  FORMPROP: array[0..3] of string = ('top',
                                     'left',
                                     'height',
                                     'width');
{$IFDEF UNIX}
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}

function loadconfiguration(basename, extension: string): boolean;
function saveconfiguration(basename, extension: string): boolean;

implementation

// SET CONFIGURATION DIRECTORIES
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

// SAVE CONFIGURATION
function saveconfiguration(basename, extension: string): boolean;
var
  b: byte;
  fn: string;
  s: string;
begin
  result := false;
  setconfdir(basename, true);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    ini.writeinteger(SECTION[0], 'foreground', colors[0]);
    ini.writeinteger(SECTION[0], 'background', colors[1]);
    ini.writeinteger(SECTION[0], 'receivedtext', colors[2]);
    ini.writeinteger(SECTION[0], 'transmittedtext', colors[3]);
    ini.writeinteger(SECTION[0], 'variable_monitor', colors[4]);
    ini.writeinteger(SECTION[1], 'foreground', guicolors[0]);
    ini.writeinteger(SECTION[1], 'background', guicolors[1]);
    ini.writeinteger(SECTION[2], 'echo', echo);
    s := 'form1_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[4], s + FORMPROP[b], formpositions[0, b]);
    s := 'form2_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[4], s + FORMPROP[b], formpositions[1, b]);
    s := 'form3_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[4], s + FORMPROP[b], formpositions[2, b]);
    s := 'form4_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[4], s + FORMPROP[b], formpositions[3, b]);
    for b := 0 to 255 do
      ini.writestring(SECTION[3], 'line' + inttostr(b), histbuff[b]);
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

// LOAD CONFIGURATION
function loadconfiguration(basename, extension: string): boolean;
var
  fn: string;
  s: string;
begin
  setconfdir(basename, false);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    colors[0] := ini.readinteger(SECTION[0], 'foreground', 7);
    colors[1] := ini.readinteger(SECTION[0], 'background', 0);
    colors[2] := ini.readinteger(SECTION[0], 'receivedtext', 10);
    colors[3] := ini.readinteger(SECTION[0], 'transmittedtext', 12);
    colors[4] := ini.readinteger(SECTION[0], 'variable_monitor', 14);
    guicolors[0] := ini.readinteger(SECTION[1], 'foreground', 16776960);
    guicolors[1] := ini.readinteger(SECTION[1], 'background', 8388608);
    echo := ini.readinteger(SECTION[2], 'echo', 0);
    s := 'form1_';
    for b:= 0 to 3 do
      formpositions[0, b] := ini.readinteger(SECTION[4], s + FORMPROP[b], 0);
    s := 'form2_';
    for b:= 0 to 3 do
      formpositions[1, b] := ini.readinteger(SECTION[4], s + FORMPROP[b], 0);
    s := 'form3_';
    for b:= 0 to 3 do
      formpositions[2, b] := ini.readinteger(SECTION[4], s + FORMPROP[b], 0);
    s := 'form4_';
    for b:= 0 to 3 do
      formpositions[3, b] := ini.readinteger(SECTION[4], s + FORMPROP[b], 0);
    histitem := ini.readinteger(SECTION[3], 'histitem', 0);
    histlast := ini.readinteger(SECTION[3], 'histlast', 0);
    for b := 0 to 255 do
      histbuff[b] := ini.readstring(SECTION[3], 'line' + inttostr(b), '');
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

end.
