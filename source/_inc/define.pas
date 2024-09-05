{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | define.pas                                                               | }
{ | defined data                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$IFNDEF GO32V2}
  {$R *.res}
{$ENDIF}

{$DEFINE BASENAME := lowercase(PRGNAME)}
{$DEFINE COMMENT := #35}

// Uncomment following line, if you want to build binary file
// for deb, rpm, tgz package.
// {$DEFINE INSTPKGMAN}

{$IFDEF GO32V2}
  {$DEFINE SHEBANG := '@modshell -r %0' + #13 + #10 + '@goto :eof'}
  {$DEFINE LABELEOF := ':eof'}
{$ELSE}
  {$IFDEF BSD}
    {$DEFINE SHEBANG := '#!/usr/local/bin/modshell -r'}
  {$ELSE}
    {$IFDEF LINUX}
      {$IFDEF INSTPKGMAN}
        {$DEFINE SHEBANG := '#!/usr/bin/modshell -r'}
      {$ELSE}
        {$DEFINE SHEBANG := '#!/usr/local/bin/modshell -r'}
      {$ENDIF}
    {$ELSE}
      {$IFDEF WINDOWS}
        {$DEFINE SHEBANG := '@modshell -r %0' + #13 + #10 + '@goto :eof'}
        {$DEFINE LABELEOF := ':eof'}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF UNIX}
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}
