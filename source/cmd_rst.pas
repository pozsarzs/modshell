{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
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
  --------------------
  reset dev?|pro?|con?
}

// command 'reset'
procedure cmd_reset(p1: string);
var
  pr: byte;
  i: integer;
  valid: boolean;
  s: string;
begin
  // check length of parameters
  if (length(p1) = 0) then
  begin
    writeln(ERR11); // Parameter required!
    exit;
  end;
  // check p1 parameter
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
    write('1st ' + MSG05); // What is the 1st parameter?
    for i := 0 to 2 do write(' ' + PREFIX[i]+'[0-7]');
    writeln;
    exit;
  end;
  // primary mission
  if length(p1) >= 4 then
  begin
    i := strtointdef(p1[4],-1);
    if (i >= 0) and (i < 8)
    then
      case pr of
        0: dev[i].valid := false;
        1: prot[i].valid := false;
        2: conn[i].valid := false;
      end
    else
      case pr of
        0: writeln(ERR01); // Device number must be 0-7!
        1: writeln(ERR09); // Protocol number must be 0-7!
        2: writeln(ERR10); // Connection number must be 0-7!
      end;
  end;
end;
