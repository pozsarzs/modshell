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
  ini: TINIFile;
  b: byte;
  confdir: string;
  // settings from/to ini file
  colors: array[0..4] of integer;
  echometh: byte = 0;
  inputmeth: byte = 1;
  sendmeth: byte = 4;
  formpositions: array[0..5, 0..3] of integer;
  guicolors: array[0..1] of integer;
  histbuff: array[0..255] of string;
  histitem: integer;
  histlast: integer;
  lastproject: string;
const
  SECTION: array[0..5] of string = ('cmdline-colors',
                                    'cmdline-history',
                                    'connection',
                                    'gui-colors',
                                    'others',
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
    for b := 0 to 255 do
      ini.writestring(SECTION[1], 'line' + inttostr(b), histbuff[b]);
    ini.writeinteger(SECTION[1], 'histitem', histitem);
    ini.writeinteger(SECTION[1], 'histlast', histlast);
    ini.writeinteger(SECTION[2], 'inputmeth', inputmeth);
    ini.writeinteger(SECTION[2], 'echometh', echometh);
    ini.writeinteger(SECTION[2], 'sendmeth', sendmeth);
    ini.writeinteger(SECTION[3], 'foreground', guicolors[0]);
    ini.writeinteger(SECTION[3], 'background', guicolors[1]);
    ini.writestring(SECTION[4], 'lastproject', lastproject);
    s := 'form1_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[0, b]);
    s := 'form2_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[1, b]);
    s := 'form3_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[2, b]);
    s := 'form4_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[4, b]);
    s := 'form5_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[5, b]);
    s := 'form301_';
    for b:= 0 to 3 do
      ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[3, b]);
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
    for b := 0 to 255 do
      histbuff[b] := ini.readstring(SECTION[1], 'line' + inttostr(b), '');
    histitem := ini.readinteger(SECTION[1], 'histitem', 0);
    histlast := ini.readinteger(SECTION[1], 'histlast', 0);
    inputmeth := ini.readinteger(SECTION[2], 'inputmeth', 1);
    echometh := ini.readinteger(SECTION[2], 'echometh', 0);
    sendmeth := ini.readinteger(SECTION[2], 'sendmeth', 4);
    if sendmeth < 4 then sendmeth := 4;
    guicolors[0] := ini.readinteger(SECTION[3], 'foreground', 16776960);
    guicolors[1] := ini.readinteger(SECTION[3], 'background', 8388608);
    lastproject := ini.readstring(SECTION[4], 'lastproject', 'default');
    s := 'form1_';
    for b:= 0 to 3 do
      formpositions[0, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
    s := 'form2_';
    for b:= 0 to 3 do
      formpositions[1, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
    s := 'form3_';
    for b:= 0 to 3 do
      formpositions[2, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
    s := 'form4_';
    for b:= 0 to 3 do
      formpositions[4, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
    s := 'form5_';
    for b:= 0 to 3 do
      formpositions[5, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
    s := 'form301_';
    for b:= 0 to 3 do
      formpositions[3, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

end.
