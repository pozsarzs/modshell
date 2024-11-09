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
  strings,
  synaser,
  ucommon,
  uconfig,
  utranslt,
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
  menucmd: string;
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
  fStatusText := fullprompt + menucmd + EOL;
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

// RUN command 'exit'
procedure TForm1.MenuItem20Click(Sender: TObject);
begin
  menucmd := COMMANDS[1];
  Memo1.Lines.Add(fullprompt + menucmd);
  Form1.Close;
end;

// -- MAIN MENU/Project --------------------------------------------------------

// RUN COMMAND 'loadcfg' WITH TOpenDialog
procedure TForm1.MenuItem37Click(Sender: TObject);
var
  LOpenDialog1: TOpenDialog;
begin
  LOpenDialog1 := TOpenDialog.Create(Self);
  with LOpenDialog1 do
  begin
    DefaultExt := '';
    Filter := MSG42;
    FilterIndex := 0;
    InitialDir := vars[13].vvalue;
    Title := rmampdot(MenuItem37.Caption);
  end;
  if LOpenDialog1.Execute then
  begin
    menucmd := COMMANDS[14] + ' ' + LOpenDialog1.FileName;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  LOpenDialog1.Free;
end;

// RUN COMMAND 'savecfg' WITH TSaveDialog
procedure TForm1.MenuItem36Click(Sender: TObject);
var
  exists: boolean = false;
  fp, fn, fx, fpn: string;
  LSaveDialog1: TSaveDialog;
begin
  LSaveDialog1 := TSaveDialog.Create(Self);
  with LSaveDialog1 do
  begin
    DefaultExt := '';
    Filter := MSG42;
    FilterIndex := 0;
    InitialDir := vars[13].vvalue;
    Title := rmampdot(MenuItem36.Caption);
  end;
  if LSaveDialog1.Execute then
  begin
    fp := extractfilepath(LSaveDialog1.FileName);
    fn := extractfilename(LSaveDialog1.FileName);
    fx := extractfileext(LSaveDialog1.FileName);
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
        LSaveDialog1.Free;
        exit;
      end;
    menucmd := COMMANDS[13] + ' ' + fp + fn;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  LSaveDialog1.Free;
end;

// RUN COMMAND 'set prj ...' WITH InputBox
procedure TForm1.MenuItem38Click(Sender: TObject);
begin
  menucmd := COMMANDS[8] + ' prj ' + InputBox(rmampdot(MenuItem38.Caption), MSG71, vars[12].vvalue);
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
  Form1.Caption := 'X' + PRGNAME + ' | ' + vars[12].vvalue;
  Label1.Caption := fullprompt;
end;

// RUN COMMAND 'reset prj'
procedure TForm1.MenuItem42Click(Sender: TObject);
begin
  menucmd := COMMANDS[7] + ' prj';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
  Form1.Caption := 'X' + PRGNAME + ' | ' + vars[12].vvalue;
  Label1.Caption := fullprompt;
end;

// RUN COMMAND 'get prj'
procedure TForm1.MenuItem46Click(Sender: TObject);
begin
  menucmd := COMMANDS[2] + ' prj';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'set dev? ...' WITH DIALOG
