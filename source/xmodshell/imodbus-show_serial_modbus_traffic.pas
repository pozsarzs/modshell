{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-mini_serial_console.pas                                       | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'mbmon' with DIALOG
procedure TForm1.MenuItem79Click(Sender: TObject);
var
  Form791: TForm;
  LBevel791: TBevel;
  LButton791, LButton792: TButton;
  LLabel791, LLabel792: TLabel;
  LSpinEdit791: TSpinEdit;
begin
  Form791 := TForm.Create(Nil);
  LBevel791 := TBevel.Create(Form791);
  LButton791 := TButton.Create(Form791);
  LButton792 := TButton.Create(Form791);
  LLabel791 := TLabel.Create(Form791);
  LLabel792 := TLabel.Create(Form791);
  LSpinEdit791 := TSpinEdit.Create(Form791);
  with Form791 do
  begin
    Caption := rmampdot(MenuItem79.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form791';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel791 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit791;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form791;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel791';
    Parent := Form791;
  end;
  with LSpinEdit791 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel792;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel791;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel791;
      AnchorSideRight.Side := asrRight;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit791';
    Parent := Form791;
    TabOrder := 0;
  end;
  with LLabel792 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form791;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel791;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit791;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel792';
    Parent := Form791;
  end;
  with LBevel791 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit791;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form791;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form791;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel791';
    Parent := Form791;
    Shape := bsTopLine;
  end;
  with LButton791 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel791;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton792;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton791';
    Parent := Form791;
    TabOrder := 2;
  end;
  with LButton792 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel791;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form791;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG70;
    ModalResult := mrOk;
    Name := 'LButton792';
    Parent := Form791;
    TabOrder := 1;
  end;
  if Form791.ShowModal = mrOk then
  begin
    frmmbmn.connection := LSpinEdit791.Value;
    with Form6 do
    begin
      Show;
      Caption := rmampdot(MenuItem79.Caption);
    end;
  end;
  FreeAndNil(Form791);
end;
