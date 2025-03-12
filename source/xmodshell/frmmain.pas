{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

{$DEFINE X}
{$MODE OBJFPC} {$H+} {$MACRO ON}

unit frmmain;
interface
uses
  {$IFDEF UNIX} Ports, {$ENDIF}
  {$IFDEF WINDOWS} Windows, {$ENDIF}
  BlckSock,
  Classes,
  ColorBox,
  ComCtrls,
  Controls,
  Dialogs,
  Dom,
  ExtCtrls,
  Forms,
  GetText,
  Graphics,
  HelpIntfs,
  INIFiles,
  LazHelpCHM,
  LazHelpIntf,
  LCLType,
  Math,
  Menus,
  MODSynHighlighterAny,
  Process,
  Spin,
  StdCtrls,
  Synaser,
  SynEdit,
  SysUtils,
  XMLRead,
  XMLWrite,
  convert,
  crt,
  dos,
  frmmbmn,
  frmregtable,
  frmsecn,
  frmtccn,
  frmudcn,
  frmvrmn,
  ucommon,
  uconfig;
type
  { TLThread }
  TLThread = class(TThread)
  private
    fStatusText: string;
    procedure ShowStatus;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: boolean);
    function thr_serread(p1, p2: string; no_timeout_error: boolean): byte;
    function thr_serwrite(p1, p2: string): byte;
    function thr_tcpread(p1, p2: string; no_timeout_error: boolean): byte;
    function thr_tcpwrite(p1, p2: string): byte;
    function thr_udpread(p1, p2: string; no_timeout_error: boolean): byte;
    function thr_udpwrite(p1, p2: string): byte;
  end;
  { TForm1 }
  TForm1 = class(TForm)
    CHMHelpDatabase1: TCHMHelpDatabase;
    LHelpConnector1: TLHelpConnector;
    ComboBox1: TComboBox;
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
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem70: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    MenuItem73: TMenuItem;
    MenuItem74: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem79: TMenuItem;
    MenuItem80: TMenuItem;
    Separator13: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    Separator10: TMenuItem;
    Separator11: TMenuItem;
    Separator12: TMenuItem;
    Separator14: TMenuItem;
    Separator15: TMenuItem;
    Separator16: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator5: TMenuItem;
    Separator6: TMenuItem;
    Separator7: TMenuItem;
    Separator8: TMenuItem;
    Separator9: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    Label1: TLabel;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure ComboBox1EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
    procedure MenuItem46Click(Sender: TObject);
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
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem67Click(Sender: TObject);
    procedure MenuItem68Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem70Click(Sender: TObject);
    procedure MenuItem71Click(Sender: TObject);
    procedure MenuItem72Click(Sender: TObject);
    procedure MenuItem73Click(Sender: TObject);
    procedure MenuItem74Click(Sender: TObject);
    procedure MenuItem75Click(Sender: TObject);
    procedure MenuItem76Click(Sender: TObject);
    procedure MenuItem77Click(Sender: TObject);
    procedure MenuItem78Click(Sender: TObject);
    procedure MenuItem79Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure LComboBox391Change(Sender: TObject);
    procedure LEdit261Change(Sender: TObject);
    procedure LEdit263Change(Sender: TObject);
    procedure LSpinEdit391Change(Sender: TObject);
    procedure LSpinEdit401Change(Sender: TObject);
    procedure LSpinEdit411Change(Sender: TObject);
    procedure MenuItem80Click(Sender: TObject);
    procedure MenuItem81Click(Sender: TObject);
  private
  public
  end;
  tthrdcmd = record
    c: byte;
    p1, p2, p3, p4: string;
  end;
var
  Form1: TForm1;
  LSynAnySyn1: TSynAnySyn;
  fp: string;
  thrdcmd: tthrdcmd;

{$I type.pas}
{$I const.pas}
{$I var.pas}
{$I define.pas}
{$I resstrng.pas}

implementation

{$R *.lfm}

