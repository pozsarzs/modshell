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
{$MODE OBJFPC}{$H+}{$MACRO ON}
interface
uses
  Classes,
  ColorBox,
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  LCLType,
  Menus,
  MODSynHighlighterAny,
  Process,
  Spin,
  StdCtrls,
  SynEdit,
  SysUtils,
  {$IFDEF WINDOWS} Windows, {$ENDIF}
  convert,
  crt,
  dom,
  dos,
  frmsecn,
  frmvrmn,
  gettext,
  inifiles,
  math,
  synaser,
  ucommon,
  uconfig,
  xmlread,
  xmlwrite;
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
  end;
  { TForm1 }
  TForm1 = class(TForm)
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
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    Separator10: TMenuItem;
    Separator11: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
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
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure LComboBox391Change(Sender: TObject);
    procedure LEdit261Change(Sender: TObject);
    procedure LEdit263Change(Sender: TObject);
    procedure LSpinEdit391Change(Sender: TObject);
    procedure LSpinEdit401Change(Sender: TObject);
    procedure LSpinEdit411Change(Sender: TObject);
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

{$DEFINE X}

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
function cmd_run(p1, p2: string): byte; forward;
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
procedure clearallconstants; forward;
procedure clearallvariables; forward;
procedure interpreter(f: string); forward;
procedure parsingcommands(command: string); forward;
procedure version(h: boolean); forward;

{$I lockfile.pas}
{$I validity.pas}

{$I ethernet.pas}
{$I serport.pas}

{$I dcon.pas}
{$I mbascii.pas}
{$I mbrtu.pas}
{$I mbtcp.pas}
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
{$I cmd_lock.pas}
{$I cmd_logc.pas}
{$I cmd_lreg.pas}
{$I cmd_lscr.pas}
{$I cmd_math.pas}
{$I cmd_paus.pas}
{$I cmd_pclr.pas}
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
{$I cmd_varr.pas}
{$I cmd_vrmn.pas}
{$I cmd_whvr.pas}
{$I cmd_wrte.pas}

