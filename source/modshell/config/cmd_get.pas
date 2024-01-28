{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_get.pas                                                              | }
{ | command 'get'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1
  ----------------------
  get dev?|pro?|con?|prj
}

// COMMAND 'GET'
function cmd_get(p1: string): byte;
var
  pr: byte;
  i: integer;
  s1: string;      // parameter in other type
  valid: boolean;

  // SHOW SETTINGS
  procedure showsettings(pr, n: byte);
  begin
    case pr of
      0: if dev[n].valid
         then
           with dev[n] do
             if devtype = 0 then
             begin
               writeln(PREFIX[pr], n, ':');
               writeln(MSG07 + device);
               writeln(MSG08, port);
             end else
             begin
               writeln(PREFIX[pr], n, ':');
               writeln(MSG07 + device);
               writeln(MSG09, DEV_SPEED[speed]);
               writeln(MSG10, databit, upcase(DEV_PARITY[parity]), stopbit);
             end
         else
           writeln(PREFIX[pr], n, MSG06);
      1: if prot[n].valid
         then
           with prot[n] do
             if prottype < 2 then
             begin
               writeln(PREFIX[pr], n, ':');
               writeln(MSG11 + PROT_TYPE[prottype]);
               writeln(MSG13, uid);
             end else
             begin
               writeln(PREFIX[pr], n, ':');
               writeln(MSG11 + PROT_TYPE[prottype]);
               writeln(MSG12, ipaddress);
             end
         else
           writeln(PREFIX[pr], n, MSG06);
      2: if conn[n].valid
         then
           with conn[n] do
           begin
             writeln(PREFIX[pr], n, ':');
             writeln(MSG07, PREFIX[0], dev);
             writeln(MSG11, PREFIX[1], prot);
           end
         else
           writeln(PREFIX[pr], n, MSG06);
    end;
  end;

  // SHOW VALID 1ST PARAMETERS
  procedure showvalid1stparameters;
  var
    b: byte;
 
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    for b := 0 to 2 do write(' ' + PREFIX[b] + '[0-7]');
    writeln(' ' + PREFIX[3]);
  end;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    writeln(ERR05); // Parameter required!
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETERS
  if p1 = PREFIX[3] then
  begin
    writeln(proj);
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  for pr := 0 to 2 do
    if PREFIX[pr] = s1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    showvalid1stparameters;
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  if length(p1) >= 4 then
  begin
    i := strtointdef(p1[4], -1);
    if (i >= 0) and (i < 8)
    then
      showsettings(pr,i)
    else
      case pr of
        0: writeln(ERR01); // Device number must be 0-7!
        1: writeln(ERR02); // Protocol number must be 0-7!
        2: writeln(ERR03); // Connection number must be 0-7!
      end;
  end else
  begin
    showvalid1stparameters;
    result := 1;
  end;
end;
