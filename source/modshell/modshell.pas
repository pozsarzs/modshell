{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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
  Classes,
  FileUtil,
  GetText,
  INIFiles,
  convert,
  SysUtils,
  crt,
  dom,
  dos,
  Math,
  Strings,
  ucommon,
  uconfig,
  utranslt,
  xmlread,
  xmlwrite;
{$I type.pas}
{$I const.pas}
{$I var.pas}
{$I define.pas}

{$IFNDEF GO32V2}
  {$R *.res}
{$ENDIF}

{$I resstrng.pas}

function boolisitconstant(s: string): boolean; forward;
function boolisitvariable(s: string): boolean; forward;
function cmd_run(p1, p2: string): byte; forward;
function intisitconstant(s: string): integer; forward;
function intisitvariable(s: string): integer; forward;
function isitconstant(s: string): string; forward;
function isitmessage(s: string): string; forward;
function isitvariable(s: string): string; forward;
procedure clearallconstants; forward;
procedure clearallvariables; forward;
procedure interpreter(f: string); forward;
procedure parsingcommands(command: string); forward;
procedure version(h: boolean); forward;

{$I checklck.pas}
{$I validity.pas}

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
{$I cmd_copy.pas}
{$I cmd_cron.pas}
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
{$I cmd_gw.pas}
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
{$I cmd_paus.pas}
{$I cmd_prnt.pas}
{$I cmd_prop.pas}
{$I cmd_read.pas}
{$I cmd_rst.pas}
{$I cmd_run.pas}
{$I cmd_scfg.pas}
{$I cmd_secn.pas}
{$I cmd_serd.pas}
{$I cmd_set.pas}
{$I cmd_sewr.pas}
{$I cmd_sreg.pas}
{$I cmd_srv.pas}
{$I cmd_sscr.pas}
{$I cmd_str.pas}
{$I cmd_sys.pas}
{$I cmd_var.pas}
{$I cmd_vrmn.pas}
{$I cmd_whvr.pas}
{$I cmd_wrte.pas}

{$I parsing.pas}
{$I fllprmpt.pas}

// SIMPLE COMMAND LINE
procedure simplecommandline;
var
  command: string;
  c: char;
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
    {$IFNDEF X} writeln; {$ENDIF}
    parsingcommands(command);
    varmon_viewer;
  until command = COMMANDS[1]; // exit
end;

// FULL SCREEN COMMAND LINE
procedure fullscreencommandline;
begin
  window(1, 1, termwidth, termheight);
  textbackground(lightgray); textcolor(black); clrscr;
  xywrite(1, 1, true, ' ' + PRGNAME + ' v' + PRGVERSION);
  xywrite((termwidth div 2) - (length(MSG02) div 2), 1, false, MSG02);
  gotoxy(2,termheight); ewrite(black, red, MSG01);
  window(1, 2, termwidth, termheight - 1);
  textbackground(uconfig.colors[1]); textcolor(uconfig.colors[0]); clrscr;
  window(1, 2, termwidth, termheight - 1);
  simplecommandline;
  window(1, 1, termwidth, termheight);
  textbackground(black); textcolor(lightgray); clrscr;
end;

{$I intrprtr.pas}

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

{$I version.pas}

// -- MAIN PROGRAM -------------------------------------------------------------
begin
  // DETECT LANGUAGE
  lang := getlang;
  translatemessages(LANG, BASENAME, '.mo');
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
  loadconfiguration(BASENAME, '.ini');
  setdefaultconstants;
  case appmode of
    0: simplecommandline;
    3: fullscreencommandline;
    4: interpreter(paramstr(2));
  end;
  saveconfiguration(BASENAME, '.ini');
  quit(0, false, '');
end.