function boolisitconstantarray(s: string): boolean; forward;
function boolisitconstant(s: string): boolean; forward;
function boolisitvariablearray(s: string): boolean; forward;
function boolisitvariable(s: string): boolean; forward;
function boolvalidconstantarraycell(s: string): boolean; forward;
function boolvalidvariablearraycell(s: string): boolean; forward;
function cmd_set(p1, p2, p3, p4, p5, p6, p7: string): byte; forward;
function cmd_run(p1, p2: string): byte; forward;
function fullprompt: string; forward;
function intisitconstantarrayelement(s: string): integer; forward;
function intisitconstantarray(s: string): integer; forward;
function intisitconstant(s: string): integer; forward;
function intisitvariablearrayelement(s: string): integer; forward;
function intisitvariablearray(s: string): integer; forward;
function intisitvariable(s: string): integer; forward;
function isitconstantarray(s: string): string; forward;
function isitconstant(s: string): string; forward;
function isitmessage(s: string): string; forward;
function isitvariablearray(s: string): string; forward;
function isitvariable(s: string): string; forward;
function parsingcommands(command: string): byte; forward;
procedure clearallconstants; forward;
procedure clearallvariables; forward;
procedure interpreter(f: string); forward;
procedure version(h: boolean); forward;

{$IFDEF UNIX}
  function ioperm(from: Cardinal; num: Cardinal; turn_on: Integer): Integer;
           cdecl; external 'libc';
{$ENDIF}

{$I lockfile.pas}
{$I validity.pas}
{$I vrbosity.pas}

{$I dll.pas}
{$I io.pas}
{$I gpio.pas}
{$I network.pas}
{$I serport.pas}

{$I dcon.pas}
{$I hart.pas}
{$I mbascii.pas}
{$I mbrtu.pas}
{$I mbtcp.pas}
{$I mbutil.pas}
{$I modbus.pas}

{$I cmd_aplg.pas}
{$I cmd_arr.pas}
{$I cmd_asci.pas}
{$I cmd_avg.pas}
{$I cmd_carr.pas}
{$I cmd_cons.pas}
{$I cmd_conv.pas}
{$I cmd_copy.pas}
{$I cmd_cron.pas}
{$I cmd_date.pas}
{$I cmd_dcon.pas}
{$I cmd_dttp.pas}
{$I cmd_dump.pas}
{$I cmd_edit.pas}
{$I cmd_ehmt.pas}
{$I cmd_eras.pas}
{$I cmd_exph.pas}
{$I cmd_expr.pas}
{$I cmd_for.pas}
{$I cmd_get.pas}
{$I cmd_goto.pas}
{$I cmd_gpio.pas}
{$I cmd_gw.pas}
{$I cmd_hart.pas}
{$I cmd_help.pas}
{$I cmd_if.pas}
{$I cmd_impr.pas}
{$I cmd_inmt.pas}
{$I cmd_inpt.pas}
{$I cmd_io.pas}
{$I cmd_labl.pas}
{$I cmd_lcfg.pas}
{$I cmd_let.pas}
{$I cmd_list.pas}
{$I cmd_lock.pas}
{$I cmd_logc.pas}
{$I cmd_lreg.pas}
{$I cmd_lscr.pas}
{$I cmd_math.pas}
{$I cmd_mbcv.pas}
{$I cmd_mbmn.pas}
{$I cmd_mcro.pas}
{$I cmd_paus.pas}
{$I cmd_pclr.pas}
{$I cmd_pipe.pas}
{$I cmd_prnt.pas}
{$I cmd_prop.pas}
{$I cmd_read.pas}
{$I cmd_rnmt.pas}
{$I cmd_rst.pas}
{$I cmd_run.pas}
{$I cmd_scfg.pas}
{$I cmd_sdmt.pas}
{$I cmd_secn.pas}
{$I cmd_serd.pas}
{$I cmd_set.pas}
{$I cmd_sewr.pas}
{$I cmd_sreg.pas}
{$I cmd_srv.pas}
{$I cmd_sscr.pas}
{$I cmd_stck.pas}
{$I cmd_str.pas}
{$I cmd_sys.pas}
{$I cmd_tccn.pas}
{$I cmd_tcrd.pas}
{$I cmd_tcwr.pas}
{$I cmd_udcn.pas}
{$I cmd_udrd.pas}
{$I cmd_udwr.pas}
{$I cmd_var.pas}
{$I cmd_varr.pas}
{$I cmd_vrmn.pas}
{$I cmd_whvr.pas}
{$I cmd_wrte.pas}

{$I thr_serd.pas}
{$I thr_sewr.pas}
{$I thr_tcrd.pas}
{$I thr_tcwr.pas}
{$I thr_udrd.pas}
{$I thr_udwr.pas}

