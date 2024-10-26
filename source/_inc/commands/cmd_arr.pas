{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_arr.pas                                                              | }
{ | array handler commands                                                   | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0       p1     p2      p3
  --------------------------------
  arrclear ARRAY
  arrcopy  TARGET SOURCE  [$]COUNT
  arrfill  ARRAY  [$]CHAR
  arrsize  ARRAY  [$]SIZE
}

// RETURN WITH ARRAY INDEX
function arrayindex(s: string): byte;
var
  b: byte;
  idx: string = '';
begin
  for b := 0 to length(s) do
    if s[b] = '[' then break;
  for b := b + 1 to length(s) do
    if s[b] <> ']' then  idx := idx + s[b] else break;
  result := strtointdef(idx, 0);
end;

// REMOVE ARRAY INDEX WITH SQUARE BRACKETS
function removearrayindex(s: string): string;
var
  b: byte;
begin
  result := '';
  for b := 0 to length(s) do
   if s[b] <> '[' then result := result + s[b] else break;
end;

// ARRAY HANDLER COMMANDS
function cmd_arr(op: byte; p1, p2, p3: string): byte;
begin


  // PRIMARY MISSION
  try
{    case op of
      107: ;
      108: ;
      109: ;
      110: ;
    end;}
  except
    // Operating error
    {$IFNDEF X} writeln(ERR48); {$ELSE} Form1.Memo1.Lines.Add(ERR48); {$ENDIF}
    result := 1;
  end;
end;
