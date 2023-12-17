{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | umbascii.pas                                                             | }
{ | Modbus/ASCII protocol procedures and functions                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}
unit umbascii;
interface
uses
  userial;

procedure readdinp;
procedure readireg;
procedure writecoil;
procedure writehreg;

implementation

function createlrc: string;
begin
end;

function chkecklrc: boolean;
begin
end;

procedure readdinp;
begin
end;

procedure readireg;
begin
end;

procedure writecoil;
begin
end;

procedure writehreg;
begin
end;

end.