{$I parsing.pas}
{$I fllprmpt.pas}
{$I intrprtr.pas}
{$I version.pas}

// REMOVE AMPERSAND AND DOT SIGNS
function rmampdot(s: string): string;
var
  b: byte;
  t: string = '';
begin
  for b := 1 to 255 do
    if (s[b] <> '&') and (s[b] <> '.') then t := t + s[b];
  result := t;
end;

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form1.Memo1.Text := Form1.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
  with thrdcmd do
    fStatusText := fullprompt + COMMANDS[c] + ' ' + p1 + ' ' + p2 + EOL;
  Synchronize(@Showstatus);
  with thrdcmd do
    case c of
      36: exitcode := thr_serread(p1, p2, false);
      37: exitcode := thr_serwrite(p1, p2);
      113: exitcode := thr_tcpread(p1, p2, false);
      114: exitcode := thr_tcpwrite(p1, p2);
      115: exitcode := thr_udpread(p1, p2, false);
      116: exitcode := thr_udpwrite(p1, p2);
    end;
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;

{ TForm1 }

// -- MAIN MENU/File -----------------------------------------------------------

// SET COLORS
{$I ifile-set_console_colors.pas}

// RESTART APPLICATION
procedure TForm1.MenuItem53Click(Sender: TObject);
var
  LProcess531 : TProcess;
begin
  LProcess531 := TProcess.Create(nil);
  with LProcess531 do
  begin
    Executable := Application.ExeName;
    Execute;
    Free;
  end;
  Application.Terminate;
end;

// RUN COMMAND 'exit'
procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  Form1.Close;
end;

// -- MAIN MENU/Project --------------------------------------------------------

// RUN COMMAND 'loadcfg' WITH TOpenDialog
procedure TForm1.MenuItem37Click(Sender: TObject);
var
  LOpenDialog371: TOpenDialog;
  cmd: string;
begin
  LOpenDialog371 := TOpenDialog.Create(Self);
  with LOpenDialog371 do
  begin
    DefaultExt := '';
    Filter := MSG42;
    FilterIndex := 0;
    InitialDir := vars[13].vvalue;
    Title := rmampdot(MenuItem37.Caption);
    if Execute then
    begin
      cmd := COMMANDS[14] + ' ' + FileName;
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
    end;
    Free;
  end;
end;

// RUN COMMAND 'savecfg' WITH TSaveDialog
procedure TForm1.MenuItem36Click(Sender: TObject);
var
  LSaveDialog361: TSaveDialog;
  cmd: string;
  exists: boolean = false;
  fp, fn, fx, fpn: string;
begin
  LSaveDialog361 := TSaveDialog.Create(Self);
  with LSaveDialog361 do
  begin
    DefaultExt := '';
    Filter := MSG42;
    FilterIndex := 0;
    InitialDir := vars[13].vvalue;
    Title := rmampdot(MenuItem36.Caption);
    if Execute then
    begin
      fp := extractfilepath(FileName);
      fn := extractfilename(FileName);
      fx := extractfileext(FileName);
      if length(fp) = 0 then fp := fp + SLASH;
      for b := 0 to 2 do
      begin
        fn := stringreplace(fn, fx , '', [rfReplaceAll]);
        fpn := fp + fn + '.' + PREFIX[b][1] + 'dt';
        if fileexists(fpn) then exists := true;
      end;
      if exists then
        if Application.MessageBox(PChar(MSG14), 
                                  PChar(rmampdot(MenuItem36.Caption)),
                                  MB_ICONQUESTION + MB_YESNO) = IDNO then
        begin
          Free;
          exit;
        end;
      cmd := COMMANDS[13] + ' ' + fp + fn;
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
    end;
    Free;
  end;
end;

// RUN COMMAND 'set project ...' WITH InputBox
procedure TForm1.MenuItem38Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := InputBox(rmampdot(MenuItem38.Caption), MSG71, vars[12].vvalue);
  if length(cmd) = 0 then showmessage(ERR57) else
  begin
    cmd := COMMANDS[8] + ' project ' + cmd;
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
end;

// RUN COMMAND 'reset project'
procedure TForm1.MenuItem42Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[7] + ' project';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
  Form1.Caption := 'X' + PRGNAME + ' | ' + vars[12].vvalue;
  Label1.Caption := fullprompt;
end;