procedure TForm1.MenuItem39Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LComboBox1, LComboBox2: TComboBox;
  LEdit1, LEdit2: TEdit;
  LLabel1, LLabel2, LLabel3, LLabel4, LLabel5, LLabel6, LLabel7, LLabel8: TLabel;
  LSpinEdit1, LSpinEdit2, LSpinEdit3: TSpinEdit;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LComboBox1 := TComboBox.Create(Form);
  LComboBox2 := TComboBox.Create(Form);
  LEdit1 := TEdit.Create(Form);
  LEdit2 := TEdit.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LLabel3 := TLabel.Create(Form);
  LLabel4 := TLabel.Create(Form);
  LLabel5 := TLabel.Create(Form);
  LLabel6 := TLabel.Create(Form);
  LLabel7 := TLabel.Create(Form);
  LLabel8 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  LSpinEdit2 := TSpinEdit.Create(Form);
  LSpinEdit3 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem39.Caption);
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
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
  end;
  with LComboBox1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Items.Add('ser');
    Items.Add('net');
    ItemIndex := 0;
    Parent := Form;
    ReadOnly := true;
    TabOrder := 1;
  end;
  with LEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    TabOrder := 2;
    Width := 100;
  end;
  with LEdit2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Parent := Form;
    TabOrder := 3;
    Width := 100;
  end;
  with LSpinEdit2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LEdit2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    MinValue := 7;
    MaxValue := 8;
    Value := 8;
    TabOrder := 4;
  end;
  with LComboBox2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Items.Add('N');
    Items.Add('E');
    Items.Add('O');
    ItemIndex := 0;
    Parent := Form;
    ReadOnly := true;
    TabOrder := 5;
  end;
  with LSpinEdit3 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LComboBox2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Parent := Form;
    MinValue := 1;
    MaxValue := 2;
    Value := 1;
    TabOrder := 6;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Parent := Form;
  end;
  with LLabel3 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG72;
    Parent := Form;
  end;
  with LLabel4 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit2;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG51;
    Parent := Form;
  end;
  with LLabel5 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit2;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG52;
    Parent := Form;
  end;
  with LLabel6 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox2;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
      Caption := MSG53;
    Parent := Form;
  end;
  with LLabel7 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit3;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG54;
    Parent := Form;
  end;
  with LLabel8 do
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 8;
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
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 7;
  end;
  if Form.ShowModal = mrOk then
  begin
   with Form do
     if LComboBox1.ItemIndex = 0 then
       menucmd := COMMANDS[8] + ' dev' +
         inttostr(LSpinEdit1.Value) + ' ' +
         LComboBox1.Items[LComboBox1.ItemIndex] + ' ' +
         LEdit1.Text + ' ' +
         LEdit2.Text + ' ' +
         inttostr(LSpinEdit2.Value) + ' ' +
         LComboBox2.Items[LComboBox2.ItemIndex] + ' ' +
         inttostr(LSpinEdit3.Value)
     else
       menucmd := COMMANDS[8] + ' dev' +
         inttostr(LSpinEdit1.Value) + ' ' +
         LComboBox1.Items[LComboBox1.ItemIndex] + ' ' +
         LEdit1.Text + ' ' +
         LEdit2.Text;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'reset dev? ...' WITH DIALOG
procedure TForm1.MenuItem43Click(Sender: TObject);
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
    Caption := rmampdot(MenuItem43.Caption);
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
    Caption := 'dev';
    Parent := Form;
    Font.Style := [fsBold];
    BorderSpacing.Left := 12;
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
    Caption := MSG46;
    Parent := Form;
    ModalResult := mrOk;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[7] + ' dev' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'get dev? ...'
procedure TForm1.MenuItem47Click(Sender: TObject);
var
  b: byte;
begin
  menucmd := COMMANDS[2] + ' dev';
  Memo1.Lines.Add(fullprompt + menucmd+ '[0-7]');
  for b := 0 to 7 do
    parsingcommands(menucmd + inttostr(b));
end;

// RUN COMMAND 'set pro? ...' WITH DIALOG
procedure TForm1.MenuItem40Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LComboBox1: TComboBox;
  LEdit1: TEdit;
  LLabel1, LLabel2, LLabel3, LLabel4: TLabel;
  LSpinEdit1: TSpinEdit;
  b: byte;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LComboBox1 := TComboBox.Create(Form);
  LEdit1 := TEdit.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LLabel3 := TLabel.Create(Form);
  LLabel4 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem40.Caption);
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
    Caption := 'pro';
    Font.Style := [fsBold];
    Parent := Form;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
  end;
  with LComboBox1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    for b:= 0 to 3 do Items.Add(PROT_TYPE[b]);
    ItemIndex := 0;
    Parent := Form;
    ReadOnly := true;
    TabOrder := 1;
  end;
  with LEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Parent := Form;
    TabOrder := 2;
    Width := 150;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Parent := Form;
  end;
  with LLabel3 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG56;
    Parent := Form;
  end;
  with LLabel4 do
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
    Caption := MSG55;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 4;
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
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 3;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[8] + ' pro' +
        inttostr(LSpinEdit1.Value) + ' ' +
        LComboBox1.Items[LComboBox1.ItemIndex] + ' ' +
        LEdit1.Text;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'reset pro? ...' WITH DIALOG