{$I thr_serd.pas}
{$I thr_sewr.pas}

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
        if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem36.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
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
    Form1.Caption := 'X' + PRGNAME + ' | ' + vars[12].vvalue;
    Label1.Caption := fullprompt;
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
// set device number
procedure TForm1.LSpinEdit391Change(Sender: TObject);
var
  LComboBox391, LComboBox392, LComboBox393: TComboBox;
  LEdit391, LEdit392: TEdit;
  LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LComboBox391 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox391'));
    LComboBox392 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox392'));
    LComboBox393 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox393'));
    LEdit391 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit391'));
    LEdit392 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit392'));
    LSpinEdit392 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit392'));
    LSpinEdit393 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit393'));
    LSpinEdit394 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit394'));
    if assigned(LComboBox391) and dev[TSpinEdit(Sender).Value].valid
      then LComboBox391.ItemIndex := dev[TSpinEdit(Sender).Value].devtype
      else LComboBox391.ItemIndex := 1;
    LComboBox392.Enabled := inttobool(LComboBox391.ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
    if assigned(LEdit391) and dev[TSpinEdit(Sender).Value].valid
      then LEdit391.Text := dev[TSpinEdit(Sender).Value].device else
      begin
        LEdit391.Clear;
        {$IFDEF GO32V2} LEdit391.Text := 'COM1'; {$ENDIF}
        {$IFDEF LINUX} LEdit391.Text := '/dev/ttyS0'; {$ENDIF}
        {$IFDEF BSD} LEdit391.Text := '/dev/cuau0'; {$ENDIF}
        {$IFDEF WINDOWS} LEdit391.Text := 'COM1'; {$ENDIF}
      end;
    if assigned(LComboBox392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
      then LComboBox392.ItemIndex := dev[TSpinEdit(Sender).Value].speed
      else LComboBox392.ItemIndex := 3;
    if assigned(LSpinEdit392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
       then LSpinEdit392.Value := dev[TSpinEdit(Sender).Value].databit
      else LSpinEdit392.Value := 8;
    if assigned(LComboBox393) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
      then LComboBox393.ItemIndex := dev[TSpinEdit(Sender).Value].parity
      else LComboBox393.ItemIndex := 1;
    if assigned(LSpinEdit393) and dev[TSpinEdit(Sender).Value].valid
      then LSpinEdit393.Value := dev[TSpinEdit(Sender).Value].stopbit
      else LSpinEdit393.Value := 0;
    if assigned(LEdit392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 0)
      then LEdit392.Text := dev[TSpinEdit(Sender).Value].ipaddress
      else LEdit392.Text := '192.168.0.1';
    if assigned(LSpinEdit394) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 0)
      then LSpinEdit394.Value := dev[TSpinEdit(Sender).Value].stopbit
      else LSpinEdit394.Value := 502;
  end;
end;

// change device type
procedure TForm1.LComboBox391Change(Sender: TObject);
var
  LComboBox392, LComboBox393: TComboBox;
  LEdit392: TEdit;
  LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
begin
  if Sender is TCombobox then
  begin
    LComboBox392 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox392'));
    LComboBox393 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox393'));
    LEdit392 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit392'));
    LSpinEdit392 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit392'));
    LSpinEdit393 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit393'));
    LSpinEdit394 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit394'));
    LComboBox392.Enabled := inttobool(TComboBox(Sender).ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
  end;
end;

procedure TForm1.MenuItem39Click(Sender: TObject);
var
  Form391: TForm;
  LBevel391: TBevel;
  LButton391, LButton392: TButton;
  LComboBox391, LComboBox392, LComboBox393: TComboBox;
  LEdit391, LEdit392: TEdit;
  LLabel391, LLabel392, LLabel393, LLabel394, LLabel395, LLabel396, LLabel397, LLabel398: TLabel;
  LSpinEdit391, LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
  cmd: string;
  b: byte;
begin
  Form391 := TForm.Create(Nil);
  LBevel391 := TBevel.Create(Form391);
  LButton391 := TButton.Create(Form391);
  LButton392 := TButton.Create(Form391);
  LComboBox391 := TComboBox.Create(Form391);
  LComboBox392 := TComboBox.Create(Form391);
  LComboBox393 := TComboBox.Create(Form391);
  LEdit391 := TEdit.Create(Form391);
  LEdit392 := TEdit.Create(Form391);
  LLabel391 := TLabel.Create(Form391);
  LLabel392 := TLabel.Create(Form391);
  LLabel393 := TLabel.Create(Form391);
  LLabel394 := TLabel.Create(Form391);
  LLabel395 := TLabel.Create(Form391);
  LLabel396 := TLabel.Create(Form391);
  LLabel397 := TLabel.Create(Form391);
  LLabel398 := TLabel.Create(Form391);
  LSpinEdit391 := TSpinEdit.Create(Form391);
  LSpinEdit392 := TSpinEdit.Create(Form391);
  LSpinEdit393 := TSpinEdit.Create(Form391);
  LSpinEdit394 := TSpinEdit.Create(Form391);
  with Form391 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem39.Caption);
    Name := 'Form391';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel391 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel391';
    Parent := Form391;
  end;
  with LSpinEdit391 do  // device number
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 20;
      AnchorSideLeft.Control := LLabel391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form391;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit391';
    TabOrder := 0;
    OnChange := @LSpinEdit391Change;
  end;
  with LComboBox391 do  // device type
  begin
    AutoSize := true;
    AutoComplete:= true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    for b := 0 to 1 do Items.Add(DEV_TYPE[b]);
    if dev[LSpinEdit391.Value].valid
      then ItemIndex := dev[LSpinEdit391.Value].devtype
      else ItemIndex := 1;
    LComboBox392.Enabled := inttobool(ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
    Name := 'LComboBox391';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 1;
    OnChange := @LComboBox391Change;
  end;
  with LEdit391 do  // device name
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form391;
    TabOrder := 2;
    Name := 'LEdit391';
    if dev[LSpinEdit391.Value].valid
      then Text := dev[LSpinEdit391.Value].device else
      begin
        Clear;
        {$IFDEF GO32V2} Text := 'COM1'; {$ENDIF}
        {$IFDEF LINUX} Text := '/dev/ttyS0'; {$ENDIF}
        {$IFDEF BSD} Text := '/dev/cuau0'; {$ENDIF}
        {$IFDEF WINDOWS} Text := 'COM1'; {$ENDIF}
      end;
    Width := 100;
  end;
  with LComboBox392 do  // baudrate
  begin
    AutoComplete:= true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LEdit391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    for b := 0 to 7 do Items.Add(DEV_SPEED[b]);
    if dev[LSpinEdit391.Value].valid and
       (dev[LSpinEdit391.Value].devtype = 1)
      then ItemIndex := dev[LSpinEdit391.Value].speed
      else ItemIndex := 3;
    Name := 'LComboBox392';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 3;
    Width := 120;
  end;
  with LSpinEdit392 do  // databits
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 7;
    Name := 'LSpinEdit392';
    Parent := Form391;
    MinValue := 7;
    MaxValue := 8;
    if dev[LSpinEdit391.Value].valid and
      (dev[LSpinEdit391.Value].devtype = 1)
      then Value := dev[LSpinEdit391.Value].databit
      else Value := 8;
    TabOrder := 4;
    Width := 60;
  end;
  with LComboBox393 do  // parity
  begin
    AutoComplete:= true;
    AutoSize := true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    for b := 0 to 2 do Items.Add(upcase(DEV_PARITY[b]));
    if dev[LSpinEdit391.Value].valid and
      (dev[LSpinEdit391.Value].devtype = 1)
      then ItemIndex := dev[LSpinEdit391.Value].parity
      else ItemIndex := 1;
    Name := 'LComboBox393';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 5;
  end;
  with LSpinEdit393 do  // stopbits
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox393;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Name := 'LSpinEdit393';
    Parent := Form391;
    MinValue := 1;
    MaxValue := 2;
    if dev[LSpinEdit391.Value].valid and
    (dev[LSpinEdit391.Value].devtype = 1)
      then Value := dev[LSpinEdit391.Value].stopbit
      else Value := 1;
    TabOrder := 6;
  end;
  with LLabel392 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox391;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Parent := Form391;
  end;
  with LLabel393 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit391;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG72;
    Parent := Form391;
  end;
  with LLabel394 do
  begin
    Alignment := taCenter;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG51;
    Parent := Form391;
  end;
  with LLabel395 do
  begin
    Alignment := taCenter;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG52;
    Parent := Form391;
  end;
  with LLabel396 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox393;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
      Caption := MSG53;
    Parent := Form391;
  end;
  with LLabel397 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit393;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG54;
    Parent := Form391;
  end;
  with LLabel398 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form391;
  end;
  with LEdit392 do  // IP-address
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LComboBox392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LComboBox392;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Name := 'LEdit392';
    Parent := Form391;
    TabOrder := 7;
    if dev[LSpinEdit391.Value].valid and
       (dev[LSpinEdit391.Value].devtype = 0)
      then Text := dev[LSpinEdit391.Value].ipaddress
      else Text := '192.168.0.1';
  end;
  with LSpinEdit394 do  // port
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit392;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Name := 'LSpinEdit394';
    Parent := Form391;
    MinValue := 0;
    MaxValue := 65535;
    if dev[LSpinEdit391.Value].valid and
    (dev[LSpinEdit391.Value].devtype = 0)
      then Value := dev[LSpinEdit391.Value].port
      else Value := 502;
    TabOrder := 8;
  end;
  with LBevel391 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form391;
    Shape := bsTopLine;
  end;
  with LButton391 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton392;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form391;
    TabOrder := 10;
  end;
  with LButton392 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form391;
    TabOrder := 9;
  end;
  if Form391.ShowModal = mrOk then
  begin
   with Form391 do
     if LComboBox391.ItemIndex = 0 then
       cmd := COMMANDS[8] + ' dev' + inttostr(LSpinEdit391.Value) + ' ' +
         LComboBox391.Items[LComboBox391.ItemIndex] + ' ' +
         LEdit391.Text + ' ' +
         LEdit392.Text + ' ' +
         inttostr(LSpinEdit394.Value)
     else
       cmd := COMMANDS[8] + ' dev' + inttostr(LSpinEdit391.Value) + ' ' +
         LComboBox391.Items[LComboBox391.ItemIndex] + ' ' +
         LEdit391.Text + ' ' +
         LComboBox392.Items[LComboBox392.ItemIndex] + ' ' +
         inttostr(LSpinEdit392.Value) + ' ' +
         LComboBox393.Items[LComboBox393.ItemIndex] + ' ' +
         inttostr(LSpinEdit393.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form391);
end;

// RUN COMMAND 'reset dev? ...' WITH DIALOG
procedure TForm1.MenuItem43Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel2: TLabel;
  LSpinEdit1: TSpinEdit;
  cmd: string;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem43.Caption);
    Position := poMainFormCenter;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
    Caption := 'dev';
    Parent := Form;
    Font.Style := [fsBold];
    BorderSpacing.Left := 12;
  end;
  with LSpinEdit1 do  // device
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Parent := Form;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form;
    Shape := bsTopLine;
  end;
  with LButton1 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton2;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 2;
  end;
  with LButton2 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    Parent := Form;
    ModalResult := mrOk;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      cmd := COMMANDS[7] + ' dev' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'get dev? ...'
procedure TForm1.MenuItem47Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' dev';
  Memo1.Lines.Add(fullprompt + cmd + '[0-7]');
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set pro? ...' WITH DIALOG
// change protocol number
procedure TForm1.LSpinEdit401Change(Sender: TObject);
var
  LComboBox401: TComboBox;
  LSpinEdit402: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LComboBox401 := TComboBox(TForm(TSpinEdit(Sender).Parent).FindComponent('LComboBox401'));
    LSpinEdit402 := TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit402'));
    if assigned(LComboBox401) and prot[TSpinEdit(Sender).Value].valid
      then LComboBox401.ItemIndex := prot[TSpinEdit(Sender).Value].prottype
      else LComboBox401.ItemIndex := 0;
    if assigned(LSpinEdit402) and prot[TSpinEdit(Sender).Value].valid
      then LSpinEdit402.Value := prot[TSpinEdit(Sender).Value].id
      else LSpinEdit402.Value := 1;
  end;
end;

procedure TForm1.MenuItem40Click(Sender: TObject);
var
  Form401: TForm;
  LBevel401: TBevel;
  LButton401, LButton402: TButton;
  LComboBox401: TComboBox;
  LLabel401, LLabel402, LLabel403, LLabel404: TLabel;
  LSpinEdit401, LSpinEdit402: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form401 := TForm.Create(Nil);
  LBevel401 := TBevel.Create(Form401);
  LButton401 := TButton.Create(Form401);
  LButton402 := TButton.Create(Form401);
  LComboBox401 := TComboBox.Create(Form401);
  LLabel401 := TLabel.Create(Form401);
  LLabel402 := TLabel.Create(Form401);
  LLabel403 := TLabel.Create(Form401);
  LLabel404 := TLabel.Create(Form401);
  LSpinEdit401 := TSpinEdit.Create(Form401);
  LSpinEdit402 := TSpinEdit.Create(Form401);
  with Form401 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem40.Caption);
    Name := 'Form401';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel401 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'pro';
    Font.Style := [fsBold];
    Name := 'LLabel401';
    Parent := Form401;
  end;
  with LSpinEdit401 do  // protocol
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel402;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LLabel401';
    Parent := Form401;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
    OnChange := @LSpinEdit401Change;
  end;
  with LComboBox401 do  // protocol type
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      for b:= 0 to 3 do Items.Add(PROT_TYPE[b]);
    if prot[LSpinEdit401.Value].valid
      then ItemIndex := prot[LSpinEdit401.Value].prottype
      else ItemIndex := 0;
    Name := 'LComboBox401';
    Parent := Form401;
    ReadOnly := true;
    TabOrder := 1;
  end;
  with LSpinEdit402 do  // unit ID or address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 0;
    if LComboBox401.ItemIndex < 3
      then MaxValue := 247
      else MaxValue := 255;
    Name := 'LSpinEdit402';
    if prot[LSpinEdit401.Value].valid
      then Value := prot[LSpinEdit401.Value].id
      else Value := 1;
    Parent := Form401;
    TabOrder := 2;
    Width := 75;
  end;
  with LLabel402 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox401;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Name := 'LLabel402';
    Parent := Form401;
  end;
  with LLabel403 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit402;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG56;
    Name := 'LLabel403';
    Parent := Form401;
  end;
  with LLabel404 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel404';
    Parent := Form401;
  end;
  with LBevel401 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel401';
    Parent := Form401;
    Shape := bsTopLine;
  end;
  with LButton401 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton402;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton401';
    Parent := Form401;
    TabOrder := 4;
  end;
  with LButton402 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton402';
    Parent := Form401;
    TabOrder := 3;
  end;
  if Form401.ShowModal = mrOk then
  begin
    with Form401 do
      cmd := COMMANDS[8] + ' pro' +
        inttostr(LSpinEdit401.Value) + ' ' +
        LComboBox401.Items[LComboBox401.ItemIndex] + ' ' +
        inttostr(LSpinEdit402.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form401);
end;

// RUN COMMAND 'reset pro? ...' WITH DIALOG
procedure TForm1.MenuItem44Click(Sender: TObject);
var
  Form441: TForm;
  LBevel441: TBevel;
  LButton441, LButton442: TButton;
  LLabel441, LLabel442: TLabel;
  LSpinEdit441: TSpinEdit;
  cmd: string;
begin
  Form441 := TForm.Create(Nil);
  LBevel441 := TBevel.Create(Form441);
  LButton441 := TButton.Create(Form441);
  LButton442 := TButton.Create(Form441);
  LLabel441 := TLabel.Create(Form441);
  LLabel442 := TLabel.Create(Form441);
  LSpinEdit441 := TSpinEdit.Create(Form441);
  with Form441 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem44.Caption);
    Name := 'Form441';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel441 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit441;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'pro';
    Font.Style := [fsBold];
    Name := 'LLabel441';
    Parent := Form441;
  end;
  with LSpinEdit441 do  // protocol
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel442;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel441;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit441';
    Parent := Form441;
    TabOrder := 0;
  end;
  with LLabel442 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel442';
    Parent := Form441;
  end;
  with LBevel441 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit441;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel441';
    Parent := Form441;
    Shape := bsTopLine;
  end;
  with LButton441 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton442;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton441';
    Parent := Form441;
    TabOrder := 2;
  end;
  with LButton442 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    ModalResult := mrOk;
    Name := 'LButton442';
    Parent := Form441;
    TabOrder := 1;
  end;
  if Form441.ShowModal = mrOk then
  begin
    with Form441 do
      cmd := COMMANDS[7] +
      ' pro' + inttostr(LSpinEdit441.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form441);