// RUN COMMAND 'get project'
procedure TForm1.MenuItem46Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[2] + ' project';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'set dev? ...' WITH DIALOG
{$I iproject-devices-set_devices.pas}

// RUN COMMAND 'reset dev? ...' WITH DIALOG
{$I iproject-devices-reset_devices.pas}

// RUN COMMAND 'get dev? ...'
procedure TForm1.MenuItem47Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' dev';
  Memo1.Lines.Add(fullprompt + cmd + SVR);
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set pro? ...' WITH DIALOG
{$I iproject-protocols-set_protocols.pas}

// RUN COMMAND 'reset pro? ...' WITH DIALOG
{$I iproject-protocols-reset_protocols.pas}

// RUN COMMAND 'get pro? ...'
procedure TForm1.MenuItem48Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' pro';
  Memo1.Lines.Add(fullprompt + cmd + SVR);
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set con? ...' WITH DIALOG
{$I iproject-connections-set_connections.pas}

// RUN COMMAND 'reset con? ...' WITH DIALOG
{$I iproject-connections-reset_connections.pas}

// RUN COMMAND 'get con? ...'
procedure TForm1.MenuItem49Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' con';
  Memo1.Lines.Add(fullprompt + cmd + SVR);
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set timeout'
{$I iproject-timeout-set_timeout.pas}

// RUN COMMAND 'get timeout'
procedure TForm1.MenuItem63Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[2] + ' timeout';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// -- MAIN MENU/Modbus ---------------------------------------------------------

// RUN 'readreg con? dinp' COMMAND WITH DIALOG
{$I imodbus-read_discrete_input.pas}

// RUN 'readreg con? coil' COMMAND WITH DIALOG
{$I imodbus-read_coil.pas}

// RUN 'writereg con? coil' COMMAND WITH DIALOG
{$I imodbus-write_coil.pas}

// RUN 'readreg con? ireg' COMMAND WITH DIALOG
{$I imodbus-read_input_register.pas}

// RUN 'readreg con? hreg' COMMAND WITH DIALOG
{$I imodbus-read_holding_register.pas}

// RUN 'writereg con? hreg' COMMAND WITH DIALOG
{$I imodbus-write_holding_register.pas}

// RUN 'mbmon' COMMAND WITH DIALOG
{$I imodbus-show_serial_modbus_traffic.pas}

// -- MAIN MENU/Registers ------------------------------------------------------

// RUN COMMAND 'loadreg' WITH TOpenDialog
procedure TForm1.MenuItem13Click(Sender: TObject);
var
  LOpenDialog131: TOpenDialog;
  cmd: string;
begin
  LOpenDialog131 := TOpenDialog.Create(Self);
  with LOpenDialog131 do
  begin
    Title := rmampdot(MenuItem13.Caption);
    InitialDir := vars[13].vvalue;
    Filter := MSG42;
    DefaultExt := '';
    FilterIndex := 0;
    if Execute then
    begin
      cmd := COMMANDS[19] + ' ' + FileName;
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
    end;
    Free;
  end;
end;

// RUN COMMAND 'savereg' WITH TSaveDialog
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  LSaveDialog1: TSaveDialog;
  cmd: string;
  exists: boolean = false;
  fp,fn,fx, fpn: string;
begin
  LSaveDialog1 := TSaveDialog.Create(Self);
  with LSaveDialog1 do
  begin
    Title := rmampdot(MenuItem14.Caption);
    InitialDir := vars[13].vvalue;
    Filter := MSG42;
    DefaultExt := '';
    FilterIndex := 0;
  end;
  if LSaveDialog1.Execute then
  begin
    fp := extractfilepath(LSaveDialog1.FileName);
    fn := extractfilename(LSaveDialog1.FileName);
    fx := extractfileext(LSaveDialog1.FileName);
    if length(fp) = 0 then fp := fp + SLASH;
    fn := stringreplace(fn, fx , '', [rfReplaceAll]);
    fpn := fp + fn + '.' + PREFIX[b][1] + 'bdt';
    if fileexists(fpn) then exists := true;
    fpn := fp + fn + '.' + PREFIX[b][1] + 'wdt';
    if fileexists(fpn) then exists := true;
    if exists then
      if Application.MessageBox(PChar(MSG14),
                                PChar(rmampdot(MenuItem14.Caption)),
                                MB_ICONQUESTION + MB_YESNO) = IDNO then
      begin
        LSaveDialog1.Free;
        exit;
      end;
    cmd := COMMANDS[18] + ' ' + fp + fn;
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  LSaveDialog1.Free;
end;

