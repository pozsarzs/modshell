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
  math,
  strings,
  sysutils,
  ucommon,
  uconfig,
  utranslt,
  xmlread,
  xmlwrite;
type
  tdevice = record
    valid: boolean;      // false|true: invalid|valid
    devtype: byte;       // 0..1 -> DEV_TYPE
    device: string[15];  // /dev/ttySx, /dev/ttyUSBx, /dev/ttyAMAx, COMx, etc.
    port: word;          // 0-65535
    speed: byte;         // 0..7 -> DEV_SPEED
    databit: byte;       // 7|8
    parity: byte;        // 0..2 -> DEV_PARITY
    stopbit: byte;       // 1|2
  end;
  tprotocol = record
    valid: boolean;        // false|true: invalid|valid
    prottype: byte;        // 0..2 -> PROT_TYPE
    ipaddress: string[15]; // a.b.c.d
    uid: integer;          // 1..247
  end;
  tconnection = record
    valid: boolean;  // false|true: invalid|valid
    dev: byte;       // 0..7
    prot: byte;      // 0..7
  end;
  tvariable = record
    vname: string[16];    // name
    vvalue: string[255];  // value
    vreadonly: boolean;   // variable or constant
    vmonitored: boolean;   // it is monitored?
  end;
const
  // OTHERS
  PROMPT = 'MODSH|_>';
  PRGCOPYRIGHT = '(C) 2023 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'ModShell';
  PRGVERSION = '0.1';
  SCRBUFFSIZE = 256;
  VARBUFFSIZE = 128;
  COMMARRSIZE = 89;
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
     'beep',  'avg',   'prop',   'concat', 'strdel', 'strfind','strins', 'strrepl', 'varmon');
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
  // Modbus timeout in ms
  DEV_TIMEOUT: integer = 500;
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
  appmode: byte;
  b: byte;
  lang: string;
  varmon: boolean = false;
  // SPLITTED COMMAND LINE
  splitted: array[0..7] of string;

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

{$I resstrng.pas}