end;

// RUN COMMAND 'get pro? ...'
procedure TForm1.MenuItem48Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' pro';
  Memo1.Lines.Add(fullprompt + cmd + '[0-7]');
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set con? ...' WITH DIALOG
procedure TForm1.LSpinEdit411Change(Sender: TObject);
var
  LSpinEdit412, LSpinEdit413: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LSpinEdit412 := TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit412'));
    LSpinEdit413 := TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit413'));
    if assigned(LSpinEdit412) and conn[TSpinEdit(Sender).Value].valid
      then LSpinEdit412.Value := conn[TSpinEdit(Sender).Value].dev
      else LSpinEdit412.Value := 0;
    if assigned(LSpinEdit413) and conn[TSpinEdit(Sender).Value].valid
      then LSpinEdit413.Value := conn[TSpinEdit(Sender).Value].prot
      else LSpinEdit413.Value := 0;
  end;
end;

procedure TForm1.MenuItem41Click(Sender: TObject);
var
  Form411: TForm;
  LBevel411: TBevel;
  LButton411, LButton412: TButton;
  LLabel411, LLabel412, LLabel413, LLabel414, LLabel415, LLabel416: TLabel;
  LSpinEdit411, LSpinEdit412, LSpinEdit413: TSpinEdit;
  cmd: string;
