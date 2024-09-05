{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | var.pas                                                                  | }
{ | variables                                                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

var
  {$IFNDEF GO32V2}
    ser: tblockserial;
  {$ENDIF}
  // BUFFERS
  // registers
  coil: array[1..9999] of boolean;
  dinp: array[1..9999] of boolean;
  ireg: array[1..9999] of word;
  hreg: array[1..9999] of word;
  sbuffer: array[0..SCRBUFFSIZE - 1] of string;
  // variables and constats
  vars: array[0..VARBUFFSIZE-1] of tvariable;
  {$IFDEF GO32V2}
    proj: string[8] = 'default';
  {$ELSE}
    proj: string[16] = 'default';
  {$ENDIF}
  // SETTINGS - DEVICE, PROJECT NAME, PROTOCOL, CONNECTION
  dev: array[0..7] of tdevice;
  prot: array[0..7] of tprotocol;
  conn: array[0..7] of tconnection;
  // OTHERS
  b: byte;
  appmode: byte;
  exitcode: byte;
  lang: string;
  scriptline: integer;
  scriptlabel: integer;
  scriptlastline: integer;
  scriptisloaded: boolean = false;
  varmon: boolean = false;
  // SPLITTED COMMAND LINE
  splitted: array[0..7] of string;
  // CRON
  crontable: array[1..4] of tcron;
