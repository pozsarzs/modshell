{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | const.pas                                                                | }
{ | constants                                                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

const
  // OTHERS
  MINTERMX = 80;
  MINTERMY = 25;
  PROMPT = 'MODSH|_>';
  PRGCOPYRIGHT = '(C) 2023-2024 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'ModShell';
  PRGVERSION = '0.1';
  COMMARRSIZE = 94;
  SCRBUFFSIZE = 1024;
  SHOWTIMEDELAY = 25;
  VARBUFFSIZE = 128;
  {$IFDEF UNIX}
    EOL = #10;
  {$ELSE}
    EOL = #13 + #10;
  {$ENDIF}
  // VALID BOOLEAN VALUES
  BOOLVALUES: array[0..1,0..2] of string =
  (
    ('0','L','FALSE'),
    ('1','H','TRUE')
  );
  // COMMAND LINE PARAMETERS
  CMDLINEPARAMS: array[0..3, 0..2] of string =
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information'),
    ('-f','--fullscreen','full screen mode'),
    ('-r','--run','run script')
  );
  // COMMANDS AND PARAMETERS
  COMMANDS: array[0..COMMARRSIZE - 1] of string =
    ('copy',  'exit',  'get',    'help',   'let',    'print',  'read',   'reset',   'set',    'date',
     'ver',   'write', 'cls',    'savecfg','loadcfg','expreg', 'exphis', 'conv',    'savereg','loadreg',
     'var',   'color', 'impreg', 'and',    'or',     'not',    'xor',    'shl',     'shr',    'add',
     'sub',   'mul',   'div',    'dump',   'pause',  'sercons','serread','serwrite','echo',   'loadscr',
     'run',   'list',  'round',  'cos',    'cotan',  'dec',    'exp',    'idiv',    'imod',   'inc',
     'ln',    'mulinv','odd',    'rnd',    'tan',    'sin',    'sqr',    'sqrt',    'roll',   'rolr',
     'upcase','length','lowcase','stritem','chr',    'ord',    'const',  'bit',     'pow',    'goto',
     'if',    'for',   'label',  'mbsrv',  'mbgw',   'inrange','mklrc',  'mkcrc',   'pow2',   'ascii',
     'beep',  'avg',   'prop',   'concat', 'strdel', 'strfind','strins', 'strrepl', 'varmon', 'applog',
     'cron',  'edit',  'erase',  'savescr');
  DEV_TYPE: array[0..1] of string = ('net','ser');
  DEV_SPEED: array[0..7] of string =
    ('1200','2400','4800','9600','19200','38400','57600','115200');
  DEV_PARITY: array[0..2] of char = ('e','n','o');
  FILE_TYPE: array[0..2] of string = ('csv','ini','xml');
  PROT_TYPE: array[0..2] of string = ('ascii','rtu','tcp');
  REG_TYPE: array[0..3] of string = ('dinp','coil','ireg','hreg');
  PREFIX: array[0..3] of string = ('dev','pro','con','prj');
  ECHO_ARG: array[0..3] of string = ('off','on','hex','swap');
  NUM_SYS: array[0..3] of string = ('bin','dec','hex','oct');
  // Modbus timeout
  DEV_TIMEOUT: integer = 100; // x 10 ms