begin
  Form411 := TForm.Create(Nil);
  LBevel411 := TBevel.Create(Form411);
  LButton411 := TButton.Create(Form411);
  LButton412 := TButton.Create(Form411);
  LLabel411 := TLabel.Create(Form411);
  LLabel412 := TLabel.Create(Form411);
  LLabel413 := TLabel.Create(Form411);
  LLabel414 := TLabel.Create(Form411);
  LLabel415 := TLabel.Create(Form411);
  LLabel416 := TLabel.Create(Form411);
  LSpinEdit411 := TSpinEdit.Create(Form411);
  LSpinEdit412 := TSpinEdit.Create(Form411);
  LSpinEdit413 := TSpinEdit.Create(Form411);
  with Form411 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem41.Caption);
    Name := 'Form411';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel411 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel411';
    Parent := Form411;
  end;
  with LSpinEdit411 do  // connection
  begin
    Anchors := [akTop, akLeft];
    AnchorSideTop.Control := LLabel414;
    AnchorSideTop.Side := asrBottom;
    BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel411;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit411';
    Parent := Form411;
    TabOrder := 0;
    Value := 0;
    OnChange := @LSpinEdit411Change;
  end;
  with LLabel412 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit411;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'dev';
    Name := 'LLabel412';
    Parent := Form411;
  end;
  with LSpinEdit412 do  // device
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel412;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit412';
    Parent := Form411;
    TabOrder := 1;
    if conn[LSpinEdit411.Value].valid
      then Value := conn[LSpinEdit411.Value].dev
      else Value := 0;
  end;
  with LLabel413 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit412;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'pro';
    Name := 'LLabel413';
    Parent := Form411;
  end;
  with LSpinEdit413 do  // protocol
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel413;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit413';
    Parent := Form411;
    TabOrder := 2;
    if conn[LSpinEdit411.Value].valid
      then Value := conn[LSpinEdit411.Value].prot
      else Value := 0;
  end;
  with LLabel414 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel414';
    Parent := Form411;
  end;
  with LLabel415 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel412;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit412;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel415';
    Parent := Form411;
  end;
  with LLabel416 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel413;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit413;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel416';
    Parent := Form411;
  end;
  with LBevel411 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form411;
    Name := 'LBevel411';
    Shape := bsTopLine;
  end;
  with LButton411 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton412;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton411';
    Parent := Form411;
    TabOrder := 4;
  end;
  with LButton412 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton412';
    Parent := Form411;
    TabOrder := 3;
  end;
  if Form411.ShowModal = mrOk then
  begin
    with Form411 do
      cmd := COMMANDS[8] +
      ' con' + inttostr(LSpinEdit411.Value) +
      ' dev' + inttostr(LSpinEdit412.Value) +
      ' pro' + inttostr(LSpinEdit413.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form411);
end;

// RUN COMMAND 'reset con? ...' WITH DIALOG
procedure TForm1.MenuItem45Click(Sender: TObject);
var
  Form451: TForm;
  LBevel451: TBevel;
  LButton451, LButton452: TButton;
  LLabel451, LLabel452: TLabel;
  LSpinEdit451: TSpinEdit;
  cmd: string;
begin
  Form451 := TForm.Create(Nil);
  LBevel451 := TBevel.Create(Form451);
  LButton451 := TButton.Create(Form451);
  LButton452 := TButton.Create(Form451);
  LLabel451 := TLabel.Create(Form451);
  LLabel452 := TLabel.Create(Form451);
  LSpinEdit451 := TSpinEdit.Create(Form451);
  with Form451 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem45.Caption);
    Name := 'Form451';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel451 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit451;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel451';
    Parent := Form451;
  end;
  with LSpinEdit451 do  // connection
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel452;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel451;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit451';
    Parent := Form451;
    TabOrder := 0;
  end;
  with LLabel452 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel452';
    Parent := Form451;
  end;
  with LBevel451 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit451;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel451';
    Parent := Form451;
    Shape := bsTopLine;
  end;
  with LButton451 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton452;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton451';
    Parent := Form451;
    TabOrder := 2;
  end;
  with LButton452 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    ModalResult := mrOk;
    Name := 'LButton452';
    Parent := Form451;
    TabOrder := 1;
  end;
  if Form451.ShowModal = mrOk then
  begin
    with Form451 do
      cmd := COMMANDS[7] +
      ' con' + inttostr(LSpinEdit451.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form451);
end;

// RUN COMMAND 'get con? ...'
procedure TForm1.MenuItem49Click(Sender: TObject);
var
  b: byte;
  cmd: string;
begin
  cmd := COMMANDS[2] + ' con';
  Memo1.Lines.Add(fullprompt + cmd + '[0-7]');
  for b := 0 to 7 do
    parsingcommands(cmd + inttostr(b));
end;

