{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmtccn.pas                                                              | }
{ | mini TCP console window                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC} {$H+} {$MACRO ON}

unit frmtccn;
interface
uses
  BlckSock,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  Forms,
  Menus,
  StdCtrls,
  SysUtils,
  convert,
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
    function thr_tcpcons(p1: byte): byte;
  end;
  { TForm4 }
  TForm4 = class(TForm)
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    Separator1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private
  public
  end;
var
  Form4: TForm4;
  device: byte;
  keyprd: boolean;
  prdkey: char;

{$DEFINE X}

{$I define.pas}

implementation
uses frmmain;

{$R *.lfm}

{$I network.pas}

{$I thr_tccn.pas}

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form4.Memo1.Text := Form4.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
  exitcode := thr_tcpcons(device);
  Form4.Close;
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  inherited Create(CreateSuspended);
end;

{ TForm4 }

// SEND A CHAR
procedure TForm4.FormKeyPress(Sender: TObject; var Key: char);
begin
  keyprd := true;
  prdkey := Key;
end;

// -- MAIN MENU/File -----------------------------------------------------------

// CLOSE WINDOW
procedure TForm4.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

// -- MAIN MENU/Operation ------------------------------------------------------

// RUN COMMAND 'cls'
procedure TForm4.MenuItem4Click(Sender: TObject);
begin
  Memo1.Clear;
end;

// RUN COMMAND 'inputmeth swap'
procedure TForm4.MenuItem6Click(Sender: TObject);
begin
  Form1.MenuItem76.OnClick(Sender);
end;

// RUN COMMAND 'echometh swap'
procedure TForm4.MenuItem5Click(Sender: TObject);
begin
  Form1.MenuItem28.OnClick(Sender);
end;

// RUN COMMAND 'sendmeth swap'
procedure TForm4.MenuItem8Click(Sender: TObject);
begin
  Form1.MenuItem77.OnClick(Sender);
end;

// -- END OF THE MAIN MENU -----------------------------------------------------

procedure TForm4.FormShow(Sender: TObject);
var
  LThread1: TLThread;
  begin
    if dev[device].valid then
      if dev[device].devtype = 0 then
      begin
        with StatusBar1.Panels do
        begin
          Items[3].Text := dev[device].device;
          Items[4].Text := dev[device].ipaddress + ':' + inttostr(dev[device].port);
        end;
      end;
    // new threads for I/O operation
    LThread1 := TLThread.Create(True);
    with LThread1 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
end;

// CLOSE MINI TCP CONSOLE WINDOW
procedure TForm4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form4 do
  begin
    formpositions[4, 0] := Top;
    formpositions[4, 1] := Left;
    formpositions[4, 2] := Height;
    formpositions[4, 3] := Width;
  end;
  keyprd := true;
  prdkey := #27;
  sleep(3000);
  CanClose := true;
end;

// CREATE MINI TCP CONSOLE WINDOW
procedure TForm4.FormCreate(Sender: TObject);
begin
  KeyPreview := true;
  // restore window size and position
  with Form4 do
  begin
    Top := formpositions[4, 0];
    Left := formpositions[4, 1];
    if formpositions[4, 2] > 120 then Height := formpositions[4, 2];
    if formpositions[4, 3] > 160 then Width := formpositions[4, 3];
  end;
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
end;

end.

