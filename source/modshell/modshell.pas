{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | modshell.pas                                                             | }
{ | main program                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}{$MACRO ON}
program modshell;
uses
  {$IFDEF GO32V2}
    protcom,
  {$ELSE}
    synaser,
  {$ENDIF}
  convert,
  crt,
  dom,
  dos,
  gettext,
  inifiles,
  strings,
  sysutils,
  ucommon,
  uconfig,
  utranslt,
  xmlread,
  xmlwrite;
type
  tdevice = record
    valid: boolean;    // false|true: invalid|valid
    devtype: byte;     // 0..1 -> DEV_TYPE
    device: string[15];    // /dev/ttySx, /dev/ttyUSBx, /dev/ttyAMAx, COMx, etc.
    port: word;        // 0-65535
    speed: byte;       // 0..7 -> DEV_SPEED
    databit: byte;     // 7|8
    parity: byte;      // 0..2 -> DEV_PARITY
    stopbit: byte;     // 1|2
  end;
  tprotocol = record
    valid: boolean;    // false|true: invalid|valid
    prottype: byte;    // 0..2 -> PROT_TYPE
    ipaddress: string[15]; // a.b.c.d
    uid: integer;      // 1..247
  end;
  tconnection = record
    valid: boolean;    // false|true: invalid|valid
    dev: byte;         // 0..7
    prot: byte;        // 0..7
  end;
  tvariable = record
    vname: string[16];
    vvalue: string[255];
  end;
var
  {$IFNDEF GO32V2}
    ser: tblockserial;
  {$ENDIF}
  // BUFFER
  coil: array[1..9999] of boolean;
  dinp: array[1..9999] of boolean;
  ireg: array[1..9999] of word;
  hreg: array[1..9999] of word;
  // SETTINGS - DEVICE, PROJECT NAME, PROTOCOL, CONNECTION
  dev: array[0..7] of tdevice;
  {$IFDEF GO32V2}
    proj: string[8] = 'default';
  {$ELSE}
    proj: string[16] = 'default';
  {$ENDIF}
  prot: array[0..7] of tprotocol;
  conn: array[0..7] of tconnection;
  // VARIABLES
  vars: array[0..63] of tvariable;
  // OTHERS
  appmode: byte;
  b: byte;
  lang: string;
  // splitted command line
  splitted: array[0..7] of string;
const
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
  COMMANDS: array[0..38] of string = ('copy','exit','get','help','let',
                                      'print','read','reset','set','date',
                                      'ver','write','cls','savecfg',
                                      'loadcfg','expreg','exphis','conv',
                                      'savereg','loadreg','var','color',
                                      'impreg','and','or','not','xor','shl',
                                      'shr','add','sub','mul','div','dump',
                                      'pause','sercons','serread','serwrite',
                                      'echo');
  PROMPT = 'MODSH|_>';
  DEV_TYPE: array[0..1] of string = ('net','ser');
  DEV_SPEED: array[0..7] of string = ('1200','2400','4800','9600','19200',
                                      '38400','57600','115200');
  DEV_PARITY: array[0..2] of char = ('e','n','o');
  DEV_TIMEOUT: integer = 0;
  FILE_TYPE: array[0..2] of string = ('csv','ini','xml');
  PROT_TYPE: array[0..2] of string = ('ascii','rtu','tcp');
  REG_TYPE: array[0..3] of string = ('dinp','coil','ireg','hreg');
  PREFIX: array[0..3] of string = ('dev','pro','con','prj');
  ECHO_ARG: array[0..3] of string = ('off','on','hex','swap');
  // OTHERS
  PRGCOPYRIGHT = '(C) 2023 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'ModShell';
  PRGVERSION = '0.1';
  NUM_SYS: array[0..3] of string = ('bin','dec','hex','oct');

{$IFNDEF GO32V2}
  {$R *.res}
{$ENDIF}

