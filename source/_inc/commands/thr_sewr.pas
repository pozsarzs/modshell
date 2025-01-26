{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_sewr.pas                                                             | }
{ | command 'serwrite'                                                       | }
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
  serwrite dev? "MESSAGE"
  serwrite dev? $MESSAGE
}

// COMMAND 'SERWRITE'
function TLThread.thr_serwrite(p1, p2: string): byte;
var
  b: byte;
  i1: integer;
  s: string;
  s1, s2: string;
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
       i1 := strtointdef(p1[4], -1);
       if (i1 >= 0) and (i1 < 8) then valid := true;
    end;
  if not valid then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[0] + SVR;
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
    sendmessage(ERR24, true);
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
    if boolisitconstantarray(p2) then
      if boolvalidconstantarraycell(p2)
        then s2 := isitconstantarray(p2)
        else result := 1;
    if boolisitvariablearray(p2) then
      if boolvalidvariablearraycell(p2)
        then s2 := isitvariablearray(p2)
        else result := 1;
    if result = 1 then
    if length(s2) = 0 then
    begin
      // No such array cell!
      sendmessage(MSG66, true);
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  if checklockfile(dev[i1].device, false) then
  begin
    sendmessage(ERR49, true);
    exit;
  end;
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      if ser_canwrite then
      begin
        // input method
        if uconfig.inputmeth = 2 then
        begin
          s := '';
          b := 1;
          repeat
            try
              s := s + char(strtoint(hextodez(s2[b] + s2[b + 1])));
            finally
              b := b + 2;
            end;
          until b >= length(s2);
          s2 := s;
        end;
        // send method
        case uconfig.sendmeth of
          4: begin
               for b := 1 to length(s2) do
               begin
                 ser_sendbyte(ord(s2[b]));
                 // echo method
                 case uconfig.echometh of
                   1: sendmessage(s2[b], false);
                   2: sendmessage(addsomezero(2, deztohex(inttostr(ord(s2[b])))) + ' ', false);
                 end;
               end;
               sendmessage('', true);
             end;
          5: begin
               ser_sendstring(s2);
               // echo method
               case uconfig.echometh of
                 1: sendmessage(s2, true);
                 2: begin
                      s := '';
                      for b := 1 to length(s2) do
                        s := s + addsomezero(2, deztohex(inttostr(ord(s2[b])))) + ' ';
                      sendmessage(s, true)
                    end;
               end;
             end;
        end;
      end else
      begin
        // Cannot write data to serial port!
        sendmessage(ERR27, true);
        result := 1;
      end;
      ser_close;
    end else
    begin
      // Cannot initialize serial port!
      sendmessage(ERR18 + dev[i1].device, true);
      result := 1;
    end;
end;