// RUN COMMAND 'impreg' WITH TOpenDialog
procedure TForm1.MenuItem32Click(Sender: TObject);
var
  LOpenDialog1: TOpenDialog;
  cmd: string;
begin
  LOpenDialog1 := TOpenDialog.Create(Self);
  with LOpenDialog1 do
  begin
    Title := rmampdot(MenuItem32.Caption);
    InitialDir := vars[13].vvalue;
    Filter := MSG58;
    DefaultExt := 'xml';
    FilterIndex := 2;
  end;
  if LOpenDialog1.Execute then
  begin
    cmd := COMMANDS[22] + ' ' + LOpenDialog1.FileName;
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  LOpenDialog1.Free;
end;

// RUN COMMAND 'expreg' WITH TSaveDialog
{$I iregisters-export_registers.pas}

// RUN COMMAND 'dump' WITH DIALOG
{$I iregisters-dump_registers.pas}

// SHOW REGISTER TABLE
procedure TForm1.MenuItem80Click(Sender: TObject);
begin
  with Form7 do
  begin
    Caption := rmampdot(MenuItem80.Caption);
    ComboBox1.Clear;
    ComboBox1.Items.Add(MSG109);
    ComboBox1.Items.Add(MSG110);
    ComboBox1.Items.Add(MSG111);
    ComboBox1.Items.Add(MSG112);
    ComboBox1.ItemIndex := 0;
    frmregtable.previi := ComboBox1.ItemIndex;
    ShowModal;
  end;
end;

// -- MAIN MENU/Script ---------------------------------------------------------

// RUN COMMAND 'loadscr' WITH TOpenDialog
procedure TForm1.MenuItem10Click(Sender: TObject);
var
  LOpenDialog101: TOpenDialog;
  cmd: string;
begin
  LOpenDialog101 := TOpenDialog.Create(Self);
  with LOpenDialog101 do
  begin
    Title := rmampdot(MenuItem10.Caption);
    InitialDir := vars[13].vvalue;
    {$IFDEF WINDOWS}
      Filter := MSG43;
      DefaultExt := 'bat';
    {$ELSE}
      Filter := MSG42;
      DefaultExt := '';
    {$ENDIF}
    FilterIndex := 1;
    if Execute then
    begin
      cmd := COMMANDS[39] + ' ' + FileName;
      Memo1.Lines.Add(fullprompt + cmd);
      StatusBar1.Panels.Items[3].Text := FileName;
      parsingcommands(cmd);
    end;
    Free;
  end;
end;

// RUN COMMAND 'savescr' WITH TSaveDialog
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  LSaveDialog111: TSaveDialog;
  cmd: string;
begin
  LSaveDialog111 := TSaveDialog.Create(Self);
  with LSaveDialog111 do
  begin
    Title := rmampdot(MenuItem11.Caption);
    InitialDir := vars[13].vvalue;
    {$IFDEF WINDOWS}
      Filter := MSG43;
      DefaultExt := 'bat';
    {$ELSE}
      Filter := MSG42;
      DefaultExt := '';
    {$ENDIF}
    FilterIndex := 1;
    if Execute then
    begin
      if FileExists(FileName) then
        if Application.MessageBox(PChar(MSG14),
                                  PChar(rmampdot(MenuItem11.Caption)),
                                  MB_ICONQUESTION + MB_YESNO) = IDNO then
        begin
          Free;
          exit;
        end;
      cmd := COMMANDS[93] + ' ' + FileName;
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
      StatusBar1.Panels.Items[3].Text := FileName;
    end;
    Free;
  end;
end;

// RUN COMMAND 'list'
procedure TForm1.MenuItem18Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[41];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'edit' WITH DIALOG
{$I iscript-edit_script.pas}

// RUN COMMAND 'erasescr'
procedure TForm1.MenuItem29Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[92];
  Memo1.Lines.Add(fullprompt + cmd);
  StatusBar1.Panels.Items[3].Text := '';
  parsingcommands(cmd);
end;

// RUN COMMAND 'run'
procedure TForm1.MenuItem12Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[40];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// -- MAIN MENU/Operation ------------------------------------------------------

// RUN COMMAND 'cls'
procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[12]);
end;