{$DEFINE BASENAME := lowercase(PRGNAME)}
{$DEFINE COMMENT := #35}

// Uncomment following line, if you want to build binary file
// for deb, rpm, tgz package.
// {$DEFINE INSTPKGMAN}

{$IFDEF GO32V2}
  {$DEFINE SHEBANG := '@modshell -r %0' + #13 + #10 + '@goto :eof'}
  {$DEFINE LABELEOF := ':eof'}
{$ELSE}
  {$IFDEF BSD}
    {$DEFINE SHEBANG := '#!/usr/local/bin/modshell -r'}
  {$ELSE}
    {$IFDEF LINUX}
      {$IFDEF INSTPKGMAN}
        {$DEFINE SHEBANG := '#!/usr/bin/modshell -r'}
      {$ELSE}
        {$DEFINE SHEBANG := '#!/usr/local/bin/modshell -r'}
      {$ENDIF}
    {$ELSE}
      {$IFDEF WINDOWS}
        {$DEFINE SHEBANG := '@modshell -r %0' + #13 + #10 + '@goto :eof'}
        {$DEFINE LABELEOF := ':eof'}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF UNIX}
  {$DEFINE SLASH := #47}
{$ELSE}
  {$DEFINE SLASH := #92}
{$ENDIF}

resourcestring
  // GENERAL MESSAGES
  MSG01 = '<F1> help <F2> savecfg <F3> loadcfg <F4> savereg <F5> loadreg <F6> dump <F8> clear <F10> exit';
  MSG02 = 'Command-driven scriptable Modbus utility';
  MSG03 = 'Use ''help COMMAND'' to show usage.';
  MSG04 = 'Usage this command:';
  MSG05 = 'parameter:';
  MSG06 = ' is not set.';
  MSG07 = ' device:     ';
  MSG08 = ' port:       ';
  MSG09 = ' baudrate:   ';
  MSG10 = ' settings:   ';
  MSG11 = ' protocol:   ';
  MSG12 = ' IP address: ';
  MSG13 = ' device UID: ';
  MSG14 = 'File exist, overwrite? (y/n)';
  MSG15 = 'Command line history has exported to ';
  MSG16 = 'Settings has saved to ';
  MSG17 = 'Settings has loaded from ';
  MSG18 = 'Register content has exported to ';
  MSG19 = 'Register content has imported from ';
  MSG20 = 'Register content has saved to ';
  MSG21 = 'Register content has loaded from ';
  MSG22 = 'Useable file types: ';
  MSG23 = 'Press a key to continue... ';
  MSG24 = 'Note:' + #13 + #10 +
          '  - register: local buffer register' + #13 + #10 +
          '  - remote register: register of the connected device' + #13 + #10;
  MSG25 = 'Select register type: ';
  MSG26 = 'Local register type (dinp/coil/ireg/hreg: 1/2/3/4): ';
  MSG27 = 'Start address (0-9990): ';
  MSG28 = 'Echo mode: ';
  MSG29 = 'Mini serial console (exit: <F10>)';
  MSG30 = 'Device number (0-7): ';
  MSG31 = 'Press <Esc> to stop receiving.';
  MSG99 = 'Sorry, this feature is not yet implemented.';
  // ERROR MESSAGES
  ERR00 = 'No such command!';
  ERR01 = 'Device number must be 0-7!';
  ERR02 = 'Protocol number must be 0-7!';
  ERR03 = 'Connection number must be 0-7!';
  ERR04 = 'IP address is not valid!';
  ERR05 = 'Parameter(s) required!';
  ERR06 = 'UID must be 1-247!';
  ERR07 = 'Cannot export command line history to ';
  ERR08 = 'Cannot save settings to ';
  ERR09 = 'Cannot load settings from ';
  ERR10 = 'Cannot export register content to ';
  ERR11 = 'Cannot import register content from ';
  ERR12 = 'Cannot save register content to ';
  ERR13 = 'Cannot load register content from ';
  ERR14 = 'Illegal character in the project name!';
  ERR15 = 'Illegal character in the variable name!';
  ERR16 = 'Cannot define more variable!';
  ERR17 = 'There is already a variable with that name';
  ERR18 = 'Cannot initialize serial port: ';
  ERR19 = 'No such variable: ';
  ERR20 = 'Calculating error!';
  ERR21 = 'No such script file: ';
  ERR22 = 'Cannot load script from ';
  ERR23 = 'Script buffer is full!';
  ERR24 = 'Specified device is not a serial port!';
  ERR25 = 'Specified device is not a ethernet port!';
  ERR26 = 'Cannot read data from serial port!';
  ERR27 = 'Cannot write data to serial port!';
  ERR28 = 'Modbus telegram parsing error!';
  // COMMAND DESCRIPTION
  DES00='       copy one or more remote reg. between two connections';
  DES01='F10    exit';
  DES02='ALT-G  show device, protocol, connection or project name';
  DES03='F1     show description or usage of the commands';
  DES04='ALT-L  set value of a variable or a register';
  DES05='ALT-P  print message, value of the variable and register';
  DES06='ALT-R  read one or more remote registers to buffer';
  DES07='ALT-T  reset device, protocol, connection or project name';
  DES08='ALT-S  set device, protocol, connection or project name';
  DES09='       show system date and time';
  DES10='       show version and build information of this program';
  DES11='ALT-W  write data from buffer to one or more remote registers';
  DES12='F8     clear screen';
  DES13='F2     save settings of device, protocol and connection';
  DES14='F3     load settings of device, protocol and connection';
  DES15='ALT-E  export value of the one or more registers';
  DES16='       export command line history to make a script easily';
  DES17='ALT-C  convert value between different numeral systems';
  DES18='F4     save all registers';
  DES19='F5     load all registers';
  DES20='       list all variable with value or define a new one';
  DES21='       set colors';
  DES22='ALT-I  import value of the one or more registers';
  DES23='       AND logical operations';
  DES24='       OR logical operations';
  DES25='       NOT logical operations';
  DES26='       XOR logical operations';
  DES27='       bit shift to left';
  DES28='       bit shift to right';
  DES29='       addition mathematical operation';
  DES30='       substraction mathematical operation';
  DES31='       multiplication mathematical operation';
  DES32='       division mathematical operation';
  DES33='F6     dump all registers in binary/hexadecimal format to a table';
  DES34='       wait for a keystroke or specified time';
  DES35='F7     open a simple serial console';
  DES36='       read string from serial device';
  DES37='       write string to serial device';
  DES38='F9     query local echo status or enable/disable it';
  // COMMAND USAGE
  USG00='copy con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG01='exit';
  USG02='get dev?|pro?|con?|prj' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG03='help [[$]COMMAND]';
  USG04='let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE' + #13 + #10 +
        '  let $VARIABLE [$]VALUE' + #13 + #10 +
        '  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG05='print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT] [-n]' + #13 + #10 +
        '  print $VARIABLE [-n]' + #13 + #10 +
        '  print "single\ line\ message" [-n]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG06='read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG07='reset dev?|pro?|con?|prj' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG08='set dev? net [$]DEVICE [$]PORT' + #13 + #10 +
        '  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT' + #13 + #10 +
        '  set pro? ascii|rtu [$]UID' + #13 + #10 +
        '  set pro? tcp [$]IP_ADDRESS' + #13 + #10 +
        '  set con? dev? pro?' + #13 + #10 +
        '  set prj [$]PROJECT_NAME' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG09='date';
  USG10='ver';
  USG11='write con? coil|hreg [$]ADDRESS [[$]COUNT]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG12='cls';
  USG13='savecfg [$]PATH_AND_FILENAME';
  USG14='loadcfg [$]PATH_AND_FILENAME';
  USG15='expreg [$]PATH_AND_FILENAME dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]';
  USG16='exphis [$]PATH_AND_FILENAME';
  USG17='conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG18='savereg [$]PATH_AND_FILENAME';
  USG19='loadreg [$]PATH_AND_FILENAME';
  USG20='var' + #13 + #10 +
        '  var NAME [[$]VALUE]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG21='color [$]FOREGROUND [$]BACKGROUND [$]RXD_TEXT [$]TXD_TEXT' + #13 + #10 +
        '  colors:' + #13 + #10 +
        '      0: black  4: red         8: darkgray    12: lightred' + #13 + #10 +
        '      1: blue   5: magenta:    9: lightblue   13: lightmagenta' + #13 + #10 +
        '      2: green  6: brown      10: lightgreen  14: yellow' + #13 + #10 +
        '      3: cyan   7: lightgray  11: lightcyan   15: white';
  USG22='impreg [$]PATH_AND_FILENAME';
  USG23='and $TARGET [$]VALUE1 [$]VALUE2';
  USG24='or $TARGET [$]VALUE1 [$]VALUE2';
  USG25='not $TARGET [$]VALUE';
  USG26='xor $TARGET [$]VALUE1 [$]VALUE2';
  USG27='shl $TARGET [$]VALUE1 [$]VALUE2';
  USG28='shr $TARGET [$]VALUE1 [$]VALUE2';
  USG29='add $TARGET [$]VALUE1 [$]VALUE2';
  USG30='sub $TARGET [$]VALUE1 [$]VALUE2';
  USG31='mul $TARGET [$]VALUE1 [$]VALUE2';
  USG32='div $TARGET [$]VALUE1 [$]VALUE2';
  USG33='dump [[dinp|coil|ireg|hreg] [$]ADDRESS]';
  USG34='pause [[$]TIME]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''$'' sign indicates a variable not a direct value.';
  USG35='sercons [dev?]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG36='serread dev? [$TARGET]' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG37='serwrite dev? $MESSAGE' + #13 + #10 +
        '  serwrite dev? "MESSAGE"' + #13 + #10 +
        'Notes:' + #13 + #10 +
        '  - The ''?'' value can be 0-7.';
  USG38='echo [off|on|hex]';
procedure version(h: boolean); forward;

// IF S IS A VARIABLE, IT RETURNS theirs number
function intisitvariable(s: string): integer;
var
  i: integer;
begin
  result := 0;
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to 63 do
      if vars[i].vname = lowercase(s)
      then result := i;
  end;
end;

// IF S IS A VARIABLE, IT RETURNS TRUE
function boolisitvariable(s: string): boolean;
var
  i: integer;
begin
  result := false;
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to 63 do
      if vars[i].vname = lowercase(s)
      then result := true;
  end;
end;

// IF S IS A VARIABLE, IT RETURNS ITS VALUE
function isitvariable(s: string): string;
var
  i: integer;
begin
  result := '';
  if (s[1] = #36) then
  begin
    s := stringreplace(s, #36 , '', [rfReplaceAll]);
    for i := 0 to 63 do
      if vars[i].vname = lowercase(s)
      then result := stringreplace(vars[i].vvalue, #92+#32 , #32, [rfReplaceAll]);
  end;
end;

// IF S IS A MESSAGE, IT RETURNS ITS VALUE
function isitmessage(s: string): string;
begin
  result := '';
  if (s[1] = #34) and (s[length(s)] = #34) then
  begin
    s := stringreplace(s, #34 , '', [rfReplaceAll]);
    s := stringreplace(s, #92+#32 , #32, [rfReplaceAll]);
    result := s;
  end;
end;

// CHECK VALIDITY OF DEV?/PRO?/CON?'
function validity(sets, number: byte): boolean;
begin
  case sets of
    0: result := dev[number].valid;
    1: result := prot[number].valid;
    2: result := conn[number].valid;
  else
    result := false;
  end;
  if not result then writeln(PREFIX[sets], number, MSG06);
end;

{$I ethernet.pas}
{$I serport.pas}
{$I mbascii.pas}
{$I mbrtu.pas}
{$I mbtcp.pas}
{$I modbus.pas}
{$I cmd_colr.pas}
{$I cmd_conv.pas}
{$I cmd_copy.pas}
{$I cmd_date.pas}
{$I cmd_dump.pas}
{$I cmd_echo.pas}
{$I cmd_exph.pas}
{$I cmd_expr.pas}
{$I cmd_get.pas}
{$I cmd_help.pas}
{$I cmd_impr.pas}
{$I cmd_let.pas}
{$I cmd_lcfg.pas}
{$I cmd_logc.pas}
{$I cmd_lreg.pas}
{$I cmd_math.pas}
{$I cmd_paus.pas}
{$I cmd_prnt.pas}
{$I cmd_read.pas}
{$I cmd_rst.pas}
{$I cmd_scfg.pas}
{$I cmd_secn.pas}
{$I cmd_serd.pas}
{$I cmd_sewr.pas}
{$I cmd_sreg.pas}
{$I cmd_set.pas}
{$I cmd_var.pas}
{$I cmd_wrte.pas}

// PARSING COMMANDS
procedure parsingcommands(command: string);
var
 a, b: byte;
 s: string;
 o: boolean;

begin
  if (length(command) > 0) then
    if (command[1] <> #58) and (command[1] <> #64) then
    begin
      // REMOVE SPACE AND TAB FROM START OF LINE
      while (command[1] = #32) or (command[1] = #9) do
        delete(command, 1, 1);
      // REMOVE SPACE AND TAB FROM END OF LINE
      while (command[length(command)] = #32) or (command[length(command)] = #9) do
        delete(command, length(command), 1);
      // REMOVE EXTRA SPACE AND TAB FROM LINE
      for b := 1 to 255 do
      begin
        if b = length(command) then break;
        if command[b] <> #32 then o := false;
        if (command[b] = #32) and o then command[b] :='@';
        if command[b] = #32 then o := true;
      end;
      s := '';
      for b := 1 to length(command) do
        if command[b] <> '@' then s := s + command[b];
      command := s;
      // SPLIT COMMAND TO EIGHT SLICES
      for b := 0 to 7 do
        splitted[b] := '';
      for a := 1 to length(command) do
        if (command[a] = #32) and (command[a - 1] <> #92)
          then break
          else splitted[0] := splitted[0] + command[a];
      for b:= 1 to 7 do
        for a := a + 1 to length(command) do
          if (command[a] = #32) and (command[a - 1] <> #92)
            then break
            else splitted[b] := splitted[b] + command[a];
      // PARSE COMMAND
      o := false;
      if splitted[0][1] <> COMMENT then
      begin
        for b := 0 to 38 do
          if splitted[0] = COMMANDS[b] then
          begin
            o := true;
            break;
          end;
        if not o then writeln(ERR00) else
        begin
          case b of
            0: cmd_copy(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               // copy conn? dinp|coil conn? coil ADDRESS COUNT
               // copy conn? ireg|hreg conn? hreg ADDRESS COUNT
            2: cmd_get(splitted[1]);
               // get dev?|prot?|conn?|prj
            3: cmd_help(splitted[1]);
               // help [COMMAND]
            4: cmd_let(splitted[1], splitted[2], splitted[3]);
               // let dinp|coil|ireg|hreg ADDRESS VALUE
               // let $VARIABLE VALUE
               // let $VARIABLE dinp|coil|ireg|hreg ADDRESS
            5: cmd_print(splitted[1], splitted[2], splitted[3], splitted[4]);
               // print dinp|coil|ireg|hreg ADDRESS [COUNT] [-n]
               // print $VARIABLE [-n]
               // print "Hello\ world!" [-n]
            6: cmd_read(splitted[1], splitted[2], splitted[3], splitted[4]);
               // read conn? dinp|coil|ireg|hreg ADDRESS [COUNT]
            7: cmd_reset(splitted[1]);
               // reset dev?|prot?|conn?|prj
            8: cmd_set(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
               // set dev? ser DEVICE BAUDRATE DATABIT PARITY STOPBIT
               // set dev? net DEVICE PORT
               // set prot? ascii|rtu UID
               // set prot? tcp IP_ADDRESS
               // set conn? dev? prot?
               // set prj PROJECT_NAME
            9: cmd_date;
               // date
           10: version(false);
               // ver
           11: cmd_write(splitted[1], splitted[2], splitted[3], splitted[4]);
               // write conn? coil|hreg ADDRESS [COUNT]
           12: clrscr;
               // cls
           13: cmd_savecfg(splitted[1]);
               // savecfg PATH_AND_FILENAME
           14: cmd_loadcfg(splitted[1]);
               // loadcfg PATH_AND_FILENAME
           15: cmd_expreg(splitted[1], splitted[2], splitted[3], splitted[4]);
               // expreg FILENAME dinp|coil|ireg|hreg ADDRESS [COUNT]
           16: cmd_exphis(splitted[1]);
               // exphis FILENAME
           17: cmd_conv(splitted[1], splitted[2], splitted[3]);
               // conv bin|dec|hex|oct bin|dec|hex|oct VALUE
           18: cmd_savereg(splitted[1]);
               // savereg PATH_AND_FILENAME
           19: cmd_loadreg(splitted[1]);
               // loadreg PATH_AND_FILENAME
           20: cmd_var(splitted[1], splitted[2]);
               // var
               // var NAME [VALUE]
           21: cmd_color(splitted[1], splitted[2], splitted[3], splitted[4]);
               // color FOREGROUND BACKGROUND
           22: cmd_impreg(splitted[1]);
               // impreg FILENAME
           33: cmd_dump(splitted[1], splitted[2]);
               // dump [dinp|coil|ireg|hreg]
           34: cmd_pause(splitted[1]);
               // pause [[$]TIME]
           35: cmd_sercons(splitted[1]);
               // sercons [dev?]
           36: cmd_serread(splitted[1], splitted[2]);
               // serread dev? [$TARGET]
           37: cmd_serwrite(splitted[1], splitted[2]);
               // serwrite dev? "MESSAGE"
               // serwrite dev? $MESSAGE
           38: cmd_echo(splitted[1]);
               // echo [off|on|hex|swap]
          else
          begin
            if (b > 22) and (b < 29) then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if (b > 28) and (b < 33) then cmd_math(b, splitted[1], splitted[2], splitted[3]);
          end;
        end;
      end;
    end;
  end;
end;

// SIMPLE COMMAND LINE
procedure simplecommandline;
var
  command: string;
  c: char;

// INSERT PROJECT NAME INTO PROMPT
function fullprompt: string;
begin
  result := stringreplace(PROMPT, '_' , proj, [rfReplaceAll]);
end;

begin
  if appmode = 0 then writeln(PRGNAME + ' v' + PRGVERSION);
  repeat
    if appmode = 3 then
    begin
      textbackground(uconfig.colors[1]);
      textcolor(uconfig.colors[0]);
    end;
    write(fullprompt);
    command := '';
    repeat
      c := readkey;
      // DETECT HOTKEYS
      if c = #0 then
      begin
        c := readkey;
        // ONLY INSERT
        if c = #34 then
          begin command := COMMANDS[17]; c := #32; end;                    // ~C
        if c = #34 then
          begin command := COMMANDS[15]; c := #32; end;                    // ~E
        if c = #34 then
          begin command := COMMANDS[22]; c := #32; end;                    // ~I
        if c = #34 then
          begin command := COMMANDS[2]; c := #32; end;                     // ~G
        if c = #38 then
          begin command := COMMANDS[4]; c := #32; end;                     // ~L
        if c = #25 then
          begin command := COMMANDS[5]; c := #32; end;                     // ~P
        if c = #19 then
          begin command := COMMANDS[6]; c := #32; end;                     // ~R
        if c = #20 then
          begin command := COMMANDS[7]; c := #32; end;                     // ~T
        if c = #31 then
          begin command := COMMANDS[8]; c := #32; end;                     // ~S
        if c = #17 then
          begin command := COMMANDS[11]; c := #32; end;                    // ~W
        // INSERT AND RUN
        if c = #59 then
          begin command := COMMANDS[3]; c:=#13; end;                       // F1
        if c = #60 then
          begin command := COMMANDS[13] + #32 + proj; c:=#13; end;         // F2
        if c = #61 then
          begin command := COMMANDS[14] + #32 + proj; c:=#13; end;         // F3
        if c = #62 then
          begin command := COMMANDS[18] + #32 + proj; c:=#13; end;         // F4
        if c = #63 then
          begin command := COMMANDS[19] + #32 + proj; c:=#13; end;         // F5
        if c = #64 then
          begin command := COMMANDS[33] + #32 + proj; c:=#13; end;         // F6
        if c = #65 then
          begin command := COMMANDS[35]; c:=#13; end;                      // F7
        if c = #66 then
          begin command := COMMANDS[12]; c:=#13; end;                      // F8
        if c = #67 then
          begin command := COMMANDS[38] + #32 + ECHO_ARG[3]; c:=#13; end;  // F9
        if c = #68 then
          begin command := COMMANDS[1]; c:=#13; end;                       // F10
        if c = #72 then
        begin
          if uconfig.histitem > 0 then dec(uconfig.histitem);
          command := uconfig.histbuff[uconfig.histitem];
        end;
        if c = #80 then
        begin
          if uconfig.histitem < 255 then inc(uconfig.histitem);
          command := uconfig.histbuff[uconfig.histitem];
        end;
      end;
      if c = #8 then delete(command, length(command), 1);
      if c = #9 then c := #32;
      if c = #27 then command := '';
      if (c <> #8) and (c <> #13) and (c <> #27) and
         (c <> #72) and (c <> #75) and (c <> #77) and (c <> #80)
      then command := command + c;
      xywrite(1, wherey, true, fullprompt + command);
    until (c = #13);
    if length(command) > 0 then
    begin
      if uconfig.histlast < 255 then
      begin
        uconfig.histbuff[uconfig.histlast] := command;
        inc(uconfig.histlast);
      end else
      begin
        for b := 1 to 255 do
          uconfig.histbuff[b - 1] := uconfig.histbuff[b];
        uconfig.histbuff[uconfig.histlast] := command;
      end;
      uconfig.histitem := uconfig.histlast;
    end;
    writeln;
    parsingcommands(command);
  until command = COMMANDS[1]; // exit
end;

// FULL SCREEN COMMAND LINE
procedure fullscreencommandline;
begin
  window(1, 1, screenwidth, screenheight);
  textbackground(lightgray); textcolor(black); clrscr;
  xywrite(1, 1, true, ' '+PRGNAME + ' v' + PRGVERSION);
  xywrite(screenwidth - length(MSG02), 1, false, MSG02);
  gotoxy(2,screenheight); ewrite(black, red, MSG01);
  window(1, 2, screenwidth, screenheight - 1);
  textbackground(uconfig.colors[1]); textcolor(uconfig.colors[0]); clrscr;
  window(1, 2, screenwidth, screenheight - 1);
  simplecommandline;
  window(1, 1, screenwidth, screenheight);
  textbackground(black); textcolor(lightgray); clrscr;
end;

// SCRIPT INTERPRETER
procedure interpreter(f: string);
var
  line: byte;
  s: string;
  sbuffer: array[0..254] of string;
  sf: textfile;

begin
  if not fileexists(f) then quit(2, false, ERR21 + f + '!');
  for line := 0 to 254 do sbuffer[line] := '';
  assignfile(sf, f);
  try
    reset(sf);
    line := 0;
    repeat
      readln(sf,s);
      if length(s) > 0 then
      begin
        // REMOVE SPACE AND TAB FROM START OF LINE
        while (s[1] = #32) or (s[1] = #9) do
          delete(s, 1, 1);
        if s[1] <> COMMENT then
        begin
          if line < 255 then
          begin
            sbuffer[line] := s;
            inc(line);
          end else quit(4, false, ERR23);
        end;
      end;
    until eof(sf);
    closefile(sf);
  except
    quit(3, false, ERR22 + f + '!');
  end;
  // PARSING SCRIPT
  for line := 0 to 254 do
    if length(sbuffer[line]) > 0 then  parsingcommands(sbuffer[line]);
end;

// - COMMAND LINE PARAMETERS --------------------------------------------------
// SHOW USEABLE PARAMETERS
procedure help(mode: boolean);
var
  b: byte;
begin
  if mode then
    writeln('There are one or more bad parameter in command line.') else
    begin
      writeln('Usage: ' + BASENAME + ' [parameter]');
      writeln;
      writeln('parameters:');
      for b := 0 to 2 do
      begin
        write('  ',CMDLINEPARAMS[b,0]);
        gotoxy(8, wherey); write(CMDLINEPARAMS[b,1]);
        gotoxy(30, wherey); writeln(CMDLINEPARAMS[b,2]);
      end;
      writeln;
    end;
  quit(0, false, '');
end;

// SHOW VERSION AND BUILD INFORMATION
procedure version(h: boolean);
var
  username: string = {$I %USER%};
begin
  writeln(PRGNAME + ' v' + PRGVERSION + ' * ' + MSG02);
  writeln(PRGCOPYRIGHT);
  writeln;
  if length(username) > 0 then username := ' by ' +username;

  writeln('This program was compiled at ', {$I %TIME%}, ' on ', {$I %DATE%}, username, '.');
  writeln('FPC version: ', {$I %FPCVERSION%});
  write('Target OS:   ', {$I %FPCTARGETOS%});
  if lowercase({$I %FPCTARGETOS%}) = 'go32v2' then write(' (DOS)');
  writeln;
  writeln('Target CPU:  ', {$I %FPCTARGETCPU%});
  if h then quit(0, false, '');;
end;

// -- MAIN PROGRAM -------------------------------------------------------------
begin
  // CHECK SIZE OF TERMINAL
  if not terminalsize
    then quit(1, false, 'ERROR: minimal terminal size is 80x25!');
  // DETECT LANGUAGE
  lang := getlang;
  // PARSE COMMAND LINE PARAMETERS
  appmode := 0;
  { appmode #0: simple command line
    appmode #1: show useable parameters
    appmode #2: show version and build information
    appmode #3: full sceen command line
    appmode #4: interpreter mode }
  if length(paramstr(1)) <> 0 then
  begin
    for b := 0 to 3 do
    begin
      if paramstr(1) = CMDLINEPARAMS[b,0] then appmode := b + 1;
      if paramstr(1) = CMDLINEPARAMS[b,1] then appmode := b + 1;
    end;
    case appmode of
      1: help(false);
      2: version(true);
      0: help(true);
    end;
  end;
  loadconfiguration(BASENAME,'.ini');
  translatemessages(LANG,BASENAME,'.mo');
  case appmode of
    0: simplecommandline;
    3: fullscreencommandline;
    4: interpreter(paramstr(2));
  end;
  saveconfiguration(BASENAME,'.ini');
  quit(0, false, '');
end.
