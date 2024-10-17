{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | thr_secn.pas                                                             | }
{ | command 'sercons'                                                        | }
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
  sercons ?
}

// COMMAND 'SERCONS'
function TLThread.thr_sercons(p1: byte): byte;
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
  if not (dev[p1].devtype = 1) then
  begin
    sendmessage(MSG24, true);
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
  if checklockfile(dev[p1].device, true) then exit;
  with dev[p1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      repeat
        // send a char
        if keyprd then
        begin
          keyprd := false;
          if ser_canwrite then
          begin
            ser_sendstring(prdkey);
            sendmessage(prdkey, false);
            try
              write(lf, prdkey);
            except
            end;
            if prdkey = #13 then sendmessage('', true);
          end else sendmessage(ERR27, true);
        end;
        // receive a char
        if ser_canread then
        begin
          b := ser_recvbyte;
          sendmessage(char(b), false);
          try
            write(lf, char(b));
          except
          end;
          if b = 13 then sendmessage('', true);
        end;
      until prdkey = #27;
      ser_close;
      sendmessage('', true);
    end else
    begin
      // Cannot initialize serial port!
      sendmessage(ERR18 + device, true);
      result := 1;
    end;
  try
    closefile(lf);
  except
  end;
end;
