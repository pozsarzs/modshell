{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmudcn.pas                                                              | }
{ | mini UDP console window                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

unit frmudcn;
{$MODE OBJFPC}{$H+}{$MACRO ON}
interface
uses
  BlckSock,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  Forms,
  StdCtrls,
  SysUtils,
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
    function thr_udpcons(p1: byte): byte;
  end;
  { TForm5 }
  TForm5 = class(TForm)
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
  public
  end;
var
  Form5: TForm5;
  device: byte;
  keyprd: boolean;
  prdkey: char;

{$DEFINE X}

{$I define.pas}

implementation
uses frmmain;

{$R *.lfm}

{$I network.pas}

{$I thr_udcn.pas}

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form5.Memo1.Text := Form5.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
  exitcode := thr_udpcons(device);
  Form5.Close;
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  inherited Create(CreateSuspended);
end;

{ TForm5 }

// SEND A CHAR
procedure TForm5.FormKeyPress(Sender: TObject; var Key: char);
begin
  keyprd := true;
  prdkey := Key;
end;

procedure TForm5.FormShow(Sender: TObject);
var
  LThread1: TLThread;
  begin
    if dev[device].valid then
      if dev[device].devtype = 0 then
      begin
        with StatusBar1.Panels do
        begin
          Items[1].Text := dev[device].device;
          Items[2].Text := dev[device].ipaddress + ':' + inttostr(dev[device].port);
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

// CLOSE MINI udp CONSOLE WINDOW
procedure TForm5.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form5 do
  begin
    formpositions[5, 0] := Top;
    formpositions[5, 1] := Left;
    formpositions[5, 2] := Height;
    formpositions[5, 3] := Width;
  end;
  keyprd := true;
  prdkey := #27;
  sleep(3000);
  CanClose := true;
end;

// SHOW MINI udp CONSOLE WINDOW
procedure TForm5.FormCreate(Sender: TObject);
begin
  KeyPreview := true;
  // restore window size and position
  with Form5 do
  begin
    Top := formpositions[5, 0];
    Left := formpositions[5, 1];
    if formpositions[5, 2] > 120 then Height := formpositions[5, 2];
    if formpositions[5, 3] > 160 then Width := formpositions[5, 3];
  end;
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
end;

end.
