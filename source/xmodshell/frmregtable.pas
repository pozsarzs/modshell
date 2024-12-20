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
  ucommon,
  uconfig;
type
  { TForm7 }
  TForm7 = class(TForm)
    ComboBox1: TComboBox;
    StringGrid1: TStringGrid;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CopyReg(direction: boolean; registertype: byte);
  private
  public
  end;

var
  Form7: TForm7;
  previi: byte;

implementation
uses frmmain;

{$R *.lfm}

// COPY DATA BETWEEN BUFFER AND STRINGGRID
procedure TForm7.CopyReg(direction: boolean; registertype: byte);
var
  x, y: integer;
begin
  for x := 1 to 99 do
    for y := 0 to 99 do
      case registertype of
        0: if direction
             then StringGrid1.Cells[x, y + 1] := inttostr(booltoint(frmmain.coil[x * 100 + y]))
             else coil[x * 100 + y] := inttobool(strtoint(StringGrid1.Cells[x, y + 1]));
        1: if direction
             then StringGrid1.Cells[x, y + 1] := inttostr(booltoint(dinp[x * 100 + y]))
             else dinp[x * 100 + y] := inttobool(strtoint(StringGrid1.Cells[x, y + 1]));
        2: if direction
             then StringGrid1.Cells[x, y + 1] := inttostr(ireg[x * 100 + y])
             else ireg[x * 100 + y] := strtoint(StringGrid1.Cells[x, y + 1]);
        3: if direction
             then StringGrid1.Cells[x, y + 1] := inttostr(hreg[x * 100 + y])
             else hreg[x * 100 + y] := strtoint(StringGrid1.Cells[x, y + 1]);
      end;
end;

// SHOW REGISTER TABLE WINDOW
procedure TForm7.FormShow(Sender: TObject);
begin
  CopyReg(true, previi);
end;

// CLOSE REGISTER TABLE WINDOW
procedure TForm7.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CopyReg(false, previi);
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

// COMBOBOX1 ONCHANGE EVENT
procedure TForm7.ComboBox1Change(Sender: TObject);
begin
  CopyReg(false, previi);
  CopyReg(true, ComboBox1.ItemIndex);
  previi := ComboBox1.ItemIndex;
end;

// CREATE REGISTER TABLE WINDOW
procedure TForm7.FormCreate(Sender: TObject);
var
  x, y: byte;
begin
  // restore window size and position
  with Form7 do
  begin
    Top := formpositions[7, 0];
    Left := formpositions[7, 1];
    if formpositions[7, 2] > 120 then Height := formpositions[7, 2];
    if formpositions[7, 3] > 160 then Width := formpositions[7, 3];
  end;
  with StringGrid1 do
  begin
    for x := 1 to 99 do
      Cells[x, 0] :=  'xx' + addsomezero(2, inttostr(x));
    for y := 0 to 99 do
      Cells[0, y + 1] := addsomezero(2, inttostr(y)) + 'xx';
  end;
  ComboBox1.ItemIndex := 0;
  previi := ComboBox1.ItemIndex;
end;

end.
