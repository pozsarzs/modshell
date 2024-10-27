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
var
  i: integer;
begin
  for i := 0 to ARRBUFFSIZE - 1 do
    if arrays[i].areadonly = true then
    begin
      arrays[i].aname := '';
      setlength(arrays[i].aitems, 0);
      arrays[i].amonitored := false;
    end;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS NUMBER
function intisitconstantarray(s: string): integer;
var
  i: integer;
begin
  result := 0;  
  if (s[1] = #36) then
  begin
    s := stringreplace(removearrayindex(s), #36 , '', [rfReplaceAll]);
    for i := 0 to ARRBUFFSIZE - 1 do
      if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := i;
  end;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS TRUE
function boolisitconstantarray(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) then
  begin
    s := stringreplace(removearrayindex(s), #36 , '', [rfReplaceAll]);
    for i := 0 to ARRBUFFSIZE - 1 do
      if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := true;
  end;
end;

// IF IT IS A CONSTANT ARRAY, RETURNS ITS VALUE
function isitconstantarray(s: string): string;
var
  i, idx: integer;
begin
  result := '';
  if (s[1] = #36) then
  begin
    idx := arrayindex(s);
    s := stringreplace(removearrayindex(s), #36 , '', [rfReplaceAll]);
    for i := 0 to ARRBUFFSIZE - 1 do
      if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := stringreplace(arrays[i].aitems[idx], #92 + #32 , #32, [rfReplaceAll]);
  end;
end;

// IF IT IS A CONSTANT ARRAY, IT RETURNS THEIRS ELEMENT NUMBER
function intisitconstantarrayelement(s: string): integer;
var
  i, idx: integer;
begin
  result := 0;
  if (s[1] = #36) then
  begin
    idx := arrayindex(s);
    s := stringreplace(removearrayindex(s), #36 , '', [rfReplaceAll]);
    for i := 0 to ARRBUFFSIZE - 1 do
      if (arrays[i].aname = lowercase(s)) and arrays[i].areadonly
      then result := idx;
  end;
end;

// COMMAND 'CARR'
function cmd_carr(p1, p2: string): byte;
begin
  result := 0;
end;
