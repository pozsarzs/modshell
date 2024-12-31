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
  {$IFDEF WINDOWS}
    TInp32 = function(Address: SmallInt): SmallInt; stdcall;
    TOut32 = procedure(Address: SmallInt; Data: SmallInt); stdcall;
  {$ENDIF}
  // constant and variable
  tvariable = record
    vname: string[16];            // name
    vvalue: string[255];          // value
    vreadonly: boolean;           // variable or constant
    vmonitored: boolean;          // it is monitored?
  end;
  // array of constant and variable
  tarray = record
    aname: string[16];            // name
    aitems: array of string[255]; // items
    areadonly: boolean;           // variable or constant
    amonitored: boolean;          // it is monitored?
  end;
  // command macro
  tmacro = record
    mname: string[16];            // name
    mcommand: string;             // command and parameters
  end;
  // cron record
  tcron = record
     cenable: boolean;            // enable/disable this record
     chour: byte;                 // hour(s)
     cminute: byte;               // minutes(s)
  end;
  // settings
  tdevice = record
    valid: boolean;               // false|true: invalid|valid
    devtype: byte;                // 0..1 -> DEV_TYPE
    device: string[15];           // /dev/ttySx, /dev/ttyUSBx, /dev/ttyAMAx, COMx, etc.
    ipaddress: string[15];        // a.b.c.d
    port: word;                   // 0-65535
    speed: byte;                  // 0..7 -> DEV_SPEED
    databit: byte;                // 7|8
    parity: byte;                 // 0..2 -> DEV_PARITY
    stopbit: byte;                // 1|2
  end;
  tprotocol = record
    valid: boolean;               // false|true: invalid|valid
    prottype: byte;               // 0..4 -> PROT_TYPE
    id: integer;                  // 1..247 or 1..255
  end;
  tconnection = record
    valid: boolean;               // false|true: invalid|valid
    dev: byte;                    // 0..7
    prot: byte;                   // 0..7
  end;
