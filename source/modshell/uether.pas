{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uether.pas                                                               | }
{ | Ethernet handler procedures and functions                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit uether;
interface
{$IFDEF GO32V2}
{$ELSE}
{$ENDIF}

function etherread: string;
procedure etherwrite(s: string);
function  etherinit: boolean;
procedure etherclose;

implementation

function etherread: string;
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

function  etherinit: boolean;
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

procedure etherwrite(s: string);
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

procedure etherclose;
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

end.
