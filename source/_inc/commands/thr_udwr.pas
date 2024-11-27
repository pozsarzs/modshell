{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_udwr.pas                                                             | }
{ | command 'udpwrite'                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0       p1   p2
  -----------------------
  udpwrite dev? "MESSAGE"
  udpwrite dev? $MESSAGE
}

// COMMAND 'UDPWRITE'
function TLThread.thr_udpwrite(p1, p2: string): byte;
var
  b: byte;
  i1: integer; // parameters other type
  s: string;
  s1, s2: string; // parameters in other type
  valid: boolean = false;

{$I sendmesg.pas}

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0) then
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
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[0] + '[0-7]';
    sendmessage(s, true);
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
  // CHECK P2 PARAMETER: IS IT A MESSAGE?
  s2 := isitmessage(p2);
  if length(s2) = 0 then
  begin
    // CHECK P2 PARAMETER
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    if boolisitconstantarray(p2) then s2 := isitconstantarray(p2);
    if boolisitvariablearray(p2) then s2 := isitvariablearray(p2);
    if length(s2) = 0 then
    begin
    // No such variable!
      sendmessage(MSG19, true);
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if udp_open(ipaddress, inttostr(port)) then
    begin
      if udp_canwrite then
      begin
        udp_sendstring(s2);
        case uconfig.echo of
          1: sendmessage(s2, true);
          2: begin
               for b := 1 to length(s2) do      
                 s := s + addsomezero(2, deztohex(inttostr(ord(s2[b])))) + ' ';
               sendmessage(s, true)
             end;
        end;
        if (uconfig.echo = 1) and (b = 13) then sendmessage('', true);
      end else
      begin
        // Cannot write data to serial port!
        sendmessage(ERR27, true);
        result := 1;
      end;
      udp_close;
    end else
    begin
      // Cannot initialize network device!
      sendmessage(ERR58 + dev[i1].device, true);
      result := 1;
    end;
end;