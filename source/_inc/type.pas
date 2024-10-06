{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | type.pas                                                                 | }
{ | declaring types                                                          | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

type
  tdevice = record
    valid: boolean;        // false|true: invalid|valid
    devtype: byte;         // 0..1 -> DEV_TYPE
    device: string[15];    // /dev/ttySx, /dev/ttyUSBx, /dev/ttyAMAx, COMx, etc.
    port: word;            // 0-65535
    speed: byte;           // 0..7 -> DEV_SPEED
    databit: byte;         // 7|8
    parity: byte;          // 0..2 -> DEV_PARITY
    stopbit: byte;         // 1|2
  end;
  tprotocol = record
    valid: boolean;        // false|true: invalid|valid
    prottype: byte;        // 0..2 -> PROT_TYPE
    ipaddress: string[15]; // a.b.c.d
    uid: integer;          // 1..247
  end;
  tconnection = record
    valid: boolean;        // false|true: invalid|valid
    dev: byte;             // 0..7
    prot: byte;            // 0..7
  end;
  tvariable = record
    vname: string[16];     // name
    vvalue: string[255];   // value
    vreadonly: boolean;    // variable or constant
    vmonitored: boolean;   // it is monitored?
  end;
  type
    tcron = record
     cenable: boolean;     // enable/disable this record
     chour: byte;          // hour(s)
     cminute: byte;        // minutes(s)
  end;
