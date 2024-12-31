{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmvrmn.pas                                                              | }
{ | variable monitor window                                                  | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC} {$H+}

unit frmvrmn;
interface
uses
  Classes,
  Controls,
  Dialogs,
  Forms,
  Graphics,
  SysUtils,
  ValEdit,
  uconfig;
type
  { TForm2 }
  TForm2 = class(TForm)
    ValueListEditor1: TValueListEditor;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;
var
  Form2: TForm2;

implementation
uses frmmain;

{$R *.lfm}

{ TForm2 }

// CLOSE VARIABLE MONITOR WINDOW
procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form2 do
  begin
    formpositions[1, 0] := Top;
    formpositions[1, 1] := Left;
    formpositions[1, 2] := Height;
    formpositions[1, 3] := Width;
    // disable variable monitor
    varmon := false;
  end;
  CanClose := true;
end;

// SHOW VARIABLE MONITOR WINDOW
procedure TForm2.FormShow(Sender: TObject);
begin
  // enable variable monitor
  frmmain.varmon := true;
end;

// CREATE VARIABLE MONITOR WINDOW
procedure TForm2.FormCreate(Sender: TObject);
begin
  // restore window size and position
  with Form2 do
  begin
    Top := formpositions[1, 0];
    Left := formpositions[1, 1];
    if formpositions[1, 2] > 200 then Height := formpositions[1, 2];
    if formpositions[1, 3] > 150 then Width := formpositions[1, 3];
  end;
end;

end.

