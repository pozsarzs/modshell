{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | var.pas                                                                  | }
{ | declaring variables                                                      | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

var
  {$IFNDEF GO32V2} ser: TBlockSerial; {$ENDIF}
  // BUFFERS
  // Modbus registers
  coil: array[1..9999] of boolean;
  dinp: array[1..9999] of boolean;
  ireg: array[1..9999] of word;
  hreg: array[1..9999] of word;
  // variables and constats
  arrays: array[0..ARRBUFFSIZE-1] of tarray;
  vars: array[0..VARBUFFSIZE-1] of tvariable;
  // SETTINGS - DEVICE, PROJECT NAME, PROTOCOL, CONNECTION
  dev: array[0..7] of tdevice;
  prot: array[0..7] of tprotocol;
  conn: array[0..7] of tconnection;
  // OTHERS
  b: byte;
  appmode: byte;
  exitcode: byte;
  lang: string;
  originaldirectory: string;
  sbuffer: array[0..SCRBUFFSIZE - 1] of string;
  scriptline: integer;
  scriptlabel: integer;
  scriptlastline: integer;
  scriptisloaded: boolean = false;
  varmon: boolean = false;
  // CRON
  crontable: array[1..4] of tcron;
  // SPLITTED COMMAND LINE
  splitted: array[0..7] of string;
  // CONNECTION TIMEOUT
  timeout: integer = 3; // default timeout in s
