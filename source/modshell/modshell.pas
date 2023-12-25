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
  dos,
  convert,
  crt,
  gettext,
  strings,
  sysutils,
  ucommon,
  uconfig,
  umbascii,
  umbrtu,
  umbtcp,
  utranslt;
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
  // buffer
  coil: array[1..9999] of boolean;
  dinp: array[1..9999] of boolean;
  ireg: array[1..9999] of word;
  hreg: array[1..9999] of word;
  // settings - device, project name, protocol, connection
  dev: array[0..7] of tdevice;
  {$IFDEF GO32V2}
    proj: string[8] = 'default';
  {$ELSE}
    proj: string[16] = 'default';
  {$ENDIF}
  prot: array[0..7] of tprotocol;
  conn: array[0..7] of tconnection;
  // variables
  vars: array[0..63] of tvariable;
  // others
  appmode: byte;
  b: byte;
  lang: string;
const
  BOOLVALUES: array[0..1,0..2] of string =
  (
    ('0','L','FALSE'),
    ('1','H','TRUE')
  );
  // command line parameters
  CMDLINEPARAMS: array[0..3, 0..2] of string =
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information'),
    ('-f','--fullscreen','full screen mode'),
    ('-r','--run','run script')
  );
  // commands and parameters
  COMMANDS: array[0..22] of string = ('copy','exit','get','help','let',
                                      'print','read','reset','set','date',
                                      'ver','write','cls','savecfg',
                                      'loadcfg','expreg','exphis','conv',
                                      'savereg','loadreg','var','color',
                                      'impreg');
  PROMPT = 'MODSH|_>';
  DEV_TYPE: array[0..1] of string = ('net','ser');
  DEV_SPEED: array[0..7] of string = ('1200','2400','4800','9600','19200',
                                      '38400','57600','115200');
  DEV_PARITY: array[0..2] of string = ('e','n','o');
  PROT_TYPE: array[0..2] of string = ('ascii','rtu','tcp');
  REG_TYPE: array[0..3] of string = ('dinp','coil','ireg','hreg');
  PREFIX: array[0..3] of string = ('dev','pro','con','prj');
  // others
  PRGCOPYRIGHT = '(C) 2023 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'ModShell';
  PRGVERSION = '0.1';
  NUM_SYS: array[0..3] of string = ('bin','dec','hex','oct');

  {$DEFINE BASENAME := lowercase(PRGNAME)}
  {$IFDEF UNIX}  
    {$DEFINE SLASH := #47}
  {$ELSE}
    {$DEFINE SLASH := #92}
  {$ENDIF}
  
resourcestring
  // general messages
  MSG01 = '<F1> help  <F2> save cfg  <F3> load cfg  <F4> save reg  <F5> load reg <F8> clear  <F10> exit';
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
  MSG99 = 'Sorry, this feature is not yet implemented.';
  // error messages
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
  // command description
  DES00='       copy one or more register between two connections';
  DES01='F10    exit';
  DES02='ALT-G  show device, protocol, connection or project name';
  DES03='F1     show description or usage of the commands';
  DES04='ALT-L  set value of a buffer registers';
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
  DES15='ALT-E  export value of the one or more buffer registers';
  DES16='       export command line history to make a script easily';
  DES17='       convert value between different numeral systems';
  DES18='F4     save all registers';
  DES19='F5     load all registers';
  DES20='       define new variable and assign value';
  DES21='       set foreground and background color in full screen mode';
  DES22='ALT-I  import value of the one or more buffer registers';
  // command usage
  USG00='copy con? dinp|coil con? coil ADDRESS [COUNT]' + #13 + #10 +
        '  copy con? ireg|hreg con? hreg ADDRESS [COUNT]' + #13 + #10 +
        '  ?: [0-7]';
  USG01='exit';
  USG02='get dev?|pro?|con?|prj' + #13 + #10 + '  ?: [0-7]';
  USG03='help [COMMAND]';
  USG04='let dinp|coil|ireg|hreg ADDRESS VALUE';
  USG05='print dinp|coil|ireg|hreg ADDRESS [COUNT]' + #13 + #10 +
        '  print $VARIABLE' + #13 + #10 +
        '  print "single\ line\ message"';
  USG06='read con? dinp|coil|ireg|hreg ADDRESS [COUNT]' + #13 + #10 + '  ?: [0-7]';
  USG07='reset dev?|pro?|con?|prj' + #13 + #10 + '  ?: [0-7]';
  USG08='set dev? net DEVICE PORT' + #13 + #10 +
        '  set dev? ser DEVICE BAUDRATE DATABIT PARITY STOPBIT' + #13 + #10 +
        '  set pro? ascii|rtu UID' + #13 + #10 +
        '  set pro? tcp IP_ADDRESS' + #13 + #10 +
        '  set con? dev? pro?' + #13 + #10 +
        '  set prj PROJECT_NAME' + #13 + #10 +
        '  ?: [0-7]';
  USG09='date';
  USG10='ver';
  USG11='write con? coil|hreg ADDRESS [COUNT]' + #13 + #10 + '  ?: [0-7]';
  USG12='cls';
  USG13='savecfg PATH_AND_FILENAME';
  USG14='loadcfg PATH_AND_FILENAME';
  USG15='expreg PATH_AND_FILENAME CSV|INI|XML|JSON dinp|coil|ireg|hreg ADDRESS [COUNT]';
  USG16='exphis PATH_AND_FILENAME';
  USG17='conv bin|dec|hex|oct bin|dec|hex|oct VALUE';
  USG18='savereg PATH_AND_FILENAME';
  USG19='loadreg PATH_AND_FILENAME';
  USG20='var NAME [VALUE]';
  USG21='color FOREGROUND BACKGROUND' + #13 + #10 + '  colors: 0-15';
  USG22='impreg PATH_AND_FILENAME';

procedure version(h: boolean); forward;

{$I modbus.pas}
{$I cmd_conv.pas}
{$I cmd_copy.pas}
{$I cmd_date.pas}
{$I cmd_exph.pas}
{$I cmd_expr.pas}
{$I cmd_get.pas}
{$I cmd_help.pas}
{$I cmd_let.pas}
{$I cmd_lcfg.pas}
{$I cmd_lreg.pas}
{$I cmd_prnt.pas}
{$I cmd_read.pas}
{$I cmd_rst.pas}
{$I cmd_scfg.pas}
{$I cmd_sreg.pas}
{$I cmd_set.pas}
{$I cmd_var.pas}
{$I cmd_wrte.pas}

// simple command line
procedure simplecommandline;
var
  a, b: byte;
  c: char;
  command: string;
  o: boolean = false;
  s: string;
  splitted: array[0..7] of string;

// insert project name into prompt
function fullprompt: string;
begin
  result := stringreplace(PROMPT, '_' , proj, [rfReplaceAll]);
end;

begin
  if appmode = 0 then
    writeln(PRGNAME + ' v' + PRGVERSION);
  repeat
    write(fullprompt);
    command := '';
    repeat
      c := readkey;
      // detect hotkeys
      if c = #0 then
      begin
        c := readkey;
        // only insert
        if c = #34 then begin command := COMMANDS[2]; c := #32; end; // ~G
        if c = #38 then begin command := COMMANDS[4]; c := #32; end; // ~L
        if c = #25 then begin command := COMMANDS[5]; c := #32; end; // ~P
        if c = #19 then begin command := COMMANDS[6]; c := #32; end; // ~R
        if c = #20 then begin command := COMMANDS[7]; c := #32; end; // ~T
        if c = #31 then begin command := COMMANDS[8]; c := #32; end; // ~S
        if c = #17 then begin command := COMMANDS[11]; c := #32; end; // ~W
        // insert and run
        if c = #59 then begin command := COMMANDS[3]; c:=#13; end; // F1
        if c = #60 then begin command := COMMANDS[13] + #32 + proj; c:=#13; end; // F2
        if c = #61 then begin command := COMMANDS[14] + #32 + proj; c:=#13; end; // F3
        if c = #62 then begin command := COMMANDS[18] + #32 + proj; c:=#13; end; // F4
        if c = #63 then begin command := COMMANDS[19] + #32 + proj; c:=#13; end; // F5
        if c = #66 then begin command := COMMANDS[12]; c:=#13; end; // F8
        if c = #68 then begin command := COMMANDS[1]; c:=#13; end; // F10
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
    if length(command) > 0 then
    begin
      // remove space and tab from start of line
      while (command[1] = #32) or (command[1] = #9) do
        delete(command, 1, 1);
      // remove space and tab from end of line
      while (command[length(command)] = #32) or (command[length(command)] = #9) do
        delete(command, length(command), 1);
      // remove extra space and tab from line
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
      // split command to eight slices
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
      // parse command
      o := false;
      for b := 0 to 22 do
        if splitted[0] = COMMANDS[b] then
        begin
          o := true;
          break;
        end;
      if not o then writeln(ERR00) else
      begin
        case b of
          0: cmd_copy(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
             // copy conn? di|coil conn? coil ADDRESS COUNT
             // copy conn? ireg|hreg conn? hreg ADDRESS COUNT
          2: cmd_get(splitted[1]);
             // get dev?|prot?|conn?|prj
          3: cmd_help(splitted[1]);
             // help [COMMAND]
          4: cmd_let(splitted[1], splitted[2], splitted[3]);
             // let dinp|coil|ireg|hreg ADDRESS VALUE
          5: cmd_print(splitted[1], splitted[2], splitted[3]);
             // print di|coil|ireg|hreg ADDRESS [COUNT]
          6: cmd_read(splitted[1], splitted[2], splitted[3], splitted[4]);
             // read conn? di|coil|ireg|hreg ADDRESS [COUNT]
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
             // expreg FILENAME di|coil|ireg|hreg ADDRESS [COUNT]
         16: cmd_exphis(splitted[1]);
             // exphis FILENAME
         17: cmd_conv(splitted[1], splitted[2], splitted[3]);
             // conv bin|dec|hex|oct bin|dec|hex|oct VALUE
         18: cmd_savereg(splitted[1]);
             // savereg PATH_AND_FILENAME
         19: cmd_loadreg(splitted[1]);
             // loadreg PATH_AND_FILENAME
         20: cmd_var(splitted[1],splitted[2]);
             // var NAME [VALUE]
        end;
      end;
    end;
  until command = COMMANDS[1]; // exit
end;

// full screen command line
procedure fullscreencommandline;
begin
  window(1, 1, screenwidth, screenheight);
  textbackground(lightgray); textcolor(black); clrscr;
  xywrite(1, 1, true, ' '+PRGNAME + ' v' + PRGVERSION);
  xywrite(screenwidth - length(MSG02), 1, false, MSG02);
  gotoxy(2,screenheight); ewrite(black, red, MSG01);
  window(1, 2, screenwidth, screenheight - 1);
  textbackground(uconfig.backgroundcolor); textcolor(uconfig.foregroundcolor); clrscr;
  window(2, 2, screenwidth - 1, screenheight - 1);
  simplecommandline;
  window(1, 1, screenwidth, screenheight);
  textbackground(black); textcolor(lightgray); clrscr;
end;

// script interpreter
procedure interpreter;
begin
  writeln(MSG99);
end;

// - command line parameters --------------------------------------------------
// show useable parameters
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

// show version and build information
procedure version(h: boolean);
begin
  writeln(PRGNAME + ' v' + PRGVERSION + ' * ' + MSG02);
  writeln(PRGCOPYRIGHT);
  writeln;
  writeln('This program was compiled at ',{$I %TIME%},' on ',{$I %DATE%},
    ' by pozsarzs.');
  writeln('FPC version: ',{$I %FPCVERSION%});
  write('Target OS:   ',{$I %FPCTARGETOS%});
  if lowercase({$I %FPCTARGETOS%}) = 'go32v2' then write(' (DOS)');
  writeln;
  writeln('Target CPU:  ',{$I %FPCTARGETCPU%});
  if h then quit(0, false, '');;
end;

// -- main program -------------------------------------------------------------
begin
  // check size of terminal
  if not terminalsize
    then quit(1, false, 'ERROR: minimal terminal size is 80x25!');
  // detect language
  lang := getlang;
  // parse command line parameters
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
    4: interpreter;
  end;
  saveconfiguration(BASENAME,'.ini');
  quit(0, false, '');
end.