// RUN COMMAND 'input swap'
procedure TForm1.MenuItem76Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[119] + ' swap';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'echo swap'
procedure TForm1.MenuItem28Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[38] + ' swap';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'send swap'
procedure TForm1.MenuItem77Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[120] + ' swap';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'const'
procedure TForm1.MenuItem24Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[66];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'var'
procedure TForm1.MenuItem25Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[20];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'carr'
procedure TForm1.MenuItem19Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[105];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'varr'
procedure TForm1.MenuItem51Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[106];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'macro'
procedure TForm1.MenuItem78Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[121];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// -- MAIN MENU/Utilities ------------------------------------------------------

// RUN COMMAND 'ascii dec'
procedure TForm1.MenuItem59Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[79] + ' dec';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'ascii hex'
procedure TForm1.MenuItem60Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[79] + ' hex';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'date'
procedure TForm1.MenuItem27Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[9];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'conv' with DIALOG
{$I iutilities-number_converter.pas}

// RUN COMMAND 'varmon' with DIALOG
procedure TForm1.MenuItem52Click(Sender: TObject);
begin
  with Form2 do
  begin
    ValueListEditor1.TitleCaptions.Add(MSG79);
    ValueListEditor1.TitleCaptions.Add(MSG80);
    Show;
  end;
  Form1.Show;
end;

// RUN COMMAND 'sercons' with DIALOG
{$I iutilities-mini_serial_console.pas}

// RUN COMMAND 'serread' with DIALOG
{$I iutilities-read_data_from_serial_port.pas}

// RUN COMMAND 'serwrite' with DIALOG
{$I iutilities-write_data_to_serial_port.pas}

// RUN COMMAND 'tcpcons' with DIALOG
{$I iutilities-mini_tcp_console.pas}

// RUN COMMAND 'tcpread' with DIALOG
{$I iutilities-read_data_with_tcp.pas}

// RUN COMMAND 'tcpwrite' with DIALOG
{$I iutilities-write_data_with_tcp.pas}

// RUN COMMAND 'udpcons' with DIALOG
{$I iutilities-mini_udp_console.pas}

// RUN COMMAND 'udpread' with DIALOG
{$I iutilities-read_data_with_udp.pas}

// RUN COMMAND 'udpwrite' with DIALOG
{$I iutilities-write_data_with_udp.pas}

// -- MAIN MENU/Help -----------------------------------------------------------

