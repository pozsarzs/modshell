{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_varr.pas                                                             | }
{ | command 'varr'                                                           | }
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
  varr
  varr NAME
  varr NAME SIZE
}

// CLEAR ALL VARIABLE ARRAYS
procedure clearallvariablearrays;
begin
end;

// IF IT IS A VARIABLE ARRAY, IT RETURNS THEIRS NUMBER
function intisitvariablearray(s: string): integer;
begin
  result := 0;
end;

// IF IT IS A VARIABLE ARRAY, IT RETURNS TRUE
function boolisitvariablearray(s: string): boolean;
begin
  result := false;
end;

// IF IT IS A VARIABLE ARRAY, RETURNS ITS VALUE
function isitvariablearray(s: string): string;
begin
  result := '';
end;

// COMMAND 'varr'
function cmd_varr(p1, p2: string): byte;
begin
  result := 0;
end;
