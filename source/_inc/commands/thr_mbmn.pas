{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_mbmn.pas                                                             | }
{ | serial Modbus traffic monitor (same as SerialMBMonitor utility)          | }
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
  ------------
  mbmon [con?]
}

// COMMAND MBMON
function TLThread.thr_mbmon(p1: byte): byte;
var
  fpn, fp: string;
  lf: textfile;
  s: string;

{$I sendmesg.pas}

begin
  result := 0;
  if not dev[conn[p1].dev].valid then
  begin
    sendmessage(PREFIX[0] + inttostr(p1) + MSG06, true);
    exit;
  end;
  if not (dev[conn[p1].dev].devtype = 1) then
  begin
    sendmessage(ERR24, true);
    result := 1;
    exit;
  end;
  // SET LOG FILE
  fp := vars[13].vvalue;
  ForceDirectories(fp);
  fp := fp + SLASH;
  fpn := fp + SLASH + 'mbmon.log';
  assignfile(lf, fpn);
  try
    rewrite(lf);
  except
    sendmessage(ERR61, true);
  end;
  // PRIMARY MISSION
  sendmessage(MSG101, true);
  if checklockfile(dev[conn[p1].dev].device, true) then exit;
  with dev[conn[p1].dev] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      sendmessage(MSG91 + EOL, true);
      // write header
      if prot[conn[p1].prot].id = 0
        then sendmessage('L' + MSG104 + MSG107, true)
        else sendmessage('C' + MSG104 + MSG107, true);
      // write traffic
      repeat
        if keyprd then keyprd := false else
        begin
          if ser_canread then
          begin
            s := ser_recvstring;
            sendmessage(mbdecodetelegram(PROT_TYPE[prot[conn[p1].prot].prottype],
                    inttostr(prot[conn[p1].prot].id), s), true);
          end;    
          sleep(100);
        end;
        // pause
        if prdkey = #32 then showmessage(MSG92);
      until prdkey = #27;
      sendmessage(EOL + MSG93, true);
      ser_close;
    end else
    begin
      // Cannot initialize serial port!
      sendmessage(ERR18 + dev[conn[p1].dev].device, true);
      result := 1;
    end;
  try
    closefile(lf);
  except
  end;
end;
