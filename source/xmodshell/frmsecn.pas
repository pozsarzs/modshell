{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmsecn.pas                                                              | }
{ | mini serial console window                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

unit frmsecn;
{$MODE OBJFPC}{$H+}{$MACRO ON}
interface
uses
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
    function thr_sercons(p1: byte): byte;
  end;
  { TForm3 }
  TForm3 = class(TForm)
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
  Form3: TForm3;
  device: byte;
  keyprd: boolean;
  prdkey: char;

  {$DEFINE X}

{$I define.pas}

implementation
uses frmmain;

{$R *.lfm}

{$I lockfile.pas}
{$I serport.pas}

{$I thr_secn.pas}

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form3.Memo1.Text := Form3.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
  exitcode := thr_sercons(device);
  Form3.Close;
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  inherited Create(CreateSuspended);
end;

{ TForm3 }

// SEND A CHAR
procedure TForm3.FormKeyPress(Sender: TObject; var Key: char);
begin
  keyprd := true;
  prdkey := Key;
end;

procedure TForm3.FormShow(Sender: TObject);
var
  LThread1: TLThread;
  begin
    if dev[device].valid then
      if dev[device].devtype = 1 then
      begin
        with StatusBar1.Panels do
        begin
          Items[1].Text := dev[device].device;
          Items[2].Text := DEV_SPEED[dev[device].speed] + ' baud '+
          inttostr(dev[device].databit) +
          upcase(DEV_PARITY[dev[device].parity]) +
          inttostr(dev[device].stopbit);
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

// CLOSE MINI SERIAL CONSOLE WINDOW
procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form3 do
  begin
    formpositions[2, 0] := Top;
    formpositions[2, 1] := Left;
    formpositions[2, 2] := Height;
    formpositions[2, 3] := Width;
  end;
  keyprd := true;
  prdkey := #27;
  sleep(3000);
  CanClose := true;
end;

// SHOW MINI SERIAL CONSOLE WINDOW
procedure TForm3.FormCreate(Sender: TObject);
begin
  KeyPreview := true;
  // restore window size and position
  with Form3 do
  begin
    Top := formpositions[2, 0];
    Left := formpositions[2, 1];
    if formpositions[2, 2] > 120 then Height := formpositions[2, 2];
    if formpositions[2, 3] > 160 then Width := formpositions[2, 3];
  end;
  // set colors
  Memo1.Font.Color := uconfig.guicolors[0];
  Memo1.Color := uconfig.guicolors[1];
end;

end.

