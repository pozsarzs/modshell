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
  {$IFDEF GO32V2} protcom, {$ELSE} synaser, {$ENDIF}
  {$IFDEF WINDOWS} windows, {$ENDIF}
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

{$I type.pas}
{$I const.pas}
{$I var.pas}
{$I define.pas}
{$I resstrng.pas}

function cmd_run(p1: string): byte; forward;
function boolisitconstant(s: string): boolean; forward;
function boolisitvariable(s: string): boolean; forward;
function intisitconstant(s: string): integer; forward;
function intisitvariable(s: string): integer; forward;
function isitconstant(s: string): string; forward;
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
    s := stringreplace(s, #92 + #32 , #32, [rfReplaceAll]);
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
{$I cmd_aplg.pas}
{$I cmd_asci.pas}
{$I cmd_avg.pas}
{$I cmd_colr.pas}
{$I cmd_cons.pas}
{$I cmd_conv.pas}
{$I cmd_cron.pas}
{$I cmd_copy.pas}
{$I cmd_date.pas}
{$I cmd_dump.pas}
{$I cmd_echo.pas}
{$I cmd_edit.pas}
{$I cmd_eras.pas}
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
{$I cmd_sscr.pas}
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
      // SPLIT COMMAND TO 8 SLICES
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
            0: exitcode := cmd_copy(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               // copy con? dinp|coil con? coil ADDRESS COUNT
               // copy con? ireg|hreg con? hreg ADDRESS COUNT
            2: exitcode := cmd_get(splitted[1]);
               // get dev?|pro?|con?|prj
            3: exitcode := cmd_help(splitted[1]);
               // help [COMMAND]
            4: exitcode := cmd_let(splitted[1], splitted[2], splitted[3]);
               // let dinp|coil|ireg|hreg ADDRESS VALUE
               // let $VARIABLE VALUE
               // let $VARIABLE dinp|coil|ireg|hreg ADDRESS
            5: exitcode := cmd_print(splitted[1], splitted[2], splitted[3], splitted[4]);
               // print dinp|coil|ireg|hreg ADDRESS [COUNT] [-n]
               // print $VARIABLE [-n]
               // print "Hello\ world!" [-n]
            6: exitcode := cmd_read(splitted[1], splitted[2], splitted[3], splitted[4]);
               // read con? dinp|coil|ireg|hreg ADDRESS [COUNT]
            7: exitcode := cmd_reset(splitted[1]);
               // reset dev?|pro?|con?|prj
            8: exitcode := cmd_set(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
               // set dev? ser DEVICE BAUDRATE DATABIT PARITY STOPBIT
               // set dev? net DEVICE PORT
               // set pro? ascii|rtu UID
               // set pro? tcp IP_ADDRESS
               // set con? dev? pro?
               // set prj PROJECT_NAME
            9: exitcode := cmd_date;
               // date
           10: begin version(false); exitcode := 0; end;
               // ver
           11: exitcode := cmd_write(splitted[1], splitted[2], splitted[3], splitted[4]);
               // write con? coil|hreg ADDRESS [COUNT]
           12: begin clrscr; exitcode := 0; end;
               // cls
           13: exitcode := cmd_savecfg(splitted[1]);
               // savecfg PATH_AND_FILENAME
           14: exitcode := cmd_loadcfg(splitted[1]);
               // loadcfg PATH_AND_FILENAME
           15: exitcode := cmd_expreg(splitted[1], splitted[2], splitted[3], splitted[4]);
               // expreg FILENAME dinp|coil|ireg|hreg ADDRESS [COUNT]
           16: exitcode := cmd_exphis(splitted[1]);
               // exphis FILENAME
           17: exitcode := cmd_conv(splitted[1], splitted[2], splitted[3]);
               // conv bin|dec|hex|oct bin|dec|hex|oct VALUE
           18: exitcode := cmd_savereg(splitted[1]);
               // savereg PATH_AND_FILENAME
           19: exitcode := cmd_loadreg(splitted[1]);
               // loadreg PATH_AND_FILENAME
           20: exitcode := cmd_var(splitted[1], splitted[2]);
               // var
               // var NAME [VALUE]
           21: exitcode := cmd_color(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5]);
               // color FOREGROUND BACKGROUND
           22: exitcode := cmd_impreg(splitted[1]);
               // impreg FILENAME
           33: exitcode := cmd_dump(splitted[1], splitted[2]);
               // dump [dinp|coil|ireg|hreg]
           34: exitcode := cmd_pause(splitted[1]);
               // pause [[$]TIME]
           35: exitcode := cmd_sercons(splitted[1]);
               // sercons [dev?]
           36: exitcode := cmd_serread(splitted[1], splitted[2]);
               // serread dev? [$TARGET]
           37: exitcode := cmd_serwrite(splitted[1], splitted[2]);
               // serwrite dev? "MESSAGE"
               // serwrite dev? $MESSAGE
           38: exitcode := cmd_echo(splitted[1]);
               // echo [off|on|hex|swap]
           39: exitcode := cmd_loadscr(splitted[1]);
               // loadscr [$]PATH_AND_FILENAME
           40: exitcode := cmd_run(splitted[1]);
               // run [-s]
           41: exitcode := cmd_list;
               // list
           66: exitcode := cmd_const(splitted[1], splitted[2]);
               // const
               // const NAME [VALUE]
           69: exitcode := cmd_goto(splitted[1]);
               // goto LABEL
           70: exitcode := cmd_if(splitted[1], splitted[2], splitted[3], splitted[4], command);
               // if [$]VALUE1 RELATIONAL_SIGN [$]VALUE2 then COMMAND
           71: exitcode := cmd_for(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], command);
               // for $VARIABLE [$]VALUE1 to [$]VALUE2 do COMMAND  
           72: exitcode := cmd_label(splitted[1]);
               // label NAME
           73: exitcode := cmd_mbsrv(splitted[1]);
               // mbsrv con?
           74: exitcode := cmd_mbgw(splitted[1], splitted[2]);
               // mbgw con? con?
           79: exitcode := cmd_ascii(splitted[1]);
               // ascii
           80: begin sysutils.beep; exitcode := 0; end;
               // beep
           81: exitcode := cmd_avg(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               //avg $TARGET [$]VALUE1 [$]VALUE2 [[$]VALUE3...6]
           82: exitcode := cmd_prop(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
               //prop $TARGET [$]MIN [$]MAX [$]ZERO [$]SPAN [$]VALUE
           88: exitcode := cmd_varmon(splitted[1], splitted[2]);
               // varmon on|off
               // varmon $VARIABLE1 on|off
           89: exitcode := cmd_applog(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
               // applog [$]LOGFILE [$]TEXT         [$]LEVEL [[$]VALUE1] [[$]VALUE2] [[$]VALUE3] [[$]VALUE4]
               // applog [$]LOGFILE "TEXT $$0 TEXT" [$]LEVEL [[$]VALUE1] [[$]VALUE2] [[$]VALUE3] [[$]VALUE4]
           90: exitcode := cmd_cron(splitted[1], splitted[2], splitted[3]);
               // cron
               // cron rec_num minute hour
               // cron [-r rec_num]
           91: exitcode := cmd_edit(splitted[1]);
               // edit [LINE_NUMBER]
           92: exitcode := cmd_erase;
               // erase
           93: exitcode := cmd_savescr(splitted[1]);
               // savescr [$]PATH_AND_FILENAME
          else
          begin
            // logical functions
            if (b >= 23) and (b <= 28) then exitcode := cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 58) and (b <= 59) then exitcode := cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if b = 67 then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            // arithmetical functions
            if (b >= 29) and (b <= 32) then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if (b >= 42) and (b <= 57) then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 68 then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 78 then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            // string handler functions
            if (b >= 60) and (b <= 65) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 76) and (b <= 77) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 83) and (b <= 87) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
          end;
        end;
        vars[0].vvalue := inttostr(exitcode);
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
      if appmode = 3 then showtime(colors[0], colors[1]);
      scheduler;
      delay(SHOWTIMEDELAY);
    until keypressed;
    repeat
      repeat
        if appmode = 3 then showtime(colors[0], colors[1]);
        delay(SHOWTIMEDELAY);
      until keypressed;
      c := readkey;
      // DETECT HOTKEYS
      if c = #0 then
      begin
        repeat
          if appmode = 3 then showtime(colors[0], colors[1]);
          delay(SHOWTIMEDELAY);
      until keypressed;
        c := readkey;
        // ONLY INSERT
        if c = #34 then
          begin command := COMMANDS[17]; c := #32; end;                    // ALT-C
        if c = #34 then
          begin command := COMMANDS[15]; c := #32; end;                    // ALT-E
        if c = #34 then
          begin command := COMMANDS[22]; c := #32; end;                    // ALT-I
        if c = #34 then
          begin command := COMMANDS[2]; c := #32; end;                     // ALT-G
        if c = #38 then
          begin command := COMMANDS[4]; c := #32; end;                     // ALT-L
        if c = #50 then
          begin command := COMMANDS[88]; c := #32; end;                    // ALT-M
        if c = #25 then
          begin command := COMMANDS[5]; c := #32; end;                     // ALT-P
        if c = #19 then
          begin command := COMMANDS[6]; c := #32; end;                     // ALT-R
        if c = #20 then
          begin command := COMMANDS[7]; c := #32; end;                     // ALT-T
        if c = #31 then
          begin command := COMMANDS[8]; c := #32; end;                     // ALT-S
        if c = #17 then
          begin command := COMMANDS[11]; c := #32; end;                    // ALT-W
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
        if c = #72 then                                                    // UP
          if uconfig.histitem > 0 then
          begin
            command := uconfig.histbuff[uconfig.histitem];
            dec(uconfig.histitem);
          end;
        if c = #80 then                                                    // DOWN
          if (uconfig.histitem < 255) and (length(uconfig.histbuff[uconfig.histitem + 1]) > 0) then
          begin
            inc(uconfig.histitem);
            command := uconfig.histbuff[uconfig.histitem];
          end;
      end;
      if c = #8 then delete(command, length(command), 1);                  // BACKSPACE
      if c = #9 then c := #32;                                             // TAB
      if c = #27 then command := '';                                       // ESC
      if (c <> #8) and (c <> #13) and (c <> #27) and
         (c <> #72) and (c <> #75) and (c <> #77) and (c <> #80)
      then command := command + c;
      xywrite(1, wherey, true, fullprompt + command);
    until (c = #13);                                                       // ENTER
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
  window(1, 1, termwidth, termheight);
  textbackground(lightgray); textcolor(black); clrscr;
  xywrite(1, 1, true, ' '+PRGNAME + ' v' + PRGVERSION);
  xywrite((termwidth div 2) - (length(MSG02) div 2), 1, false, MSG02);
  gotoxy(2,termheight); ewrite(black, red, MSG01);
  window(1, 2, termwidth, termheight - 1);
  textbackground(uconfig.colors[1]); textcolor(uconfig.colors[0]); clrscr;
  window(1, 2, termwidth, termheight - 1);
  simplecommandline;
  window(1, 1, termwidth, termheight);
  textbackground(black); textcolor(lightgray); clrscr;
end;

// SCRIPT INTERPRETER
procedure interpreter(f: string);
var
  s: string;
  sf: textfile;

begin
  if not fileexists(f) then quit(2, false, ERR21 + f + '!');
  for scriptline := 0 to SCRBUFFSIZE - 1 do sbuffer[scriptline] := '';
  assignfile(sf, f);
  try
    reset(sf);
    scriptline := 0;
    repeat
      readln(sf,s);
      if length(s) > 0 then
      begin
        // REMOVE SPACE AND TAB FROM START OF LINE
        while (s[1] = #32) or (s[1] = #9) do
          delete(s, 1, 1);
        if s[1] <> COMMENT then
        begin
          if scriptline <= int(SCRBUFFSIZE - 1) then
          begin
            sbuffer[scriptline] := s;
            if scriptline < int(SCRBUFFSIZE - 1) then inc(scriptline);
          end else quit(4, false, ERR23);
        end;
      end;
    until eof(sf);
    closefile(sf);
  except
    quit(3, false, ERR22 + f + '!');
  end;
  // PARSING SCRIPT
  scriptline := 0;
  repeat
    if length(sbuffer[scriptline]) > 0 then parsingcommands(sbuffer[scriptline]);
    // execute goto command
    if scriptlabel = 0 then inc(scriptline) else
    begin
      scriptline := scriptlabel;
      scriptlabel := 0;
    end;
  until (scriptline = SCRBUFFSIZE - 1) or (sbuffer[scriptline] = COMMANDS[1]);
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
  if not terminalsize(MINTERMX, MINTERMY) then quit(1, false, ERR99);
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
