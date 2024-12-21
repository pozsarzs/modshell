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
 sysutils,
 inifiles;
var
  ini: TINIFile;
  confdir: string;
  // settings from/to ini file
  colors: array[0..4] of integer;
  echometh: byte = 0;
  inputmeth: byte = 1;
  sendmeth: byte = 4;
  formpositions: array[0..7, 0..3] of integer;
  guicolors: array[0..1] of integer;
  histbuff: array[0..255] of string;
  histitem: integer;
  histlast: integer;
  lastproject: string;
const
  KEY: array[0..14] of string = ('foreground',
                                'background',
                                'receivedtext',
                                'transmittedtext',
                                'variable_monitor',
                                'line',
                                'histitem',
                                'histlast',
                                'inputmeth',
                                'echometh',
                                'sendmeth',
                                'foreground',
                                'background',
                                'lastproject',
                                'form');
  FORMPROP: array[0..3] of string = ('top',
                                     'left',
                                     'height',
                                     'width');
  SECTION: array[0..5] of string = ('cmdline-colors',
                                    'cmdline-history',
                                    'connection',
                                    'gui-colors',
                                    'others',
                                    'positions');
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
  b, bb: byte;
  fn: string;
  s: string;
begin
  result := false;
  setconfdir(basename, true);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    ini.writeinteger(SECTION[0], KEY[0], colors[0]);
    ini.writeinteger(SECTION[0], KEY[1], colors[1]);
    ini.writeinteger(SECTION[0], KEY[2], colors[2]);
    ini.writeinteger(SECTION[0], KEY[3], colors[3]);
    ini.writeinteger(SECTION[0], KEY[4], colors[4]);
    for b := 0 to 255 do
      ini.writestring(SECTION[1], KEY[5] + inttostr(b), histbuff[b]);
    ini.writeinteger(SECTION[1], KEY[6], histitem);
    ini.writeinteger(SECTION[1], KEY[7], histlast);
    ini.writeinteger(SECTION[2], KEY[8], inputmeth);
    ini.writeinteger(SECTION[2], KEY[9], echometh);
    ini.writeinteger(SECTION[2], KEY[10], sendmeth);
    ini.writeinteger(SECTION[3], KEY[11], guicolors[0]);
    ini.writeinteger(SECTION[3], KEY[12], guicolors[1]);
    ini.writestring(SECTION[4], KEY[13], lastproject);
    for bb := 0 to 7 do
    begin
      if bb < 3 then
      begin
        s := KEY[14] + inttostr(bb + 1) + '_';
        for b:= 0 to 3 do
          ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[bb, b]);
      end;
      if bb = 3 then
      begin
        s := KEY[14] + '301_';
        for b:= 0 to 3 do
          ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[bb, b]);
      end;
      if bb > 3 then
      begin
        s := KEY[14] + inttostr(bb) + '_';
        for b:= 0 to 3 do
          ini.writeinteger(SECTION[5], s + FORMPROP[b], formpositions[bb, b]);
      end;
    end;
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

// LOAD CONFIGURATION
function loadconfiguration(basename, extension: string): boolean;
var
  b, bb: byte;
  fn: string;
  s: string;
begin
  setconfdir(basename, false);
  fn := SLASH + basename + extension;
  ini := tinifile.create(confdir + fn);
  try
    colors[0] := ini.readinteger(SECTION[0], KEY[0], 7);
    colors[1] := ini.readinteger(SECTION[0], KEY[1], 0);
    colors[2] := ini.readinteger(SECTION[0], KEY[2], 10);
    colors[3] := ini.readinteger(SECTION[0], KEY[3], 12);
    colors[4] := ini.readinteger(SECTION[0], KEY[4], 14);
    for b := 0 to 255 do
      histbuff[b] := ini.readstring(SECTION[1], KEY[5] + inttostr(b), '');
    histitem := ini.readinteger(SECTION[1], KEY[6], 0);
    histlast := ini.readinteger(SECTION[1], KEY[7], 0);
    inputmeth := ini.readinteger(SECTION[2], KEY[8], 1);
    echometh := ini.readinteger(SECTION[2], KEY[9], 0);
    sendmeth := ini.readinteger(SECTION[2], KEY[10], 4);
    if sendmeth < 4 then sendmeth := 4;
    guicolors[0] := ini.readinteger(SECTION[3], KEY[11], 16776960);
    guicolors[1] := ini.readinteger(SECTION[3], KEY[12], 8388608);
    lastproject := ini.readstring(SECTION[4], KEY[13], 'default');
    for bb := 0 to 7 do
    begin
      if bb < 3 then
      begin
        s := KEY[14] + inttostr(bb + 1) + '_';
        for b:= 0 to 3 do
          formpositions[bb, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
      end;
      if bb = 3 then
      begin
        s := KEY[14] + '301_';
        for b:= 0 to 3 do
          formpositions[bb, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
      end;
      if bb > 3 then
      begin
        s := KEY[14] + inttostr(bb) + '_';
        for b:= 0 to 3 do
          formpositions[bb, b] := ini.readinteger(SECTION[5], s + FORMPROP[b], 0);
      end;
    end;
  except
    result := false;
  end;
  result := true;
  ini.free;
end;

end.
