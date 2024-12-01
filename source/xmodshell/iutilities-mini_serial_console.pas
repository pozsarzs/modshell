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

// RUN COMMAND 'sercons' with DIALOG
procedure TForm1.MenuItem54Click(Sender: TObject);
var
  Form541: TForm;
  LBevel541: TBevel;
  LButton541, LButton542: TButton;
  LLabel541, LLabel542: TLabel;
  LSpinEdit541: TSpinEdit;
begin
  Form541 := TForm.Create(Nil);
  LBevel541 := TBevel.Create(Form541);
  LButton541 := TButton.Create(Form541);
  LButton542 := TButton.Create(Form541);
  LLabel541 := TLabel.Create(Form541);
  LLabel542 := TLabel.Create(Form541);
  LSpinEdit541 := TSpinEdit.Create(Form541);
  with Form541 do
  begin
    Caption := rmampdot(MenuItem54.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form541';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel541 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit541;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form541;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel541';
    Parent := Form541;
  end;
  with LSpinEdit541 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel542;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel541;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel541;
      AnchorSideRight.Side := asrRight;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit541';
    Parent := Form541;
    TabOrder := 0;
  end;
  with LLabel542 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form541;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel541;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit541;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel542';
    Parent := Form541;
  end;
  with LBevel541 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit541;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form541;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form541;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel541';
    Parent := Form541;
    Shape := bsTopLine;
  end;
  with LButton541 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel541;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton542;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton541';
    Parent := Form541;
    TabOrder := 2;
  end;
  with LButton542 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel541;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form541;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG70;
    ModalResult := mrOk;
    Name := 'LButton542';
    Parent := Form541;
    TabOrder := 1;
  end;
  if Form541.ShowModal = mrOk then
  begin
    frmsecn.device := LSpinEdit541.Value;
    with Form3 do
    begin
      Show;
      Caption := rmampdot(MenuItem54.Caption);
      StatusBar1.Panels[0].Text := Form1.StatusBar1.Panels[0].Text;
      StatusBar1.Panels[1].Text := Form1.StatusBar1.Panels[1].Text;
    end;
  end;
  FreeAndNil(Form541);
end;