procedure TForm1.MenuItem44Click(Sender: TObject);
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
    AutoSize := True;
    Caption := rmampdot(MenuItem44.Caption);
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
    Caption := 'pro';
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
      BorderSpacing.Right := 0;
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
    Caption := MSG55;
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
    Caption := MSG46;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[7] +
      ' pro' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'get pro? ...'
procedure TForm1.MenuItem48Click(Sender: TObject);
var
  b: byte;
begin
  menucmd := COMMANDS[2] + ' pro';
  Memo1.Lines.Add(fullprompt + menucmd+ '[0-7]');
  for b := 0 to 7 do
    parsingcommands(menucmd + inttostr(b));
end;

// RUN COMMAND 'set con? ...' WITH DIALOG
procedure TForm1.MenuItem41Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel2, LLabel3, LLabel4, LLabel5, LLabel6: TLabel;
  LSpinEdit1, LSpinEdit2, LSpinEdit3: TSpinEdit;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LLabel3 := TLabel.Create(Form);
  LLabel4 := TLabel.Create(Form);
  LLabel5 := TLabel.Create(Form);
  LLabel6 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  LSpinEdit2 := TSpinEdit.Create(Form);
  LSpinEdit3 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem41.Caption);
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
    Caption := 'con';
    Font.Style := [fsBold];
    Parent := Form;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft];
    AnchorSideTop.Control := LLabel4;
    AnchorSideTop.Side := asrBottom;
    BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 0;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'dev';
    Parent := Form;
  end;
  with LSpinEdit2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 1;
  end;
  with LLabel3 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'pro';
    Parent := Form;
  end;
  with LSpinEdit3 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel3;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 2;
  end;
  with LLabel4 do
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
    Caption := MSG73;
    Parent := Form;
  end;
  with LLabel5 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel2;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit2;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form;
  end;
  with LLabel6 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel3;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit3;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 4;
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
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 3;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[8] +
      ' con' + inttostr(LSpinEdit1.Value) +
      ' dev' + inttostr(LSpinEdit2.Value) +
      ' pro' + inttostr(LSpinEdit3.Value);
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'reset con? ...' WITH DIALOG
procedure TForm1.MenuItem45Click(Sender: TObject);
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
    Caption := rmampdot(MenuItem45.Caption);
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
    Caption := 'con';
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
      BorderSpacing.Right := 0;
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
    Caption := MSG73;
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
    Caption := MSG46;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[7] +
      ' con' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'get con? ...'
procedure TForm1.MenuItem49Click(Sender: TObject);
var
  b: byte;
begin
  menucmd := COMMANDS[2] + ' con';
  Memo1.Lines.Add(fullprompt + menucmd+ '[0-7]');
  for b := 0 to 7 do
    parsingcommands(menucmd + inttostr(b));
end;

