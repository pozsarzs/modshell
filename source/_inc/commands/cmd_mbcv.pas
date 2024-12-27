{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mbcv.pas                                                             | }
{ | command 'mbconv'                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0     p1
  --------------
  mbconv $TARGET_REGISTER_TYPE $TARGET_ADDRESS [$]REGISTER_NUMBER
  mbconv $TARGET_NUMBER [$]REGISTER_TYPE [$]ADDRESS
}

{
  direction = 0:  number -> address, type
  p1: var or varr
  p2: var or varr
  p3  const, carr, var, varr or integer ~1-49999

  direction = 1:  address, type -> number
  p1: var vagy varr
  p2: const, carr, var, varr or string coil-hreg
  p3  const, carr, var, varr or integer 0-9998
}

// COMMAND 'MBCONV'
function cmd_mbconv(p1, p2, p3: string): byte;
var
  direction: boolean = false; // 0: n->a,t; 1: a,t->n
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
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




 
end;
