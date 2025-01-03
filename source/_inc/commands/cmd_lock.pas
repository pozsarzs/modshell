{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_lock.pas                                                             | }
{ | lock file handler commands                                               | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0         p1
  --------------------
  chkdevlock [$]DEVICE
  rmdevlock  [$]DEVICE
  
     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'chkdevlock'
function cmd_chkdevlock(p1: string): byte;
begin
  result := booltoint(not checklockfile(p1, false));
end;

// COMMAND 'rmdevlock'
function cmd_rmdevlock(p1: string): byte;
begin
  result := booltoint(not removelockfile(p1, false));
end;

// lock file handler functions
function cmd_devlock(op: byte; p1: string): byte;
var
  s1: string; // parameters in other type
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if length(p1) = 0  then
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
  if length(p1) > 0 then
  begin
    if boolisitconstant(p1) then s1 := isitconstant(p1);
    if boolisitvariable(p1) then s1 := isitvariable(p1);
    // No such array cell!
    if boolisitconstantarray(p1) then
      if boolvalidconstantarraycell(p1)
        then s1 := isitconstantarray(p1)
        else result := 1;
    if boolisitvariablearray(p1) then
      if boolvalidvariablearraycell(p1)
        then s1 := isitvariablearray(p1)
        else result := 1;
    if result = 1 then exit;
    if length(s1) = 0 then s1 := p1;
  end;
  // PRIMARY MISSION
  case op of
     103: result := cmd_chkdevlock(s1);
     104: result := cmd_rmdevlock(s1);
  end;
end;