// RUN COMMAND 'set timeout'
procedure TForm1.MenuItem62Click(Sender: TObject);
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
    Caption := rmampdot(MenuItem62.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LLabel1;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 12;
    Autosize := true;
    MinValue := 1;
    MaxValue := 60;
    Parent := Form;
    TabOrder := 0;
    Value := timeout;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := 's';
    Parent := Form;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Alignment := taCenter;
    Caption := MSG82;
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
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      menucmd := COMMANDS[8] + ' timeout' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'get timeout'
procedure TForm1.MenuItem63Click(Sender: TObject);
begin
  menucmd := COMMANDS[2] + ' timeout';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'color ...' WITH InputBox
procedure TForm1.MenuItem23Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LColorBox1, LColorBox2: TColorBox;
  LLabel1, LLabel2: TLabel;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LColorBox1 := TColorBox.Create(Form);
  LColorBox2 := TColorBox.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem23.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := MSG47;
    Parent := Form;
  end;
  with LColorBox1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    Style := [cbStandardColors];
    TabOrder := 0;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LColorBox1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := MSG48;
    Parent := Form;
  end;
  with LColorBox2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Parent := Form;
    Style := [cbStandardColors];
    TabOrder := 1;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LColorBox1;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 3;
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
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 2;
  end;
  LColorBox1.Selected := uconfig.guicolors[0];
  LColorBox2.Selected := uconfig.guicolors[1];
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      uconfig.guicolors[0] := LColorBox1.Selected;
      uconfig.guicolors[1] := LColorBox2.Selected;
    end;
    Memo1.Font.Color := uconfig.guicolors[0];
    Memo1.Color := uconfig.guicolors[1];
  end;
  FreeAndNil(Form);
end;

// -- MAIN MENU/Registers ------------------------------------------------------

// RUN COMMAND 'loadreg' WITH TOpenDialog
procedure TForm1.MenuItem13Click(Sender: TObject);
var
  LOpenDialog1: TOpenDialog;
begin
  LOpenDialog1 := TOpenDialog.Create(Self);
  with LOpenDialog1 do
  begin
    Title := rmampdot(MenuItem13.Caption);
    InitialDir := vars[13].vvalue;
    Filter := MSG42;
    DefaultExt := '';
    FilterIndex := 0;
  end;
  if LOpenDialog1.Execute then
  begin
    menucmd := COMMANDS[19] + ' ' + LOpenDialog1.FileName;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  LOpenDialog1.Free;
end;

// RUN COMMAND 'savereg' WITH TSaveDialog
procedure TForm1.MenuItem14Click(Sender: TObject);
var
  exists: boolean = false;
  fp,fn,fx, fpn: string;
  LSaveDialog1: TSaveDialog;
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
    menucmd := COMMANDS[18] + ' ' + fp + fn;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  LSaveDialog1.Free;
end;

// RUN COMMAND 'impreg' WITH TOpenDialog
procedure TForm1.MenuItem32Click(Sender: TObject);
var
  LOpenDialog1: TOpenDialog;
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
    menucmd := COMMANDS[22] + ' ' + LOpenDialog1.FileName;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
  end;
  LOpenDialog1.Free;
end;

// RUN COMMAND 'expreg' WITH TSaveDialog
procedure TForm1.MenuItem31Click(Sender: TObject);
var
  LSaveDialog1: TSaveDialog;
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel2: TLabel;
  LRadioGroup1: TRadiogroup;
  LSpinEdit1, LSpinEdit2: TSpinEdit;
  b: byte;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LRadioGroup1 := TRadioGroup.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  LSpinEdit2 := TSpinEdit.Create(Form);
  for b := 0 to 3 do
    LRadioGroup1.Items.Add(REG_TYPE[b]);
  LRadioGroup1.ItemIndex := 0;
  with Form do
  begin
    Caption := rmampdot(MenuItem31.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LRadioGroup1 do
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LSpinEdit2;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Parent := Form;
    TabOrder := 0;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Parent := Form;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    Value := 0;
    Width := 100;
    TabOrder := 1;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit2;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG61;
    Parent := Form;
  end;
  with LSpinEdit2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    Value := 1;
    TabOrder := 2;
    Width := 100;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup1;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 4;
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
    Caption := MSG62;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 3;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      LSaveDialog1 := TSaveDialog.Create(Self);
      with LSaveDialog1 do
      begin
        Title := rmampdot(MenuItem14.Caption);
        InitialDir := vars[13].vvalue;
        Filter := MSG57;
        DefaultExt := 'xml';
        FilterIndex := 3;
      end;
      if LSaveDialog1.Execute then
      begin
        if fileexists(LSaveDialog1.FileName) then
          if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem31.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
          begin
            LSaveDialog1.Free;
            exit;
          end;
        menucmd := COMMANDS[15] + ' ' + LSaveDialog1.FileName + ' ' +
          REG_TYPE[LRadioGroup1.ItemIndex] + ' ' +
          inttostr(LSpinEdit1.Value) + ' ' + inttostr(LSpinEdit2.Value);
        Memo1.Lines.Add(fullprompt + menucmd);
        parsingcommands(menucmd);
      end;
      LSaveDialog1.Free;
    end;
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'dump' WITH DIALOG
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1: TLabel;
  LRadioGroup1: TRadiogroup;
  LSpinEdit1: TSpinEdit;
  b: byte;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LRadioGroup1 := TRadioGroup.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  for b := 0 to 3 do
    LRadioGroup1.Items.Add(REG_TYPE[b]);
  LRadioGroup1.ItemIndex := 0;
  with Form do
  begin
    Caption := rmampdot(MenuItem15.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LRadioGroup1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Parent := Form;
    TabOrder := 0;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Parent := Form;
  end;
  with LSpinEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    MinValue := 1;
    MaxValue := 9990;
    Value := 1;
    TabOrder := 1;
    Width := 100;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup1;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 3;
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
    Caption := MSG63;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 2;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      menucmd := COMMANDS[33] + ' ' + REG_TYPE[LRadioGroup1.ItemIndex] + ' ' + inttostr(LSpinEdit1.Value);
      Memo1.Lines.Add(fullprompt + menucmd);
      parsingcommands(menucmd);
    end;
  end;
  FreeAndNil(Form);
end;

// -- MAIN MENU/Script ---------------------------------------------------------

// RUN COMMAND 'loadscr' WITH TOpenDialog
procedure TForm1.MenuItem10Click(Sender: TObject);
var
  LOpenDialog1: TOpenDialog;
begin
  LOpenDialog1 := TOpenDialog.Create(Self);
  with LOpenDialog1 do
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
  end;
  if LOpenDialog1.Execute then
  begin
    menucmd := COMMANDS[39] + ' ' + LOpenDialog1.FileName;
    Memo1.Lines.Add(fullprompt + menucmd);
    StatusBar1.Panels.Items[1].Text := LOpenDialog1.FileName;
    parsingcommands(menucmd);
  end;
  LOpenDialog1.Free;
end;

// RUN COMMAND 'savescr' WITH TSaveDialog
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  LSaveDialog1: TSaveDialog;
begin
  LSaveDialog1 := TSaveDialog.Create(Self);
  with LSaveDialog1 do
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
  end;
  if LSaveDialog1.Execute then
  begin
    if FileExists(LSaveDialog1.FileName) then
      if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem11.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
      begin
        LSaveDialog1.Free;
        exit;
      end;
    menucmd := COMMANDS[93] + ' ' + LSaveDialog1.FileName;
    Memo1.Lines.Add(fullprompt + menucmd);
    parsingcommands(menucmd);
    StatusBar1.Panels.Items[1].Text := LSaveDialog1.FileName;
  end;
  LSaveDialog1.Free;
end;

// RUN COMMAND 'list'
procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  menucmd := COMMANDS[41];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'edit' WITH DIALOG
procedure TForm1.MenuItem30Click(Sender: TObject);
var
  Form: TForm;
  LSynEdit1: TSynEdit;
  line, sline: integer;
begin
  Form := TForm.Create(Nil);
  LSynEdit1 := TSynEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem30.Caption);
    Top := formpositions[3, 0];
    Left := formpositions[3, 1];
    if formpositions[3, 2] > 240 then Height := formpositions[3, 2];
    if formpositions[3, 3] > 320 then Width := formpositions[3, 3];
    BorderStyle := bsSizeable;
  end;
  with LSynEdit1 do
  begin
    Anchors := [akTop, akBottom, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 1;
      AnchorSideBottom.Control := Form;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 1;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 1;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 1;
    Color := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Background := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Foreground := clYellow;
    Font.Color := clAqua;
    Gutter.Color := clNavy;
    Parent := Form;
    ReadOnly := False;
    ScrollBars := ssAutoBoth;
    TabOrder := 0;
    Position := poMainFormCenter;
    HighLighter := LSynAnySyn1;
  end;
  for sline := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[sline]) > 0 then
      LSynEdit1.Lines.Add(sbuffer[sline]);
  Form.ShowModal;
  sline := 0;
  for line := 0 to LSynEdit1.Lines.Count -1 do
    if sline < SCRBUFFSIZE - 1 then
      if length(LSynEdit1.Lines[line]) > 0 then
      begin
        sbuffer[sline] := LSynEdit1.Lines[line];
        inc(sline);
      end;
  if length(LSynEdit1.Text) > 0 then scriptisloaded := true;
  with Form do
  begin
    formpositions[3, 0] := Top;
    formpositions[3, 1] := Left;
    formpositions[3, 2] := Height;
    formpositions[3, 3] := Width;
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'erasescr'
procedure TForm1.MenuItem29Click(Sender: TObject);
begin
  menucmd := COMMANDS[92];
  Memo1.Lines.Add(fullprompt + menucmd);
  StatusBar1.Panels.Items[1].Text := '';
  parsingcommands(menucmd);
end;

// RUN COMMAND 'run'
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  menucmd := COMMANDS[40];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// -- MAIN MENU/Operation ------------------------------------------------------

// RUN COMMAND 'cls'
procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  parsingcommands(COMMANDS[12]);
end;

// RUN COMMAND 'echo swap'
procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  menucmd := COMMANDS[38] + ' swap';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'const'
procedure TForm1.MenuItem24Click(Sender: TObject);
begin
  menucmd := COMMANDS[66];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'var'
procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  menucmd := COMMANDS[20];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'carr'
procedure TForm1.MenuItem19Click(Sender: TObject);
begin
  menucmd := COMMANDS[105];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'varr'
procedure TForm1.MenuItem51Click(Sender: TObject);
begin
  menucmd := COMMANDS[106];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// -- MAIN MENU/Utilities ------------------------------------------------------

// RUN COMMAND 'ascii dec'
procedure TForm1.MenuItem59Click(Sender: TObject);
begin
  menucmd := COMMANDS[79] + ' dec';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'ascii hex'
procedure TForm1.MenuItem60Click(Sender: TObject);
begin
  menucmd := COMMANDS[79] + ' hex';
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'date'
procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  menucmd := COMMANDS[9];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// RUN COMMAND 'conv' with DIALOG
procedure TForm1.MenuItem26Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LEdit1: TEdit;
  LLabel1: TLabel;
  LRadioGroup1: TRadiogroup;
  LRadioGroup2: TRadiogroup;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LEdit1 := TEdit.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LRadioGroup1 := TRadioGroup.Create(Form);
  LRadioGroup2 := TRadioGroup.Create(Form);
  for b := 0 to 3 do
  begin
    LRadioGroup1.Items.Add(NUM_SYS[b]);
    LRadioGroup2.Items.Add(NUM_SYS[b]);
  end;
  LRadioGroup1.ItemIndex := 1;
  LRadioGroup2.ItemIndex := 2;
  with Form do
  begin
    Caption := rmampdot(MenuItem26.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Position := poMainFormCenter;
  end;
  with LRadioGroup1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG66;
    Parent := Form;
    TabOrder := 0;
  end;
  with LRadioGroup2 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LRadioGroup1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG67;
    Parent := Form;
    TabOrder := 1;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG68;
    Parent := Form;
  end;
  with LEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup2;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form;
    TabOrder := 2;
    Width := 100;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup1;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 4;
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
    Caption := MSG69;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 3;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      menucmd := COMMANDS[17] + ' ' +
        NUM_SYS[LRadioGroup1.ItemIndex] + ' ' +
        NUM_SYS[LRadioGroup2.ItemIndex] + ' ' +
        LEdit1.Text;
      Memo1.Lines.Add(fullprompt + menucmd);
      parsingcommands(menucmd);
    end;
  end;
  FreeAndNil(Form);
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
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel3, LLabel4: TLabel;
  LEdit1: TEdit;
  LSpinEdit1: TSpinEdit;
  LThread1: TLThread;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LEdit1 := TEdit.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel3 := TLabel.Create(Form);
  LLabel4 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem16.Caption);
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
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel3;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 0;
  end;
  with LEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Parent := Form;
    TabOrder := 1;
    Width := 60;
  end;
  with LLabel3 do
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
  with LLabel4 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 3;
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
    Caption := MSG77;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 2;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      thrdcmd.c := 36;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit1.Value);
        if length(LEdit1.Text) > 0 then thrdcmd.p2 := '$' + LEdit1.Text else thrdcmd.p2 := '';
      menucmd := COMMANDS[thrdcmd.c] + ' ' + thrdcmd.p1 + ' ' + thrdcmd.p2;
    end;
    LThread1 := TLThread.Create(true);
    with LThread1 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form);
