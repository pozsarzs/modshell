{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_let.pas                                                              | }
{ | command 'let'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1                  p2      p3
  -------------------------------------
  let dinp|coil|ireg|hreg ADDRESS VALUE
}

// command 'let'
procedure cmd_let(p1, p2, p3: string);
var
  rt, x, y: byte;
  valid: boolean = false;
begin
  // check length of parameters
  if (length(p1) = 0) or (length(p2) = 0) or (length(p3) = 0) then
  begin
    writeln(ERR11); // Parameters required!
    exit;
  end;
  // check p1 parameter
  for rt := 0 to 3 do
    if REG_TYPE[rt] = p1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    for x := 0 to 3 do write(' ' + REG_TYPE[x]);
    writeln;
    exit;
  end;
  // check p2 parameter
  if (strtointdef(p2, -1) < 1 ) or (strtointdef(p2, -1) > 9999) then
  begin
    writeln('2nd ' + MSG05 + ' 1-9999'); // What 2nd the 1st parameter?
    exit;
  end;
  // check p3 parameter
  if rt > 1 then
    if (strtointdef(p3, -1) < 0 ) or (strtointdef(p3, -1) > 65535) then
    begin
      writeln('3rd ' + MSG05 + ' 0-65535'); // What is the 3rd parameter?
      exit;
    end;
  // check p3 parameter
  valid := false;
  if rt < 2 then
  begin
    for x := 0 to 1 do
      for y := 0 to 2 do
        if BOOLVALUES[x, y] = uppercase(p3) then
        begin
          valid := true;
          break;
        end;
    if not valid then
    begin
      write('3rd ' + MSG05); // What is the 3rd parameter?
      for x := 0 to 1 do
        for y := 0 to 2 do
          write(' ' + BOOLVALUES[x, y]);
      writeln;
      exit;
    end;
  end;
  // convert L/H -> 0/1
  for x := 0 to 1 do
    if uppercase(p3) = BOOLVALUES[x, 1] then p3 := BOOLVALUES[x, 0];
  // primary mission
  case rt of
    0: dinp[strtoint(p2)] := strtobooldef(p3, false);
    1: coil[strtoint(p2)] := strtobooldef(p3, false);
    2: ireg[strtoint(p2)] := strtointdef(p3, 0);
    3: hreg[strtoint(p2)] := strtointdef(p3, 0);
  end;
end;
