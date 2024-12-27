{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_str.pas                                                              | }
{ | string handler commands                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1      p2        p3
  -----------------------------------
  chr     $TARGET [$]VALUE
  concat  $TARGET [$]VALUE1 [$]VALUE2
  length  $TARGET [$]VALUE
  lowcase $TARGET [$]VALUE
  mklrc   $TARGET [$]STRING
  mkcrc   $TARGET [$]STRING
  ord     $TARGET [$]VALUE
  strdel  $TARGET [$]PLACE  [$]COUNT
  strfind $TARGET [$]VALUE
  strins  $TARGET [$]PLACE  [$]VALUE
  stritem $TARGET [$]VALUE1 [$]VALUE2
  strrepl $TARGET [$]OLD    [$]NEW
  upcase  $TARGET [$]VALUE
}

// IF IT IS A MESSAGE, IT RETURNS ITS VALUE
function isitmessage(s: string): string;
begin
  result := '';
  if (s[1] = #34) and (s[length(s)] = #34) then
  begin
    s := stringreplace(s, #34 , '', [rfReplaceAll]);
    s := stringreplace(s, #92 + #32 , #32, [rfReplaceAll]);
    {$IFNDEF X} s := stringreplace(s, '^[' , #27 + '[', [rfReplaceAll]); {$ENDIF}
    result := s;
  end;
end;

// STRING HANDLER COMMANDS
function cmd_string(op: byte; p1, p2, p3: string): byte;
var
  s2, s3: string; // parameters in other type

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR05);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR05);
    {$ENDIF}
    result := 1;
    exit;
  end;
  if op = 63 then
    if (length(p3) = 0) then
    begin
      // Parameter(s) required!
      {$IFNDEF X}
        if verbosity(2) then writeln(ERR05);
      {$ELSE}
        Form1.Memo1.Lines.Add(ERR05);
      {$ENDIF}
      result := 1;
      exit;
    end;
  // CHECK P1 PARAMETER
  if (not boolisitvariable(p1)) and
     (not boolisitvariablearray(p1)) then
  begin
    // No such variable!
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR19 + p1);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR19 + p1);
    {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if boolisitconstant(p2) then s2 := isitconstant(p2);
  if boolisitvariable(p2) then s2 := isitvariable(p2);
  if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
  if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
  if length(s2) = 0 then s2 := p2;
  // CHECK P3 PARAMETER
  if (op = 63) or (op = 83) or (op = 84) or (op = 86) or (op = 87) then
  begin
    if boolisitconstant(p3) then s3 := isitconstant(p3);
    if boolisitvariable(p3) then s3 := isitvariable(p3);
    if boolisitconstantarray(p3) then s3 := isitconstantarray(p3);
    if boolisitvariablearray(p3) then s3 := isitvariablearray(p3);
    if length(s3) = 0 then s3 := p3;
  end;
  // PRIMARY MISSION
  try
    if boolisitvariable(p1)
      then
        case op of
          60: vars[intisitvariable(p1)].vvalue := uppercase(s2);
          61: vars[intisitvariable(p1)].vvalue := inttostr(length(s2));
          62: vars[intisitvariable(p1)].vvalue := lowercase(s2);
          63: vars[intisitvariable(p1)].vvalue := s2[strtointdef(s3, 0)];
          64: vars[intisitvariable(p1)].vvalue := chr(strtointdef(s2, 0));
          65: vars[intisitvariable(p1)].vvalue := inttostr(ord(s2[1]));
          76: vars[intisitvariable(p1)].vvalue := inttostr(lrc(s2));
          77: vars[intisitvariable(p1)].vvalue := inttostr(crc16(s2));
          83: vars[intisitvariable(p1)].vvalue := concat(s2, s3);
          84: delete(vars[intisitvariable(p1)].vvalue, strtointdef(s2, 0), strtointdef(s3, 0));
          85: vars[intisitvariable(p1)].vvalue := inttostr(pos(s2, vars[intisitvariable(p1)].vvalue));
          86: insert(s3, vars[intisitvariable(p1)].vvalue, strtointdef(s2, 0));
          87: vars[intisitvariable(p1)].vvalue := stringreplace(vars[intisitvariable(p1)].vvalue, s2, s3, [rfReplaceAll]);
        else          
        end
      else
        case op of
          60: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := uppercase(s2);
          61: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(length(s2));
          62: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := lowercase(s2);
          63: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := s2[strtointdef(s3, 0)];
          64: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := chr(strtointdef(s2, 0));
          65: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(ord(s2[1]));
          76: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(lrc(s2));
          77: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(crc16(s2));
          83: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := concat(s2, s3);
          84: delete(arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)], strtointdef(s2, 0), strtointdef(s3, 0));
          85: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := inttostr(pos(s2, arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)]));
          86: insert(s3, arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)], strtointdef(s2, 0));
          87: arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)] := stringreplace(arrays[intisitvariablearray(p1)].aitems[intisitvariablearrayelement(p1)], s2, s3, [rfReplaceAll]);
        else          
        end;
  except
    // Operating error
    {$IFNDEF X}
      if verbosity(2) then writeln(ERR48);
    {$ELSE}
      Form1.Memo1.Lines.Add(ERR48);
    {$ENDIF}
    result := 1;
  end;
end;
