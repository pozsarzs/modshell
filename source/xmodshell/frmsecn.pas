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
  Graphics,
  SysUtils,
  ucommon,
  uconfig;
type
  { TLThread }
  TLThread = class(TThread)
  protected
    procedure Execute; override;
  end;
  { TForm3 }
  TForm3 = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form3: TForm3;

implementation
uses frmmain;

{$R *.lfm}

{ TForm3 }

// RUN I/O OPERATION ON NEW THREAD
procedure TLThread.Execute;
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
    // disable variable monitor
    varmon := false;
  end;
  CanClose := true;
end;

// SHOW MINI SERIAL CONSOLE WINDOW
procedure TForm3.FormCreate(Sender: TObject);
var
  LThread1: TLThread;
begin
  // restore window size and position
  with Form3 do
  begin
    Top := formpositions[2, 0];
    Left := formpositions[2, 1];
    if formpositions[2, 2] > 120 then Height := formpositions[1, 2];
    if formpositions[2, 3] > 160 then Width := formpositions[1, 3];
  end;
  // new thread for I/O operation
  LThread1 := TLThread.Create(True);
  LThread1.Start;
end;

end.

