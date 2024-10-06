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
{$mode ObjFPC}{$H+}
interface
uses
  Classes,
  Controls,
  Dialogs,
  Forms,
  Graphics, StdCtrls,
  SysUtils,
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
  end;
  { TForm3 }
  TForm3 = class(TForm)
    Memo1: TMemo;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
  public
  end;
var
  Form3: TForm3;
  device: byte;

implementation
uses frmmain;

{$R *.lfm}

{ TLThread }

// ADD TEXT TO MEMO1 FROM OTHER THREAD
procedure TLThread.ShowStatus;
begin
  Form1.Memo1.Text := Form1.Memo1.Text + fStatusText;
end;

// RUN A COMMAND ON NEW THREAD
procedure TLThread.Execute;
begin
end;

// CREATE THREAD
constructor TLThread.Create(CreateSuspended: boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;

{ TForm3 }

// SEND A CHAR
procedure TForm3.FormKeyPress(Sender: TObject; var Key: char);
begin

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
  CanClose := true;
end;

// SHOW MINI SERIAL CONSOLE WINDOW
procedure TForm3.FormCreate(Sender: TObject);
var
  LThreadRX, LThreadTX: TLThread;
begin
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
  // new threads for I/O operation
  LThreadRX := TLThread.Create(True);
  LThreadTX := TLThread.Create(True);
  with LThreadRX do
  begin
    FreeOnTerminate := true;
    Start;
  end;
  with LThreadTX do
  begin
    FreeOnTerminate := true;
    Start;
  end;
end;

end.

