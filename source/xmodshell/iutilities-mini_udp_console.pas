{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-mini_udp_console.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'udpcons' with DIALOG
procedure TForm1.MenuItem66Click(Sender: TObject);
var
  Form661: TForm;
  LBevel661: TBevel;
  LButton661, LButton662: TButton;
  LLabel661, LLabel662: TLabel;
  LSpinEdit661: TSpinEdit;
begin
  Form661 := TForm.Create(Nil);
  LBevel661 := TBevel.Create(Form661);
  LButton661 := TButton.Create(Form661);
  LButton662 := TButton.Create(Form661);
  LLabel661 := TLabel.Create(Form661);
  LLabel662 := TLabel.Create(Form661);
  LSpinEdit661 := TSpinEdit.Create(Form661);
  with Form661 do
  begin
    Caption := rmampdot(MenuItem66.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form661';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel661 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit661;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form661;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel661';
    Parent := Form661;
  end;
  with LSpinEdit661 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel662;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel661;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel661;
      AnchorSideRight.Side := asrRight;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit661';
    Parent := Form661;
    TabOrder := 0;
  end;
  with LLabel662 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form661;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel661;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit661;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel662';
    Parent := Form661;
  end;
  with LBevel661 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit661;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form661;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form661;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel661';
    Parent := Form661;
    Shape := bsTopLine;
  end;
  with LButton661 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel661;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton662;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton661';
    Parent := Form661;
    TabOrder := 2;
  end;
  with LButton662 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel661;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form661;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG70;
    ModalResult := mrOk;
    Name := 'LButton662';
    Parent := Form661;
    TabOrder := 1;
  end;
  if Form661.ShowModal = mrOk then
  begin
    frmsecn.device := LSpinEdit661.Value;
    with Form4 do
    begin
      Show;
      Caption := rmampdot(MenuItem66.Caption);
      StatusBar1.Panels[0].Text := Form1.StatusBar1.Panels[0].Text;
    end;
  end;
  FreeAndNil(Form661);
end;
