{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | frmregtable.pas                                                          | }
{ | Register table window                                                    | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

unit frmregtable;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes,
  Controls,
  Dialogs,
  Forms,
  Graphics,
  Grids,
  StdCtrls,
  SysUtils,
  uconfig;
type
  { TForm7 }
  TForm7 = class(TForm)
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}

// CLOSE REGISTER TABLE WINDOW
procedure TForm7.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save window size and position
  with Form7 do
  begin
    formpositions[7, 0] := Top;
    formpositions[7, 1] := Left;
    formpositions[7, 2] := Height;
    formpositions[7, 3] := Width;
  end;
  CanClose := true;
end;

// SHOW REGISTER TABLE WINDOW
procedure TForm7.FormCreate(Sender: TObject);
begin
  // restore window size and position
  with Form7 do
  begin
    Top := formpositions[7, 0];
    Left := formpositions[7, 1];
    if formpositions[7, 2] > 120 then Height := formpositions[7, 2];
    if formpositions[7, 3] > 160 then Width := formpositions[7, 3];
  end;
end;

end.
