{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command line Modbus utility                               | }
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
  ------------------
  get dev?|pro?|con?
}

// command 'get'
procedure cmd_get(p1: string);
var
  pr: byte;
  i: integer;
  s1: string;
  valid: boolean;

  // show settings
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
             writeln(MSG07, PREFIX[0],dev);
             writeln(MSG11, PREFIX[1],prot);
           end
         else
           writeln(PREFIX[pr], n, MSG06); end;
  end;

begin
  // check length of parameters
  if (length(p1) = 0) then
  begin
    writeln(ERR11); // Parameter required!
    exit;
  end;
  // check p1 parameters
  s1 := p1;
  delete(s1, length(s1), 1);
  for pr := 0 to 2 do
    if PREFIX[pr]  = s1 then
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
      showsettings(pr,i)
    else
      case pr of
        0: writeln(ERR01); // Device number must be 0-7!
        1: writeln(ERR09); // Protocol number must be 0-7!
        2: writeln(ERR10); // Connection number must be 0-7!
      end;
  end;
end;
