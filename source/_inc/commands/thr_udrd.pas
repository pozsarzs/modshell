{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_udrd.pas                                                             | }
{ | command 'udpread'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1   p2
  -----------------------
  udpread dev? [$TARGET]
}

// COMMAND 'UDPREAD'
function TLThread.thr_udpread(p1, p2: string; no_timeout_error: boolean): byte;
var
  b: byte;
  i1: integer; // parameters other type
  s: string = '';
  ss: string;
  s1: string; // parameters in other type
  valid: boolean = false;
  wait: integer = 0;

{$I sendmesg.pas}

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    sendmessage(ERR05, true);
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := p1;
  delete(s1, length(s1), 1);
  if PREFIX[0]  = s1 then valid := true;
  if valid then
    if length(p1) >= 4 then
    begin
       i1 := strtointdef(p1[4],-1);
       if (i1 >= 0) and (i1 < 8) then valid := true;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    ss := NUM1 + MSG05;
    ss := ss + ' ' + PREFIX[0] + '[0-7]';
    sendmessage(ss, true);
    result := 1;
    exit;
  end;
  if not dev[i1].valid then
  begin
    sendmessage(PREFIX[0] + inttostr(i1) + MSG06, true);
    result := 1;
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    sendmessage(MSG24, true);
    result := 1;
    exit;
  end;
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
    if (not boolisitvariable(p2)) and
       (not boolisitvariablearray(p2)) then
    begin
      // No such variable!
      sendmessage(ERR19 + p2, true);
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if udp_open(ipaddress, inttostr(port)) then
    begin
      repeat
        sleep(10);
        if udp_canread then
        begin
          wait := 0;
          b := udp_recvbyte;
          case uconfig.echo of
            1: sendmessage(char(b), false);
            2: sendmessage(addsomezero(2, deztohex(inttostr(b))) + ' ', false);
          end;
          s := s + char(b);
          if (uconfig.echo = 1) and (b = 13) then
          begin
            sendmessage('', true);
          end;
        end else
          if not no_timeout_error then
            if wait < 6000 then inc(wait);
      until (length(s) = 255) or (wait = timeout * 100);
      udp_close;
      if (uconfig.echo > 0) then sendmessage('', true);
      if length(p2) = 0 then sendmessage(s, true);
      if length(p2) > 0 then
        if boolisitvariable(p2)
          then vars[intisitvariable(p2)].vvalue := s
          else arrays[intisitvariablearray(p2)].aitems[intisitvariablearrayelement(p1)] := s;
    end else
    begin
      // Cannot initialize network device!
      sendmessage(ERR58 + dev[i1].device, true);
      result := 1;
    end;
end;