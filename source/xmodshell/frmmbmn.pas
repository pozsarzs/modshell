{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmmbmn.pas                                                              | }
{ | serial Modbus traffic monitor window                                     | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}{$MACRO ON}

unit frmmbmn;
interface
uses
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  Forms,
  Menus,
  StdCtrls,
  SysUtils,
  convert,
  synaser,
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
    function thr_mbmon(p1: byte): byte;
  end;
  { TForm6 }
  TForm6 = class(TForm)
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private
  public
  end;
var
  Form6: TForm6;
  connection: byte;
  keyprd: boolean;
  prdkey: char;

{$DEFINE X}

{$I define.pas}

implementation
uses frmmain;

{$R *.lfm}

{$I lockfile.pas}
{$I serport.pas}
{$I mbutil.pas}
{$I thr_mbmn.pas}

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form6.Memo1.Text := Form6.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
  exitcode := thr_mbmon(connection);
  Form6.Close;
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  inherited Create(CreateSuspended);
end;

{ TForm6 }

// SEND A CHAR
procedure TForm6.FormKeyPress(Sender: TObject; var Key: char);
begin
  keyprd := true;
  prdkey := Key;
end;

// -- MAIN MENU/File -----------------------------------------------------------

// CLOSE WINDOW
procedure TForm6.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

// -- MAIN MENU/Operation ------------------------------------------------------

// RUN COMMAND 'cls'
procedure TForm6.MenuItem4Click(Sender: TObject);
begin
  Memo1.Clear;
end;

// -- END OF THE MAIN MENU -----------------------------------------------------

// SHOW CONSOLE WINDOW
procedure TForm6.FormShow(Sender: TObject);
var
  LThread1: TLThread;
begin
  if conn[connection].valid then
    if dev[conn[connection].dev].devtype = 1 then
    begin
      with StatusBar1.Panels do
      begin
        Items[3].Text := dev[conn[connection].dev].device;
        Items[4].Text := DEV_SPEED[dev[conn[connection].dev].speed] + ' baud '+
        inttostr(dev[conn[connection].dev].databit) +
        upcase(DEV_PARITY[dev[conn[connection].dev].parity]) +
        inttostr(dev[conn[connection].dev].stopbit);
        Items[5].Text := upcase(PROT_TYPE[prot[conn[connection].prot].prottype]) +
        ' #' + inttostr(prot[conn[connection].prot].id);
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

// CLOSE CONSOLE WINDOW
procedure TForm6.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form6 do
  begin
    formpositions[6, 0] := Top;
    formpositions[6, 1] := Left;
    formpositions[6, 2] := Height;
    formpositions[6, 3] := Width;
  end;
  keyprd := true;
  prdkey := #27;
  sleep(3000);
  CanClose := true;
end;

// CREATE MINI SERIAL CONSOLE WINDOW
procedure TForm6.FormCreate(Sender: TObject);
begin
  KeyPreview := true;
  // restore window size and position
  with Form6 do
  begin
    Top := formpositions[6, 0];
    Left := formpositions[6, 1];
    if formpositions[6, 2] > 120 then Height := formpositions[6, 2];
    if formpositions[6, 3] > 160 then Width := formpositions[6, 3];
  end;
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
end;

end.

