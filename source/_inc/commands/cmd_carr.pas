{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_carr.pas                                                             | }
{ | command 'carr'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1   p2
  ----------------
  carr
  carr NAME
  carr NAME SIZE
}

// CLEAR ALL CONSTANT ARRAYS
procedure clearallconstantarrays;
begin
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS NUMBER
function intisitconstantarray(s: string): integer;
begin
  result := 0;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS TRUE
function boolisitconstantarray(s: string): boolean;
begin
  result := false;
end;

// IF IT IS A CONSTANT ARRAY, RETURNS ITS VALUE
function isitconstantarray(s: string): string;
begin
  result := '';
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS ELEMENT NUMBER
function intisitconstantarrayelement(s: string): integer;
begin
  result := 0;
end;

// COMMAND 'CARR'
function cmd_carr(p1, p2: string): byte;
begin
  result := 0;
end;
