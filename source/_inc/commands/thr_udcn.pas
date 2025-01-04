{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_udcn.pas                                                             | }
{ | command 'udpcons'                                                        | }
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
  ------------
  udpcons dev?
}

// COMMAND 'UDPCONS'
function TLThread.thr_udpcons(p1: byte): byte;
var
  b: byte;
  fpn, fp: string;
  lf: file of char;

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
    sendmessage(MSG50, true);
  end;
  // PRIMARY MISSION
  with dev[p1] do
    repeat
      if udp_open(ipaddress, inttostr(port))  then
      begin
        // send a char
        if keyprd then
        begin
          keyprd := false;
          if udp_canwrite then
          begin
            udp_sendbyte(ord(prdkey));
            // echo method
            case uconfig.echometh of
              1: sendmessage(prdkey, false);
              2: sendmessage(addsomezero(2, deztohex(inttostr(ord(prdkey)))) +
                                                     ' ', false);
            end;
            // write to console.log
            try
              write(lf, prdkey);
            except
            end;
            if prdkey = #13 then sendmessage('', true);
          end else sendmessage(ERR27, true);
        end;
        // receive a char
        if udp_canread then
        begin
          b := udp_recvbyte;
          // echo method
          case uconfig.echometh of
            1: sendmessage(char(b), false);
            2: sendmessage(addsomezero(2, deztohex(inttostr(b))) + ' ', false);
          end;
          // write to console.log
          try
            write(lf, char(b));
          except
          end;
          if b = 13 then sendmessage('', true);
        end;
        udp_close;
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
