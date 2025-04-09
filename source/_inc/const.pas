{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | const.pas                                                                | }
{ | declaring constants                                                      | }
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
  ARRBUFFSIZE = 32;
  COMMARRSIZE = 137;
  MCRBUFFSIZE = 32;
  MINTERMX = 80;
  MINTERMY = 25;
  PRGCOPYRIGHT = '(C) 2023-2025 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'ModShell';
  PRGVERSION = '0.1';
  PROMPT = 'MODSH|_>';
  SCRBUFFSIZE = 1024;
  SHOWTIMEDELAY = 25;
  VARBUFFSIZE = 128;
  {$IFDEF UNIX} EOL = #10; {$ELSE} EOL = #13 + #10; {$ENDIF}
  // VALUE RANGES
  SVR = '0-7';
  AVR = ' 0-9998';
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
    {         0             1             2           3             4            5          6          7           8          9           }
    {   0 } ('copyreg',    'exit',       'get',      'help',       'let',       'print',   'readreg', 'reset',    'set',      'date',
    {  10 }  'ver',        'writereg',   'cls',      'savecfg',    'loadcfg',   'expreg',  'exphis',  'conv',     'savereg',  'loadreg',
    {  20 }  'var',        'printcolor', 'impreg',   'and',        'or',        'not',     'xor',     'shl',      'shr',      'add',
    {  30 }  'sub',        'mul',        'div',      'dump',       'pause',     'sercons', 'serread', 'serwrite', 'echometh', 'loadscr',
    {  40 }  'run',        'list',       'round',    'cos',        'cotan',     'dec',     'exp',     'idiv',     'imod',     'inc',
    {  50 }  'ln',         'mulinv',     'odd',      'rnd',        'tan',       'sin',     'sqr',     'sqrt',     'roll',     'rolr',
    {  60 }  'upcase',     'length',     'lowcase',  'stritem',    'chr',       'ord',     'const',   'bit',      'pow',      'goto',
    {  70 }  'if',         'for',        'label',    'mbsrv',      'mbgw',      'inrange', 'mklrc',   'mkcrc',    'pow2',     'ascii',
    {  80 }  'beep',       'avg',        'prop',     'concat',     'strdel',    'strfind', 'strins',  'strrepl',  'varmon',   'applog',
    {  90 }  'cron',       'edit',       'erasescr', 'savescr',    'dir',       'cd',      'md',      'rd',       'del',      'type',
    { 100 }  'copy',       'ren',        'exist',    'chkdevlock', 'rmdevlock', 'carr',    'varr',    'arrclear', 'arrfill',  'getarrsize',
    { 110 }  'setarrsize', 'dcon',       'tcpcons',  'tcpread',    'tcpwrite',  'udpcons', 'udpread', 'udpwrite', 'hart',     'inputmeth',
    { 120 }  'sendmeth',   'macro',      'mbmon',    'mbconv',     'datatype',  'ioread',  'iowrite', 'runmeth',  'input',    'gpioinit',
    { 130 }  'gpioread',   'gpiowrite',  'pipe',     'stack',      'swp',       'abs',     'whatever');
  DEV_TYPE: array[0..1] of string = ('net','ser');
  DEV_SPEED: array[0..10] of string = ('150','300','600','1200','2400','4800','9600','19200','38400','57600','115200');
  DEV_PARITY: array[0..2] of char = ('e','n','o');
  FILE_TYPE: array[0..2] of string = ('csv','ini','xml');
  PROT_TYPE: array[0..4] of string = ('ascii','rtu','tcp','dcon','hart');
  REG_TYPE: array[0..3] of string = ('dinp','coil','ireg','hreg');
  PREFIX: array[0..5] of string = ('dev','pro','con','project','timeout','color');
  METHOD: array[0..5] of string = ('off','an','hex','swap','chr','str');
  NUM_SYS: array[0..3] of string = ('bin','dec','hex','oct');
  XIFO_OP: array[0..1] of string = ('push','pop');
  GPIO_MODE: array[0..1] of string = ('in','out');
  RPI_VER: array[0..4] of string = ('isabus','rpi1','rpi2','rpi3','rpi4');
