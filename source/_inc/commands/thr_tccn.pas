{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_tccn.pas                                                             | }
{ | command 'tcpcons'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1
  ----------
  tcpcons ?
}

// COMMAND 'TCPCONS'
function TLThread.thr_tcpcons(p1: byte): byte;
var
  fpn, fp: string;
  lf: text;
  srx: string = '';
  stx: string = '';

{$I sendmesg.pas}

begin
  result := 0;
  if not dev[p1].valid then
  begin
    sendmessage(PREFIX[0] + inttostr(p1) + MSG06, true);
    exit;
  end;
  if not (dev[p1].devtype = 0) then
  begin
    sendmessage(ERR25, true);
    result := 1;
    exit;
  end;
  // SET LOG FILE
  fp := vars[13].vvalue;
  ForceDirectories(fp);
  fpn := fp + SLASH + 'console.log';
  assignfile(lf, fpn);
  try
    rewrite(lf);
  except
    sendmessage(MSG50,true);
  end;
  // PRIMARY MISSION
  with dev[p1] do
    repeat
      if tcp_open(ipaddress, inttostr(port))  then
      begin
        if keyprd then
        begin
          keyprd := false;
          if prdkey = #13 then
          begin
            // send a string
            if tcp_canwrite then
            begin
              tcp_sendstring(stx);
              sendmessage('', true);
              try
                writeln(lf, stx);
              except
              end;
              stx := '';
            end else sendmessage(ERR27, true);
          end else
          begin
            sendmessage(prdkey, false);
            stx := stx + prdkey;
          end;
        end;
        // receive a string
        if tcp_canread then
        begin
          srx := tcp_recvpacket;
          sendmessage(srx, true);
          try
            writeln(lf, srx);
          except
          end;
        end;
        tcp_close;
      end else
      begin
        // Cannot initialize socket!
        sendmessage(ERR58, true);
        result := 1;
        prdkey := #27;
      end;
      sleep(100);
    until prdkey = #27;
  sendmessage('', true);
  try
    closefile(lf);
  except
  end;
end;