// SHOW HELP WINDOW
procedure TForm1.MenuItem81Click(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/Home.htm');
end;

// RUN COMMAND 'help'
procedure TForm1.MenuItem6Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[3];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// OPEN ONLINE WIKI
procedure TForm1.MenuItem56Click(Sender: TObject);
var
  LProcess561: TProcess;
begin
  LProcess561 := TProcess.Create(Self);
  with LProcess561 do
  begin
    if length(BROWSER) > 0 then
    begin
      Executable := BROWSER;
      Parameters.Add('https://github.com/pozsarzs/modshell/wiki');
      try
        Execute;
      except
        ShowMessage(ERR38);
      end;
    end;
    Free;
  end;
end;

// OPEN HOMEPAGE
procedure TForm1.MenuItem57Click(Sender: TObject);
var
  LProcess571: TProcess;
begin
  LProcess571 := TProcess.Create(Self);
  with LProcess571 do
  begin
    if length(BROWSER) > 0 then
    begin
      Executable := BROWSER;
      Parameters.Add('https://pozsarzs.github.io/modshell/');
      try
        Execute;
      except
        ShowMessage(ERR38);
      end;
    end;
    Free;
  end;
end;

// OPEN GITHUB PROJECT PAGE
procedure TForm1.MenuItem58Click(Sender: TObject);
var
  LProcess581: TProcess;
begin
  LProcess581 := TProcess.Create(Self);
  with LProcess581 do
  begin
    if length(BROWSER) > 0 then
    begin
      Executable := BROWSER;
      Parameters.Add('https://github.com/pozsarzs/modshell');
      try
        Execute;
      except
        ShowMessage(ERR38);
      end;
    end;
    Free;
  end;
end;

// RUN COMMAND 'ver'
procedure TForm1.MenuItem7Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[10];
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// -- END OF THE MAIN MENU -----------------------------------------------------

// RUN A COMMAND
procedure TForm1.ComboBox1EditingDone(Sender: TObject);
var
  cmd: string;
begin
  cmd := ComboBox1.Text;
  if length(ComboBox1.Text) > 0 then
  begin
    Memo1.Lines.Add(fullprompt + cmd);
    ComboBox1.Items.Add(cmd);
    ComboBox1.Text := '';
    if cmd = COMMANDS[1] then Form1.Close else
    begin
      parsingcommands(cmd);
      varmon_viewer;
    end;
  end;
end;

// BEFORE CLOSE MAIN WINDOW
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: integer;
begin
  // save history
  for i := 0 to 255 do histbuff[i] := '';
  for i := 0 to 255 do
    if ComboBox1.Items.Count - 1 - i >= 0 then
    begin
      histbuff[i] := ComboBox1.Items[ComboBox1.Items.Count - 1 - i];
      histitem := i;
      histlast := i;
    end;
  // save main window size and position
  with Form1 do
  begin
    formpositions[0, 0] := Top;
    formpositions[0, 1] := Left;
    formpositions[0, 2] := Height;
    formpositions[0, 3] := Width;
  end;
  // save variable monitor window size and position
  with Form2 do
  begin
    formpositions[1, 0] := Top;
    formpositions[1, 1] := Left;
    formpositions[1, 2] := Height;
    formpositions[1, 3] := Width;
  end;
  // save mini serial console window size and position
  with Form3 do
  begin
    formpositions[2, 0] := Top;
    formpositions[2, 1] := Left;
    formpositions[2, 2] := Height;
    formpositions[2, 3] := Width;
  end;
  // save mini TCP console window size and position
  with Form4 do
  begin
    formpositions[4, 0] := Top;
    formpositions[4, 1] := Left;
    formpositions[4, 2] := Height;
    formpositions[4, 3] := Width;
  end;
  // save mini UDP console window size and position
  with Form5 do
  begin
    formpositions[5, 0] := Top;
    formpositions[5, 1] := Left;
    formpositions[5, 2] := Height;
    formpositions[5, 3] := Width;
  end;
  // save Modbus traffic monitor window size and position
  with Form6 do
  begin
    formpositions[6, 0] := Top;
    formpositions[6, 1] := Left;
    formpositions[6, 2] := Height;
    formpositions[6, 3] := Width;
  end;
  // save register table window size and position
  with Form7 do
  begin
    formpositions[7, 0] := Top;
    formpositions[7, 1] := Left;
    formpositions[7, 2] := Height;
    formpositions[7, 3] := Width;
  end;
  // save configuration
  uconfig.lastproject := vars[12].vvalue;
  saveconfiguration(BASENAME,'.ini');
  {$IFDEF WINDOWS}
    // unload dlls
    if loaded_inpout32dll then unloadinpout32dll;
  {$ENDIF}
  // restore directory
  setcurrentdir(originaldirectory);
  CanClose := true;
end;

// CLOSE MAIN WINDOW
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

// CREATE MAIN WINDOW
procedure TForm1.FormCreate(Sender: TObject);
var
  b: byte;
  chmfile, chmviewer: string;
begin
  runmethod := 5;
  randomize;
  // detect language
  lang := getlang;
  {$IFDEF WINDOWS}
    // load dlls
    loaded_inpout32dll := loadinpout32dll;
    if not loaded_inpout32dll then ShowMessage(ERR98);
  {$ENDIF}
  loadconfiguration(BASENAME,'.ini');
  // set default constants
  vars[12].vvalue := uconfig.lastproject;
  setdefaultconstants;
  setdefaultmacros;
  vars[11].vvalue := getuserdir;
  if length(vars[12].vvalue) = 0 then vars[12].vvalue := 'default';
  {$IFDEF GO32V2}
    vars[13].vvalue := getexedir + vars[12].vvalue;
  {$ELSE}
    vars[13].vvalue := vars[11].vvalue + PRGNAME + SLASH + vars[12].vvalue;
  {$ENDIF}
  // make, store and set directories
  ForceDirectories(vars[13].vvalue);
  originaldirectory := getcurrentdir;
  setcurrentdir(getuserdir + PRGNAME);
  // restore main window size and position and set title
  with Form1 do
  begin
    Top := formpositions[0, 0];
    Left := formpositions[0, 1];
    if formpositions[0, 2] > 150 then Height := formpositions[0, 2];
    if formpositions[0, 3] > 200 then Width := formpositions[0, 3];
    Caption := 'X' + PRGNAME + ' | ' + vars[12].vvalue;
  end;
  // set textcaptions and hints
  Label1.Caption := fullprompt;
  ToolButton1.Hint := rmampdot(MenuItem37.Caption);
  ToolButton2.Hint := rmampdot(MenuItem36.Caption);
  ToolButton4.Hint := rmampdot(MenuItem15.Caption);
  ToolButton6.Hint := rmampdot(MenuItem10.Caption);
  ToolButton7.Hint := rmampdot(MenuItem18.Caption);
  ToolButton8.Hint := rmampdot(MenuItem12.Caption);
  ToolButton10.Hint := rmampdot(MenuItem22.Caption);
  ToolButton11.Hint := rmampdot(MenuItem28.Caption);
  ToolButton12.Hint := rmampdot(MenuItem24.Caption);
  ToolButton13.Hint := rmampdot(MenuItem25.Caption);
  ToolButton15.Hint := rmampdot(MenuItem26.Caption);
  ToolButton16.Hint := rmampdot(MenuItem52.Caption);
  ToolButton18.Hint := rmampdot(MenuItem6.Caption);
  ToolButton19.Hint := rmampdot(MenuItem19.Caption);
  ToolButton20.Hint := rmampdot(MenuItem51.Caption);
  ToolButton21.Hint := rmampdot(MenuItem78.Caption);
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
  // set statusbar
  StatusBar1.Panels[0].Text := upcase(METHOD[inputmeth]);
  StatusBar1.Panels[1].Text := upcase(METHOD[echometh]);
  StatusBar1.Panels[2].Text := upcase(METHOD[sendmeth]);
  // restore history
  for b := 0 to 255 do
    if length(histbuff[b]) > 0 then ComboBox1.Items.Add(histbuff[b]);
  // set syntax highlightning for the script editor
  LSynAnySyn1 := TSynAnySyn.Create(Form1);
  with LSynAnySyn1 do
  begin
    ActiveDot := False;
    Comments := [csBashStyle];
    CommentAttri.Foreground := clLime;
    for b := 0 to 1 do Constants.Add(DEV_TYPE[b]);
    for b := 0 to 2 do Constants.Add(FILE_TYPE[b]);
    for b := 1 to 3 do Constants.Add(PROT_TYPE[b]);
    for b := 0 to 3 do Constants.Add(REG_TYPE[b]);
    for b := 0 to 4 do Constants.Add(PREFIX[b]);
    for b := 0 to 5 do Constants.Add(METHOD[b]);
    for b := 0 to 3 do Constants.Add(NUM_SYS[b]);
    ConstantAttri.Foreground := clRed;
    DetectPreprocessor := false;
    DollarVariables := false;
    KeyAttri.Foreground := clWhite;
    for b := 0 to COMMARRSIZE - 1 do KeyWords.Add(COMMANDS[b]);
    Markup := False;
    StringAttri.Foreground := clYellow;
    StringAttri.Style := [fsItalic];
    StringDelim := sdDoubleQuote;
    VariableAttri.Foreground := clNone;
  end;
  // set help system
  // search help file
  {$IFDEF UNIX}
    chmfile := filesearch('modshell_' + lang + '.chm',
      './:./help/:/usr/share/modshell/help/:/usr/local/share/modshell/help/');
    if length(chmfile) = 0 then
      chmfile := filesearch('modshell_en.chm',
        './:./help/:/usr/share/modshell/help/:/usr/local/share/modshell/help/');
  {$ELSE}
    chmfile := filesearch('modshell_' + lang + '.chm','.\;.\help\');
    if length(chmfile) = 0 then
      chmfile := filesearch('modshell_en.chm','.\;.\help\');
  {$ENDIF}
  // search LHelp application
  {$IFDEF UNIX}
    chmviewer := filesearch('lhelp', getenvironmentvariable('PATH'));
  {$ELSE}
    chmviewer := filesearch('lhelp.exe', getenvironmentvariable('PATH'));
  {$ENDIF}
  // set help system
  if fileexists(chmfile) and fileexists(chmviewer) then
  begin
    CreateLCLHelpSystem;
    with CHMHelpDatabase1 do
    begin
      Autoregister := true;
      Filename := chmfile;
      KeywordPrefix := 'html'
    end;
    with LHelpConnector1 do
    begin
      Autoregister := true;
      LHelpPath := chmviewer;
    end;
  end else ShowMessage(ERR67);
end;

end.