// RUN COMMAND 'set timeout'
procedure TForm1.MenuItem62Click(Sender: TObject);
var
  Form621: TForm;
  LBevel621: TBevel;
  LButton621, LButton622: TButton;
  LLabel621, LLabel622: TLabel;
  LSpinEdit621: TSpinEdit;
  cmd: string;
begin
  Form621 := TForm.Create(Nil);
  LBevel621 := TBevel.Create(Form621);
  LButton621 := TButton.Create(Form621);
  LButton622 := TButton.Create(Form621);
  LLabel621 := TLabel.Create(Form621);
  LLabel622 := TLabel.Create(Form621);
  LSpinEdit621 := TSpinEdit.Create(Form621);
  with Form621 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem62.Caption);
    Name := 'Form621';
    Position := poMainFormCenter;
    Parent := Nil;
  end;
  with LSpinEdit621 do  // timeout
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel622;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form621;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LLabel621;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 12;
    Autosize := true;
    MinValue := 1;
    MaxValue := 60;
    Name := 'LSpinEdit621';
    Parent := Form621;
    TabOrder := 0;
    Value := timeout;
  end;
  with LLabel621 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LSpinEdit621;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := 's';
    Name := 'LLabel621';
    Parent := Form621;
  end;
  with LLabel622 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit621;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Alignment := taCenter;
    Caption := MSG82;
    Name := 'LLabel622';
    Parent := Form621;
  end;
  with LBevel621 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit621;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form621;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel621';
    Parent := Form621;
    Shape := bsTopLine;
  end;
  with LButton621 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton622;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton621';
    Parent := Form621;
    TabOrder := 2;
  end;
  with LButton622 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton622';
    Parent := Form621;
    TabOrder := 1;
  end;
  if Form621.ShowModal = mrOk then
  begin
    with Form621 do
      cmd := COMMANDS[8] + ' timeout ' + inttostr(LSpinEdit621.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form621);
end;

// RUN COMMAND 'get timeout'
procedure TForm1.MenuItem63Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[2] + ' timeout';
  Memo1.Lines.Add(fullprompt + cmd);
  parsingcommands(cmd);
end;

// RUN COMMAND 'color ...' WITH InputBox
procedure TForm1.MenuItem23Click(Sender: TObject);
var
  Form231: TForm;
  LBevel231: TBevel;
  LButton231, LButton232: TButton;
  LColorBox231, LColorBox232: TColorBox;
  LLabel231, LLabel232: TLabel;
begin
  Form231 := TForm.Create(Nil);
  LBevel231 := TBevel.Create(Form231);
  LButton231 := TButton.Create(Form231);
  LButton232 := TButton.Create(Form231);
  LColorBox231 := TColorBox.Create(Form231);
  LColorBox232 := TColorBox.Create(Form231);
  LLabel231 := TLabel.Create(Form231);
  LLabel232 := TLabel.Create(Form231);
  with Form231 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem23.Caption);
    Name := 'Form231';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel231 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form231;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := MSG47;
    Name := 'LLabel231';
    Parent := Form231;
  end;
  with LColorBox231 do  // foreground color
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel231;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LColorBox231';
    Parent := Form231;
    Style := [cbStandardColors];
    TabOrder := 0;
  end;
  with LLabel232 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LColorBox231;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := MSG48;
    Name := 'LLabel232';
    Parent := Form231;
  end;
  with LColorBox232 do  // background color
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel232;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Name := 'LColorBox232';
    Parent := Form231;
    Style := [cbStandardColors];
    TabOrder := 1;
  end;
  with LBevel231 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form231;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form231;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel231';
    Parent := Form231;
    Shape := bsTopLine;
  end;
  with LButton231 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton232;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton231';
    Parent := Form231;
    TabOrder := 3;
  end;
  with LButton232 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form231;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton232';
    Parent := Form231;
    TabOrder := 2;
  end;
  LColorBox231.Selected := uconfig.guicolors[0];
  LColorBox232.Selected := uconfig.guicolors[1];
  if Form231.ShowModal = mrOk then
  begin
    with Form231 do
    begin
      uconfig.guicolors[0] := LColorBox231.Selected;
      uconfig.guicolors[1] := LColorBox232.Selected;
    end;
    Memo1.Font.Color := uconfig.guicolors[0];
    Memo1.Color := uconfig.guicolors[1];
  end;
  FreeAndNil(Form231);
end;

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
      if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem14.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
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
procedure TForm1.MenuItem31Click(Sender: TObject);
var
  LSaveDialog311: TSaveDialog;
  Form311: TForm;
  LBevel311: TBevel;
  LButton311, LButton312: TButton;
  LLabel311, LLabel312: TLabel;
  LRadioGroup311: TRadiogroup;
  LSpinEdit311, LSpinEdit312: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form311 := TForm.Create(Nil);
  LBevel311 := TBevel.Create(Form311);
  LButton311 := TButton.Create(Form311);
  LButton312 := TButton.Create(Form311);
  LLabel311 := TLabel.Create(Form311);
  LLabel312 := TLabel.Create(Form311);
  LRadioGroup311 := TRadioGroup.Create(Form311);
  LSpinEdit311 := TSpinEdit.Create(Form311);
  LSpinEdit312 := TSpinEdit.Create(Form311);
  for b := 0 to 3 do
    LRadioGroup311.Items.Add(REG_TYPE[b]);
  LRadioGroup311.ItemIndex := 0;
  with Form311 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem31.Caption);
    Name := 'Form311';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup311 do  // register type
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LSpinEdit312;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := Form311;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Name := 'LRadioGroup311';
    Parent := Form311;
    TabOrder := 0;
  end;
  with LLabel311 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit311;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Name := 'Form311';
    Parent := Form311;
  end;
  with LSpinEdit311 do  // start address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup311;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit311';
    Parent := Form311;
    Value := 0;
    Width := 100;
    TabOrder := 1;
  end;
  with LLabel312 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit312;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG61;
    Name := 'LLabel312';
    Parent := Form311;
  end;
  with LSpinEdit312 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel312;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup311;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit312';
    Parent := Form311;
    Value := 1;
    TabOrder := 2;
    Width := 100;
  end;
  with LBevel311 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form311;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form311;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel311';
    Parent := Form311;
    Shape := bsTopLine;
  end;
  with LButton311 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton312;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton311';
    Parent := Form311;
    TabOrder := 4;
  end;
  with LButton312 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form311;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG62;
    ModalResult := mrOk;
    Name := 'LButton312';
    Parent := Form311;
    TabOrder := 3;
  end;
  if Form311.ShowModal = mrOk then
  begin
    with Form311 do
    begin
      LSaveDialog311 := TSaveDialog.Create(Self);
      with LSaveDialog311 do
      begin
        Title := rmampdot(MenuItem14.Caption);
        InitialDir := vars[13].vvalue;
        Filter := MSG57;
        DefaultExt := 'xml';
        FilterIndex := 3;
        if Execute then
        begin
          if fileexists(FileName) then
            if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem31.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
            begin
              Free;
              exit;
          end;
          cmd := COMMANDS[15] + ' ' + FileName + ' ' +
            REG_TYPE[LRadioGroup311.ItemIndex] + ' ' +
            inttostr(LSpinEdit311.Value) + ' ' + inttostr(LSpinEdit312.Value);
          Memo1.Lines.Add(fullprompt + cmd);
          parsingcommands(cmd);
        end;
        Free;
      end;
    end;
  end;
  FreeAndNil(Form311);
