{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-mini_tcp_console.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'tcpcons' with DIALOG
procedure TForm1.MenuItem55Click(Sender: TObject);
var
  Form551: TForm;
  LBevel551: TBevel;
  LButton551, LButton552: TButton;
  LLabel551, LLabel552: TLabel;
  LSpinEdit551: TSpinEdit;
begin
  Form551 := TForm.Create(Nil);
  LBevel551 := TBevel.Create(Form551);
  LButton551 := TButton.Create(Form551);
  LButton552 := TButton.Create(Form551);
  LLabel551 := TLabel.Create(Form551);
  LLabel552 := TLabel.Create(Form551);
  LSpinEdit551 := TSpinEdit.Create(Form551);
  with Form551 do
  begin
    Caption := rmampdot(MenuItem55.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form551';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel551 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit551;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form551;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel551';
    Parent := Form551;
  end;
  with LSpinEdit551 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel552;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel551;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel551;
      AnchorSideRight.Side := asrRight;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit551';
    Parent := Form551;
    TabOrder := 0;
  end;
  with LLabel552 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form551;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel551;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit551;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel552';
    Parent := Form551;
  end;
  with LBevel551 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit551;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form551;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form551;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel551';
    Parent := Form551;
    Shape := bsTopLine;
  end;
  with LButton551 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel551;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton552;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton551';
    Parent := Form551;
    TabOrder := 2;
  end;
  with LButton552 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel551;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form551;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG70;
    ModalResult := mrOk;
    Name := 'LButton552';
    Parent := Form551;
    TabOrder := 1;
  end;
  if Form551.ShowModal = mrOk then
  begin
    frmsecn.device := LSpinEdit551.Value;
    with Form4 do
    begin
      Show;
      Caption := rmampdot(MenuItem55.Caption);
      StatusBar1.Panels[0].Text := Form1.StatusBar1.Panels[0].Text;
    end;
  end;
  FreeAndNil(Form551);
end; 
