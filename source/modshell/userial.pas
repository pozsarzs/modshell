{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | userial.pas                                                              | }
{ | Serial port handler procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit userial;
interface

function serialinit: boolean;
function serialread: string;
function serialwrite: boolean;

implementation

function serialinit: boolean;
begin
  {$IFDEF GO32V2}
  {$ELSE}
    {$IFDEF WINDOWS}
    {$ELSE}
      {$IFDEF UNIX}
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function serialread: string;
begin
  {$IFDEF GO32V2}
  {$ELSE}
    {$IFDEF WINDOWS}
    {$ELSE}
      {$IFDEF UNIX}
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function serialwrite: boolean;
begin
  {$IFDEF GO32V2}
  {$ELSE}
    {$IFDEF WINDOWS}
    {$ELSE}
      {$IFDEF UNIX}
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

end.