end;

// RUN COMMAND 'serwrite' with DIALOG
procedure TForm1.MenuItem50Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel3, LLabel4: TLabel;
  LEdit1: TEdit;
  LSpinEdit1: TSpinEdit;
  LThread2: TLThread;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LEdit1 := TEdit.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel3 := TLabel.Create(Form);
  LLabel4 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    Caption := rmampdot(MenuItem50.Caption);
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
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel3;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Parent := Form;
    TabOrder := 0;
  end;
  with LEdit1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Parent := Form;
    TabOrder := 1;
    Width := 250;
  end;
  with LLabel3 do
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
  with LLabel4 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit1;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74 +'/' + MSG75;
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
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 3;
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
    Caption := MSG76;
    ModalResult := mrOk;
    Parent := Form;
    TabOrder := 2;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
    begin
      thrdcmd.c := 37;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit1.Value);
      if boolisitvariable('$' + LEdit1.Text)
        then thrdcmd.p2 := '$' + LEdit1.Text
        else thrdcmd.p2 := '"' + LEdit1.Text + '"';
      menucmd := COMMANDS[thrdcmd.c] + ' ' + thrdcmd.p1 + ' ' + thrdcmd.p2;
    end;
    LThread2 := TLThread.Create(true);
    with LThread2 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form);