end;

// RUN COMMAND 'dump' WITH DIALOG
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  Form151: TForm;
  LBevel151: TBevel;
  LButton151, LButton152: TButton;
  LLabel151: TLabel;
  LRadioGroup151: TRadiogroup;
  LSpinEdit151: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form151 := TForm.Create(Nil);
  LBevel151 := TBevel.Create(Form151);
  LButton151 := TButton.Create(Form151);
  LButton152 := TButton.Create(Form151);
  LLabel151 := TLabel.Create(Form151);
  LRadioGroup151 := TRadioGroup.Create(Form151);
  LSpinEdit151 := TSpinEdit.Create(Form151);
  for b := 0 to 3 do
    LRadioGroup151.Items.Add(REG_TYPE[b]);
  LRadioGroup151.ItemIndex := 0;
  with Form151 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem15.Caption);
    Name := 'Form151';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup151 do  // register type
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form151;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Name := 'LRadioGroup151';
    Parent := Form151;
    TabOrder := 0;
  end;
  with LLabel151 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit151;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Name := 'LLabel151';
    Parent := Form151;
  end;
  with LSpinEdit151 do  // start address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel151;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup151;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit151';
    Parent := Form151;
    MinValue := 1;
    MaxValue := 9990;
    Value := 1;
    TabOrder := 1;
    Width := 100;
  end;
  with LBevel151 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup151;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form151;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form151;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel151';
    Parent := Form151;
    Shape := bsTopLine;
  end;
  with LButton151 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton152;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton151';
    Parent := Form151;
    TabOrder := 3;
  end;
  with LButton152 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form151;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG63;
    Name := 'LButton152';
    ModalResult := mrOk;
    Parent := Form151;
    TabOrder := 2;
  end;
  if Form151.ShowModal = mrOk then
  begin
    with Form151 do
    begin
      cmd := COMMANDS[33] + ' ' + REG_TYPE[LRadioGroup151.ItemIndex] + ' ' + inttostr(LSpinEdit151.Value);
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
    end;
  end;
  FreeAndNil(Form151);
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
      StatusBar1.Panels.Items[1].Text := FileName;
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
        if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem11.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
        begin
          Free;
          exit;
        end;
      cmd := COMMANDS[93] + ' ' + FileName;
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
      StatusBar1.Panels.Items[1].Text := FileName;
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
procedure TForm1.MenuItem30Click(Sender: TObject);
var
  Form301: TForm;
  LSynEdit301: TSynEdit;
  line, sline: integer;
begin
  Form301 := TForm.Create(Nil);
  LSynEdit301 := TSynEdit.Create(Form301);
  with Form301 do
  begin
    BorderStyle := bsSizeable;
    Caption := rmampdot(MenuItem30.Caption);
    Name := 'Form301';
    Parent := Nil;
    Top := formpositions[3, 0];
    Left := formpositions[3, 1];
    if formpositions[3, 2] > 240 then Height := formpositions[3, 2];
    if formpositions[3, 3] > 320 then Width := formpositions[3, 3];
  end;
  with LSynEdit301 do
  begin
    Anchors := [akTop, akBottom, akLeft, akRight];
      AnchorSideTop.Control := Form301;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 1;
      AnchorSideBottom.Control := Form301;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 1;
      AnchorSideLeft.Control := Form301;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 1;
      AnchorSideRight.Control := Form301;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 1;
    Color := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Background := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Foreground := clYellow;
    Font.Color := clAqua;
    Gutter.Color := clNavy;
    Name := 'LSynEdit301';
    Parent := Form301;
    ReadOnly := False;
    ScrollBars := ssAutoBoth;
    TabOrder := 0;
    Position := poMainFormCenter;
    HighLighter := LSynAnySyn1;
  end;
  for sline := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[sline]) > 0 then
      LSynEdit301.Lines.Add(sbuffer[sline]);
  Form301.ShowModal;
  sline := 0;
  for line := 0 to LSynEdit301.Lines.Count -1 do
    if sline < SCRBUFFSIZE - 1 then
      if length(LSynEdit301.Lines[line]) > 0 then
      begin
        sbuffer[sline] := LSynEdit301.Lines[line];
        inc(sline);
      end;
  if length(LSynEdit301.Text) > 0 then scriptisloaded := true;
  with Form301 do
  begin
    formpositions[3, 0] := Top;
    formpositions[3, 1] := Left;
    formpositions[3, 2] := Height;
    formpositions[3, 3] := Width;
  end;
  FreeAndNil(Form301);
end;

// RUN COMMAND 'erasescr'
procedure TForm1.MenuItem29Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[92];
  Memo1.Lines.Add(fullprompt + cmd);
  StatusBar1.Panels.Items[1].Text := '';
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

// RUN COMMAND 'echo swap'
procedure TForm1.MenuItem28Click(Sender: TObject);
var
  cmd: string;
begin
  cmd := COMMANDS[38] + ' swap';
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

// change numerical systems or input value
procedure TForm1.LEdit261Change(Sender: TObject);
var
  LEdit261, LEdit262: TEdit;
  LRadioGroup261, LRadioGroup262: TRadioGroup;
