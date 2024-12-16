{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_mbmn.pas                                                             | }
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
  p0      p1
  --------------
  mbmon   [con?]
}

// COMMAND MBMON
function cmd_mbmon(p1: string): byte;
var
  i1: integer; // parameter in other type
  loop: boolean;
  s: string;
  s1: string; // parameter in other type

  ser: TBlockSerial;
  baudrate: string = '';
  b: byte;
  c: char;
  databit: string = '';
  device: string = '';
  deviceid: string = '';
  parity: string = '';
  protocol: string = '';
  stopbit: string = '';

begin
  result := 0;
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  // CHECK P1 PARAMETER
  if PREFIX[2] <> s1 then
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    s := s + ' ' + PREFIX[2] + '[0-7]';
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
    result := 1;
    exit;
  end;
  if length(p1) >= 4 then i1 := strtointdef(p1[4],-1) else
  begin
    // Device number must be 0-7!
    {$IFNDEF X} writeln(ERR01); {$ELSE} Form1.Memo1.Lines.Add(ERR01); {$ENDIF}
    result := 1;
    exit;
  end;

  // con/prot/dev érvényesség ellenőrzése ide

  // parameters of connection
  device := dev[conn[i1].dev].device;
  baudrate := DEV_SPEED[dev[conn[i1].dev].speed];
  databit := inttostr(dev[conn[i1].dev].databit);
  parity := DEV_PARITY[dev[conn[i1].dev].parity];
  stopbit := inttostr(dev[conn[i1].dev].stopbit);
  protocol := PROT_TYPE[prot[conn[i1].prot].prottype];
 // deviceid := inttostr(prot[conn[i1].prot].deviceid);
  // PRIMARY MISSION
  writeln(MSG14 + device + ' ' + baudrate + ' ' + databit + uppercase(parity) + stopbit);
  writeln(MSG15 +  uppercase(protocol) + ' #' + deviceid);
  writeln;
  writeln(MSG04);
  {$IFDEF UNIX}
    // check lockfile
    if checklockfile('/dev/' + device, false)
      then quit(3, false, ERR01 + ERR49 + device);
  {$ENDIF}
  // PRIMARY MISSION
  {$IFNDEF PROGTEST}
    ser := TBlockSerial.Create;
    try
      ser.Connect(device);
      ser.Config(strtoint(baudrate), strtoint(databit), parity[1], strtoint(stopbit), false, false);
    except
      quit(2, false, ERR01 + ERR08 + device);
    end;
  {$ENDIF}
  writeln(MSG05);
  writeln;
  // write header
  if protocol = PROT_TYPE[0] then write('L') else write('C');
  writeln(MSG16 + MSG19);
  // write traffic
  repeat
    if keypressed then c := readkey else
    begin
      if ser.CanRead(0) then
      begin
        s := ser.RecvString(0);
//        writeln(decodetelegram(protocol, deviceid, s));
      end;    
      delay(100);
    end;
    // pause
    if c = #32 then
    begin
      write(MSG20);
      c := readkey;
      gotoxy(1,wherey); clreol;
    end;
  until c = #27;
  ser.Free;
  writeln(EOL + MSG13);
  result := 0;
end;