function intisitconstant(s: string): integer; forward;
function boolisitconstant(s: string): boolean; forward;
function isitconstant(s: string): string; forward;
function intisitvariable(s: string): integer; forward;
function boolisitvariable(s: string): boolean; forward;
function isitvariable(s: string): string; forward;
procedure interpreter(f: string); forward;
procedure parsingcommands(command: string); forward;
procedure version(h: boolean); forward;

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
{$I cmd_asci.pas}
{$I cmd_avg.pas}
{$I cmd_colr.pas}
{$I cmd_cons.pas}
{$I cmd_conv.pas}
{$I cmd_copy.pas}
{$I cmd_date.pas}
{$I cmd_dump.pas}
{$I cmd_echo.pas}
{$I cmd_exph.pas}
{$I cmd_expr.pas}
{$I cmd_for.pas}
{$I cmd_get.pas}
{$I cmd_goto.pas}
{$I cmd_help.pas}
{$I cmd_if.pas}
{$I cmd_impr.pas}
{$I cmd_labl.pas}
{$I cmd_lcfg.pas}
{$I cmd_let.pas}
{$I cmd_list.pas}
{$I cmd_logc.pas}
{$I cmd_lreg.pas}
{$I cmd_lscr.pas}
{$I cmd_math.pas}
{$I cmd_gw.pas}
{$I cmd_srv.pas}
{$I cmd_paus.pas}
{$I cmd_prop.pas}
{$I cmd_prnt.pas}
{$I cmd_read.pas}
{$I cmd_rst.pas}
{$I cmd_run.pas}
{$I cmd_scfg.pas}
{$I cmd_str.pas}
{$I cmd_secn.pas}
{$I cmd_serd.pas}
{$I cmd_sewr.pas}
{$I cmd_sreg.pas}
{$I cmd_set.pas}
{$I cmd_var.pas}
{$I cmd_vrmn.pas}
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
        for b := 0 to COMMARRSIZE - 1 do
          if splitted[0] = COMMANDS[b] then
          begin
            o := true;
            break;
          end;
        if not o then writeln(ERR00) else
        begin
          case b of
            0: cmd_copy(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               // copy con? dinp|coil con? coil ADDRESS COUNT
               // copy con? ireg|hreg con? hreg ADDRESS COUNT
            2: cmd_get(splitted[1]);
               // get dev?|pro?|con?|prj
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
               // read con? dinp|coil|ireg|hreg ADDRESS [COUNT]
            7: cmd_reset(splitted[1]);
               // reset dev?|pro?|con?|prj
            8: cmd_set(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
               // set dev? ser DEVICE BAUDRATE DATABIT PARITY STOPBIT
               // set dev? net DEVICE PORT
               // set pro? ascii|rtu UID
               // set pro? tcp IP_ADDRESS
               // set con? dev? pro?
               // set prj PROJECT_NAME
            9: cmd_date;
               // date
           10: version(false);
               // ver
           11: cmd_write(splitted[1], splitted[2], splitted[3], splitted[4]);
               // write con? coil|hreg ADDRESS [COUNT]
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
           39: cmd_loadscr(splitted[1]);
               // loadscr PATH_AND_FILENAME
           40: cmd_run(splitted[1]);
               // run [-s]
           66: cmd_const(splitted[1], splitted[2]);
               // const
               // const NAME [VALUE]
           69: cmd_goto(splitted[1]);
               // goto LABEL
           70: cmd_if(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5]);
               // if [$]VALUE1 RELATIONAL_SIGN [$]VALUE2 then COMMAND
           71: cmd_for(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               // for $VARIABLE [$]VALUE1 to [$]VALUE2 do COMMAND  
           72: cmd_label(splitted[1]);
               // label NAME
           73: cmd_mbsrv(splitted[1]);
               // mbsrv con?
           74: cmd_mbgw(splitted[1], splitted[2]);
               // mbgw con? con?
           79: cmd_ascii(splitted[1]);
               // ascii
           80: sysutils.beep;
               // beep
           81: cmd_avg(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               //avg $TARGET [$]VALUE1 [$]VALUE2 [[$]VALUE3...6]
           82: cmd_prop(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               //prop $TARGET [$]MIN [$]MAX [$]ZERO [$]SPAN [$]VALUE
           88: cmd_varmon(splitted[1], splitted[2]);
               // varmon on|off
               // varmon $VARIABLE1 on|off
          else
          begin
            // logical functions
            if (b >= 23) and (b <= 28) then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 58) and (b <= 59) then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if b = 67 then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            // arithmetical functions
            if (b >= 29) and (b <= 32) then cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if (b >= 42) and (b <= 57) then cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 68 then cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 78 then cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            // string handler functions
            if (b >= 60) and (b <= 65) then cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 76) and (b <= 77) then cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 83) and (b <= 87) then cmd_string(b, splitted[1], splitted[2], splitted[3]);
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
        if c = #50 then
          begin command := COMMANDS[88]; c := #32; end;                    // ~M
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
        if c = #133 then
          begin command := COMMANDS[41]; c:=#13; end;                      // F11
        if c = #134 then
          begin command := COMMANDS[40]; c:=#13; end;                      // F12
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
    varmon_viewer;
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
  sf: textfile;

begin
  if not fileexists(f) then quit(2, false, ERR21 + f + '!');
  for line := 0 to SCRBUFFSIZE - 1 do sbuffer[line] := '';
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
          if line <= int(SCRBUFFSIZE - 1) then
          begin
            sbuffer[line] := s;
            if line < int(SCRBUFFSIZE - 1) then inc(line);
          end else quit(4, false, ERR23);
        end;
      end;
    until eof(sf);
    closefile(sf);
  except
    quit(3, false, ERR22 + f + '!');
  end;
  // PARSING SCRIPT
  for line := 0 to SCRBUFFSIZE - 1 do
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
  writeln(MSG94, {$I %DATE%}, ' ', {$I %TIME%});
  if length(username) > 0 then writeln(MSG95, username);
  writeln(MSG96, {$I %FPCVERSION%});
  write(MSG97, {$I %FPCTARGETOS%});
  if lowercase({$I %FPCTARGETOS%}) = 'go32v2' then write(' (DOS)');
  writeln;
  writeln(MSG98, {$I %FPCTARGETCPU%});
  if h then quit(0, false, '');;
end;

// -- MAIN PROGRAM -------------------------------------------------------------
begin
  // DETECT LANGUAGE
  lang := getlang;
  translatemessages(LANG,BASENAME,'.mo');
  // CHECK SIZE OF TERMINAL
  if not terminalsize then quit(1, false, ERR99);
  randomize;
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
  setdefaultconstants;
  case appmode of
    0: simplecommandline;
    3: fullscreencommandline;
    4: interpreter(paramstr(2));
  end;
  saveconfiguration(BASENAME,'.ini');
  quit(0, false, '');
end.

define label (only in script)