begin
  if (Sender is TEdit) or (Sender is TRadioGroup) then
  begin
    LEdit261 := TEdit(TForm(TEdit(Sender).Parent).FindComponent('LEdit261'));
    LEdit262 := TEdit(TForm(TEdit(Sender).Parent).FindComponent('LEdit262'));
    LRadioGroup261 := TRadioGroup(TForm(TEdit(Sender).Parent).FindComponent('LRadioGroup261'));
    LRadioGroup262 := TRadioGroup(TForm(TEdit(Sender).Parent).FindComponent('LRadioGroup262'));
    if (assigned(LEdit261)) and
       (assigned(LEdit262)) and
       (assigned(LRadioGroup261)) and
       (assigned(LRadioGroup262)) then
    begin
      if length(LEdit261.Text) > 0 then
      begin
        {
          y-axis: from (ns1)
          x-axis: to (ns2)

           |B  D  H  O
          -+-----------
          B|   01 02 03
          D|10    12 13
          H|20 21    23
          O|30 31 32
        }
        case (10 * LRadioGroup261.ItemIndex + LRadioGroup262.ItemIndex) of
          0: LEdit262.Text := BinToDez(DezToBin(LEdit261.Text));
          1: LEdit262.Text := BinToDez(LEdit261.Text);
          2: LEdit262.Text := BinToHex(LEdit261.Text);
          3: LEdit262.Text := BinToOkt(LEdit261.Text);
          10: LEdit262.Text := DezToBin(LEdit261.Text);
          11: LEdit262.Text := DezToHex(HexToDez(LEdit261.Text));
          12: LEdit262.Text := DezToHex(LEdit261.Text);
          13: LEdit262.Text := DezToOkt(LEdit261.Text);
          20: LEdit262.Text := HexToBin(LEdit261.Text);
          21: LEdit262.Text := HexToDez(LEdit261.Text);
          22: LEdit262.Text := HexToDez(DezToHex(LEdit261.Text));
          23: LEdit262.Text := HexToOkt(LEdit261.Text);
          30: LEdit262.Text := OktToBin(LEdit261.Text);
          31: LEdit262.Text := OktToDez(LEdit261.Text);
          32: LEdit262.Text := OktToHex(LEdit261.Text);
          33: LEdit262.Text := OktToDez(DezToOkt(LEdit261.Text));
        end;
      end else LEdit262.Clear;
    end;
  end;
end;

// change target variable
procedure TForm1.LEdit263Change(Sender: TObject);
var
  LButton262: TButton;
begin
  if Sender is TEdit then
  begin
    LButton262 := TButton(TForm(TEdit(Sender).Parent).FindComponent('LButton262'));
    if assigned(LButton262) then
    begin
      if length(TEdit(Sender).Text) > 0
        then LButton262.Enabled := true
        else LButton262.Enabled := false;
    end;
  end;
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
var
  Form261: TForm;
  LBevel261: TBevel;
  LButton261, LButton262: TButton;
  LEdit261, LEdit262, LEdit263: TEdit;
  LRadioGroup261, LRadioGroup262: TRadiogroup;
  cmd: string;
begin
  Form261 := TForm.Create(Nil);
  LBevel261 := TBevel.Create(Form261);
  LButton261 := TButton.Create(Form261);
  LButton262 := TButton.Create(Form261);
  LEdit261 := TEdit.Create(Form261);
  LEdit262 := TEdit.Create(Form261);
  LEdit263 := TEdit.Create(Form261);
  LRadioGroup261 := TRadioGroup.Create(Form261);
  LRadioGroup262 := TRadioGroup.Create(Form261);
  for b := 0 to 3 do
  begin
    LRadioGroup261.Items.Add(NUM_SYS[b]);
    LRadioGroup262.Items.Add(NUM_SYS[b]);
  end;
  LRadioGroup261.ItemIndex := 1;
  LRadioGroup262.ItemIndex := 2;
  with Form261 do
  begin
    Caption := rmampdot(MenuItem26.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form261';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup261 do
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LEdit263;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := Form261;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG66;
    Name := 'LRadioGroup261';
    Parent := Form261;
    TabOrder := 0;
    OnSelectionChanged := @LEdit261Change;
  end;
  with LRadioGroup262 do
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LRadioGroup261;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := LRadioGroup261;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG67;
    Name := 'LRadioGroup262';
    Parent := Form261;
    TabOrder := 1;
    OnSelectionChanged := @LEdit261Change;
  end;
  with LEdit261 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Hint := MSG66;
    Name := 'LEdit261';
    Parent := Form261;
    TabOrder := 2;
    ShowHint := true;
    Width := 100;
    Clear;
    OnChange := @LEdit261Change;
  end;
  with LEdit262 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit261;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LEdit261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Hint := MSG67;
    Name := 'LEdit262';
    Parent := Form261;
    ReadOnly := True;
    ShowHint := true;
    TabOrder := 3;
    Clear;
  end;
  with LEdit263 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit262;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LEdit262;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Hint := MSG74;
    Name := 'LEdit263';
    Parent := Form261;
    ShowHint := true;
    TabOrder := 4;
    Clear;
    OnChange := @LEdit263Change;
  end;
  with LBevel261 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup261;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form261;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel261';
    Parent := Form261;
    Shape := bsTopLine;
  end;
  with LButton261 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton262;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton261';
    Parent := Form261;
    TabOrder := 6;
  end;
  with LButton262 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    Enabled := false;
    ModalResult := mrOk;
    Name := 'LButton262';
    Parent := Form261;
    TabOrder := 5;
  end;
  if Form261.ShowModal = mrOk then
    if length(LEdit263.Text) > 0 then
    begin
      with Form261 do
      begin
        cmd := COMMANDS[17] + ' ' +
          LEdit263.Text + ' ' +
          NUM_SYS[LRadioGroup261.ItemIndex] + ' ' +
          NUM_SYS[LRadioGroup262.ItemIndex] + ' ' +
          LEdit261.Text;
        Memo1.Lines.Add(fullprompt + cmd);
        parsingcommands(cmd);
      end;
    end;
  FreeAndNil(Form261);
end;

// RUN COMMAND 'varmon' with DIALOG
procedure TForm1.MenuItem52Click(Sender: TObject);
begin
  with Form2 do
  begin
    Show;
    ValueListEditor1.TitleCaptions.Add(MSG79);
    ValueListEditor1.TitleCaptions.Add(MSG80);
  end;
  Form1.Show;
end;

// RUN COMMAND 'sercons' with DIALOG
procedure TForm1.MenuItem54Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel2: TLabel;
  LSpinEdit1: TSpinEdit;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem54.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Parent := Form;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel1;
      AnchorSideRight.Side := asrRight;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 0;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form;
    Shape := bsTopLine;
  end;
  with LButton1 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton2;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 2;
  end;
  with LButton2 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG70;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    frmsecn.device := LSpinEdit1.Value;
    with Form3 do
    begin
      Show;
      Caption := rmampdot(MenuItem54.Caption);
      StatusBar1.Panels[0].Text := Form1.StatusBar1.Panels[0].Text;
    end;
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'serread' with DIALOG
procedure TForm1.MenuItem16Click(Sender: TObject);
var
  Form161: TForm;
  LBevel161: TBevel;
  LButton161, LButton162: TButton;
  LLabel161, LLabel163, LLabel164: TLabel;
  LEdit161: TEdit;
  LSpinEdit161: TSpinEdit;
  LThread161: TLThread;
begin
  Form161 := TForm.Create(Nil);
  LBevel161 := TBevel.Create(Form161);
  LButton161 := TButton.Create(Form161);
  LButton162 := TButton.Create(Form161);
  LEdit161 := TEdit.Create(Form161);
  LLabel161 := TLabel.Create(Form161);
  LLabel163 := TLabel.Create(Form161);
  LLabel164 := TLabel.Create(Form161);
  LSpinEdit161 := TSpinEdit.Create(Form161);
  with Form161 do
  begin
    Caption := rmampdot(MenuItem16.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form161';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel161';
    Parent := Form161;
  end;
  with LSpinEdit161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel163;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel161;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit161';
    Parent := Form161;
    TabOrder := 0;
  end;
  with LEdit161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit161;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit161';
    Parent := Form161;
    TabOrder := 1;
    Width := 60;
  end;
  with LLabel163 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel163';
    Parent := Form161;
  end;
  with LLabel164 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74;
    Name := 'LLabel164';
    Parent := Form161;
  end;
  with LBevel161 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel161';
    Parent := Form161;
    Shape := bsTopLine;
  end;
  with LButton161 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton162;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton161';
    Parent := Form161;
    TabOrder := 3;
  end;
  with LButton162 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton162';
    Parent := Form161;
    TabOrder := 2;
  end;
  if Form161.ShowModal = mrOk then
  begin
    with Form161 do
    begin
      thrdcmd.c := 36;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit161.Value);
        if length(LEdit161.Text) > 0 then thrdcmd.p2 := '$' + LEdit161.Text else thrdcmd.p2 := '';
    end;
    LThread161 := TLThread.Create(true);
    with LThread161 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form161);
