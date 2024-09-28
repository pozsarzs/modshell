{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_rst.pas                                                              | }
{ | command 'reset'                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0    p1
  ------------------------
  reset dev?|pro?|con?|prj
}

// COMMAND 'RESET'
function cmd_reset(p1: string): byte;
var
  i: integer;
  pr: byte;
  s: string;
  valid: boolean;
  
  //SHOW VALID 1ST PARAMETERS
  procedure showvalid1stparameters;
  var
    b: byte;
    s: string;
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for b := 0 to 2 do s := s + ' ' + PREFIX[b] + '[0-7]';
    s := s + ' ' + PREFIX[3];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
  end;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // check p1 parameter
  if p1 = PREFIX[3] then
  begin
    proj := 'default';
    exit;
  end;
  s := p1;
  delete(s, length(s), 1);
  for pr := 0 to 2 do
    if PREFIX[pr]  = s then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    showvalid1stparameters;
    exit;
  end;
  // PRIMARY MISSION
  if length(p1) >= 4 then
  begin
    i := strtointdef(p1[4], -1);
    if (i >= 0) and (i < 8)
    then
      case pr of
        0: dev[i].valid := false;
        1: prot[i].valid := false;
        2: conn[i].valid := false;
      end
    else
      case pr of
        {$IFNDEF X}
          0: writeln(ERR01); // Device number must be 0-7!
          1: writeln(ERR02); // Protocol number must be 0-7!
          2: writeln(ERR03); // Connection number must be 0-7!
        {$ELSE}
          0: Form1.Memo1.Lines.Add(ERR01);
          1: Form1.Memo1.Lines.Add(ERR02);
          2: Form1.Memo1.Lines.Add(ERR03);
        {$ENDIF}
      end;
  end else
  begin
    showvalid1stparameters;
    result := 1;
  end;
end;