end;

// -- MAIN MENU/Help -----------------------------------------------------------

// RUN COMMAND 'help'
procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  menucmd := COMMANDS[3];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// OPEN ONLINE WIKI
procedure TForm1.MenuItem56Click(Sender: TObject);
var
  LProcess1: TProcess;
begin
  LProcess1 := TProcess.Create(Self);
  if length(BROWSER) > 0 then
  begin
    LProcess1.Executable := BROWSER;
    LProcess1.Parameters.Add('https://github.com/pozsarzs/modshell/wiki');
    try
      LProcess1.Execute;
    except
      ShowMessage(ERR38);
    end;
  end;
  LProcess1.Free;
end;

// OPEN HOMEPAGE
procedure TForm1.MenuItem57Click(Sender: TObject);
var
  LProcess1: TProcess;
begin
  LProcess1 := TProcess.Create(Self);
  if length(BROWSER) > 0 then
  begin
    LProcess1.Executable := BROWSER;
    LProcess1.Parameters.Add('https://pozsarzs.github.io/modshell/');
    try
      LProcess1.Execute;
    except
      ShowMessage(ERR38);
    end;
  end;
  LProcess1.Free;
end;

// OPEN GITHUB PROJECT PAGE
procedure TForm1.MenuItem58Click(Sender: TObject);
var
  LProcess1: TProcess;
begin
  LProcess1 := TProcess.Create(Self);
  if length(BROWSER) > 0 then
  begin
    LProcess1.Executable := BROWSER;
    LProcess1.Parameters.Add('https://github.com/pozsarzs/modshell');
    try
      LProcess1.Execute;
    except
      ShowMessage(ERR38);
    end;
  end;
  LProcess1.Free;
end;

// RUN COMMAND 'ver'
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  menucmd := COMMANDS[10];
  Memo1.Lines.Add(fullprompt + menucmd);
  parsingcommands(menucmd);
end;

// -- END OF THE MAIN MENU -----------------------------------------------------

// RUN A COMMAND
procedure TForm1.ComboBox1EditingDone(Sender: TObject);
begin
  menucmd := ComboBox1.Text;
  Memo1.Lines.Add(fullprompt + menucmd);
  if length(ComboBox1.Text) > 0 then
  begin
    ComboBox1.Items.Add(menucmd);
    ComboBox1.Text := '';
    if menucmd = COMMANDS[1] then Form1.Close else
    begin
      parsingcommands(menucmd);
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
