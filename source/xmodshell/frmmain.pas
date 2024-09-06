{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmmain.pas                                                              | }
{ | main form                                                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

unit frmmain;
{$mode objfpc}{$H+}{$macro on}
interface
uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  Menus,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  synaser,
  {$IFDEF WINDOWS} windows, {$ENDIF}
  convert,
  crt,
  dom,
  dos,
  gettext,
  inifiles,
  math,
  strings,
  ucommon,
  uconfig,
  utranslt,
  xmlread,
  xmlwrite;
type
  { TForm1 }
  TForm1 = class(TForm)
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    Separator10: TMenuItem;
    Separator11: TMenuItem;
    Separator12: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator6: TMenuItem;
    Separator7: TMenuItem;
    Separator8: TMenuItem;
    Separator9: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

{$I type.pas}
{$I const.pas}
{$I var.pas}
{$I define.pas}
{$I resstrng.pas}

implementation

{$R *.lfm}

function cmd_run(p1: string): byte; forward;
function boolisitconstant(s: string): boolean; forward;
function boolisitvariable(s: string): boolean; forward;
function intisitconstant(s: string): integer; forward;
function intisitvariable(s: string): integer; forward;
function isitconstant(s: string): string; forward;
function isitvariable(s: string): string; forward;
// procedure interpreter(f: string); forward;
procedure parsingcommands(command: string); forward;
// procedure version(h: boolean); forward;

// IF IT IS A MESSAGE, IT RETURNS ITS VALUE
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

{$I parsing.pas}

{ TForm1 }

// -- MAIN MENU/File -----------------------------------------------------------

// RUN command 'exit'
procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[1]);
end;

// -- MAIN MENU/Project --------------------------------------------------------

// RUN COMMAND 'loadcfg' WITH TOpenDialog
procedure TForm1.MenuItem37Click(Sender: TObject);
begin

end;

// RUN COMMAND 'savecfg' WITH TSaveDialog
procedure TForm1.MenuItem36Click(Sender: TObject);
begin

end;

// RUN COMMAND 'set prj ...' WITH InputBox
procedure TForm1.MenuItem38Click(Sender: TObject);
begin

end;

// RUN COMMAND 'reset prj'
procedure TForm1.MenuItem42Click(Sender: TObject);
begin

end;

// RUN COMMAND 'set dev? ...' WITH DIALOG
procedure TForm1.MenuItem39Click(Sender: TObject);
begin

end;

// RUN COMMAND 'reset dev? ...' WITH DIALOG
procedure TForm1.MenuItem43Click(Sender: TObject);
begin

end;

// RUN COMMAND 'get dev? ...'
procedure TForm1.MenuItem47Click(Sender: TObject);
var
  b: byte;
begin
  for b := 0 to 7 do
    parsingcommands(COMMANDS[2] + 'dev' + inttostr(b));
end;
// RUN COMMAND 'set pro? ...' WITH DIALOG
procedure TForm1.MenuItem40Click(Sender: TObject);
begin

end;

// RUN COMMAND 'reset pro? ...' WITH DIALOG
procedure TForm1.MenuItem44Click(Sender: TObject);
begin

end;

// RUN COMMAND 'get pro? ...'
procedure TForm1.MenuItem48Click(Sender: TObject);
var
  b: byte;
begin
  for b := 0 to 7 do
    parsingcommands(COMMANDS[2] + 'pro' + inttostr(b));
end;

// RUN COMMAND 'set con? ...' WITH DIALOG
procedure TForm1.MenuItem41Click(Sender: TObject);
begin

end;

// RUN COMMAND 'reset con? ...' WITH DIALOG
procedure TForm1.MenuItem45Click(Sender: TObject);
begin

end;

// RUN COMMAND 'get con? ...'
procedure TForm1.MenuItem49Click(Sender: TObject);
var
  b: byte;
begin
  for b := 0 to 7 do
    parsingcommands(COMMANDS[2] + 'con' + inttostr(b));
end;

// RUN COMMAND 'color ...' WITH InputBox
procedure TForm1.MenuItem23Click(Sender: TObject);
begin

end;

// -- MAIN MENU/Registers ------------------------------------------------------

// RUN COMMAND 'loadreg' WITH TOpenDialog
procedure TForm1.MenuItem13Click(Sender: TObject);
begin

end;

// RUN COMMAND 'savereg' WITH TSaveDialog
procedure TForm1.MenuItem14Click(Sender: TObject);
begin

end;

// RUN COMMAND 'impreg' WITH TOpenDialog
procedure TForm1.MenuItem32Click(Sender: TObject);
begin

end;

// RUN COMMAND 'expreg' WITH TSaveDialog
procedure TForm1.MenuItem31Click(Sender: TObject);
begin

end;

// RUN COMMAND 'dump' WITH DIALOG
procedure TForm1.MenuItem15Click(Sender: TObject);
begin

end;

// -- MAIN MENU/Script ---------------------------------------------------------

// RUN COMMAND 'loadscr' WITH TOpenDialog
procedure TForm1.MenuItem10Click(Sender: TObject);
begin

end;

// RUN COMMAND 'savescr' WITH TSaveDialog
procedure TForm1.MenuItem11Click(Sender: TObject);
begin

end;

// RUN COMMAND 'list'
procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[41]);
end;

// RUN COMMAND 'edit'
procedure TForm1.MenuItem30Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[91]);
end;

// RUN COMMAND 'erase'
procedure TForm1.MenuItem29Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[92]);
end;

// RUN COMMAND 'run'
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[40]);
end;

// -- MAIN MENU/Operation ------------------------------------------------------

// RUN COMMAND 'cls'
procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[12]);
end;

// RUN COMMAND 'echo'
procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[38]);
end;

// RUN COMMAND 'serread' with DIALOG
procedure TForm1.MenuItem55Click(Sender: TObject);
begin

end;

// RUN COMMAND 'serwrite' with DIALOG
procedure TForm1.MenuItem53Click(Sender: TObject);
begin

end;

// RUN COMMAND 'read' with DIALOG
procedure TForm1.MenuItem51Click(Sender: TObject);
begin

end;

// RUN COMMAND 'write' with DIALOG
procedure TForm1.MenuItem50Click(Sender: TObject);
begin

end;

// RUN COMMAND 'mbgw' with DIALOG
procedure TForm1.MenuItem16Click(Sender: TObject);
begin

end;

// RUN COMMAND 'mbsrv' with DIALOG
procedure TForm1.MenuItem19Click(Sender: TObject);
begin

end;

// RUN COMMAND 'const'
procedure TForm1.MenuItem24Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[66]);
end;

// RUN COMMAND 'var'
procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[20]);
end;

// -- MAIN MENU/Utilities ------------------------------------------------------

// RUN COMMAND 'ascii'
procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[79]);
end;

// RUN COMMAND 'date'
procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[9]);
end;

// RUN COMMAND 'conv' with DIALOG
procedure TForm1.MenuItem26Click(Sender: TObject);
begin

end;

// RUN COMMAND 'sercons' with DIALOG
procedure TForm1.MenuItem54Click(Sender: TObject);
begin

end;

// RUN COMMAND 'varmon' with DIALOG
procedure TForm1.MenuItem52Click(Sender: TObject);
begin

end;

// -- MAIN MENU/Help -----------------------------------------------------------

// RUN COMMAND 'help'
procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[3]);
end;

// OPEN ONLINE WIKI
procedure TForm1.MenuItem56Click(Sender: TObject);
begin

end;

// RUN COMMAND 'ver'
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[10]);
end;

// -- END OF THE MAIN MENU -----------------------------------------------------

// OnCreate event
procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.