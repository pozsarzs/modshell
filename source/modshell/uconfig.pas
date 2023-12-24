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
 sysutils;
var
  b: byte;
  fn: string;
  confdir: array[0..2] of string;

{$IFDEF UNIX}  
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}

function saveconfiguration(basename, extension: string): boolean;
function loadconfiguration(basename, extension: string): boolean;

implementation

// set configuration directories
procedure setconfdir(basename, extension: string);
begin
  fn := SLASH + basename + extension;
  confdir[0] := getexedir + 'settings'; // DOS, Windows, Unix-like
  confdir[1] := getuserdir + '/.config/' + basename; // Unix-like only
  confdir[2] := getuserdir + '\Appdata\Local\' + basename; // Windows only
end;

// save configuration
function saveconfiguration(basename, extension: string): boolean;
begin
  result := false;
  setconfdir(basename, extension);
  for b := 0 to 2 do
    if fileexists(confdir[b] + fn) then
    begin
      {...}
      result := true;
    end;
end;

// load configuration
function loadconfiguration(basename, extension: string): boolean;
begin
  result := false;
  setconfdir(basename, extension);
  for b := 0 to 2 do
    if fileexists(confdir[b] + fn) then
    begin
      {...}
      result := true;
    end;
end;

end.