end;

// RUN COMMAND 'serwrite' with DIALOG
procedure TForm1.MenuItem50Click(Sender: TObject);
var
  Form501: TForm;
  LBevel501: TBevel;
  LButton501, LButton502: TButton;
  LLabel501, LLabel503, LLabel504: TLabel;
  LEdit501: TEdit;
  LSpinEdit501: TSpinEdit;
  LThread501: TLThread;
begin
  Form501 := TForm.Create(Nil);
  LBevel501 := TBevel.Create(Form501);
  LButton501 := TButton.Create(Form501);
  LButton502 := TButton.Create(Form501);
  LEdit501 := TEdit.Create(Form501);
  LLabel501 := TLabel.Create(Form501);
  LLabel503 := TLabel.Create(Form501);
  LLabel504 := TLabel.Create(Form501);
  LSpinEdit501 := TSpinEdit.Create(Form501);
  with Form501 do
  begin
    Caption := rmampdot(MenuItem50.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form501';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel501';
    Parent := Form501;
  end;
  with LSpinEdit501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel503;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel501;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit501';
    Parent := Form501;
    TabOrder := 0;
  end;
  with LEdit501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit501;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit501';
    Parent := Form501;
    TabOrder := 1;
    Width := 250;
  end;
  with LLabel503 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel503';
    Parent := Form501;
  end;
  with LLabel504 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74 +'/' + MSG75;
    Name := 'LLabel504';
    Parent := Form501;
  end;
  with LBevel501 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel501';
    Parent := Form501;
    Shape := bsTopLine;
  end;
  with LButton501 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton502;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton501';
    Parent := Form501;
    TabOrder := 3;
  end;
  with LButton502 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton502';
    Parent := Form501;
    TabOrder := 2;
  end;
  if Form501.ShowModal = mrOk then
  begin
    with Form501 do
    begin
      thrdcmd.c := 37;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit501.Value);
      if boolisitvariable('$' + LEdit501.Text)
        then thrdcmd.p2 := '$' + LEdit501.Text
        else thrdcmd.p2 := '"' + LEdit501.Text + '"';
    end;
    LThread501 := TLThread.Create(true);
    with LThread501 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form501);
end;

// -- MAIN MENU/Help -----------------------------------------------------------

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
  Memo1.Lines.Add(fullprompt + cmd);
  if length(ComboBox1.Text) > 0 then
  begin
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
  // save main window size and position and set title
  with Form1 do
  begin
    formpositions[0, 0] := Top;
    formpositions[0, 1] := Left;
    formpositions[0, 2] := Height;
    formpositions[0, 3] := Width;
  end;
  // save variable monitor window size and position and set title
  with Form2 do
  begin
    formpositions[1, 0] := Top;
    formpositions[1, 1] := Left;
    formpositions[1, 2] := Height;
    formpositions[1, 3] := Width;
  end;
  // save mini serial console window size and position and set title
  with Form3 do
  begin
    formpositions[2, 0] := Top;
    formpositions[2, 1] := Left;
    formpositions[2, 2] := Height;
    formpositions[2, 3] := Width;
  end;
  // save configuration
  uconfig.lastproject := vars[12].vvalue;
  saveconfiguration(BASENAME,'.ini');
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
begin
  randomize;
  // detect language
  lang := getlang;
  // set default constants
  loadconfiguration(BASENAME,'.ini');
  vars[12].vvalue := uconfig.lastproject;
  setdefaultconstants;
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
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
  // set statusbar
  StatusBar1.Panels[0].Text := 'Echo: ' + upcase(ECHO_ARG[echo]);
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
    for b := 0 to 3 do Constants.Add(ECHO_ARG[b]);
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
end;

end.
