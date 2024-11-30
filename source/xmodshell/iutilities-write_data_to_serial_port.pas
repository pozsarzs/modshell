{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-write_data_to_serial_port.pas                                 | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'serwrite' with DIALOG
procedure TForm1.MenuItem50Click(Sender: TObject);
var
  Form501: TForm;
  LBevel501: TBevel;
  LButton501, LButton502: TButton;
  LLabel501, LLabel503, LLabel504: TLabel;
  LEdit501: TEdit;
  LSpinEdit501: TSpinEdit;
  LThread501: TLThread;
begin
  Form501 := TForm.Create(Nil);
  LBevel501 := TBevel.Create(Form501);
  LButton501 := TButton.Create(Form501);
  LButton502 := TButton.Create(Form501);
  LEdit501 := TEdit.Create(Form501);
  LLabel501 := TLabel.Create(Form501);
  LLabel503 := TLabel.Create(Form501);
  LLabel504 := TLabel.Create(Form501);
  LSpinEdit501 := TSpinEdit.Create(Form501);
  with Form501 do
  begin
    Caption := rmampdot(MenuItem50.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form501';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel501';
    Parent := Form501;
  end;
  with LSpinEdit501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel503;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel501;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit501';
    Parent := Form501;
    TabOrder := 0;
  end;
  with LEdit501 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit501;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit501';
    Parent := Form501;
    TabOrder := 1;
    Width := 250;
    Clear;
  end;
  with LLabel503 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel503';
    Parent := Form501;
  end;
  with LLabel504 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74 +'/' + MSG75;
    Name := 'LLabel504';
    Parent := Form501;
  end;
  with LBevel501 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit501;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form501;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel501';
    Parent := Form501;
    Shape := bsTopLine;
  end;
  with LButton501 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton502;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton501';
    Parent := Form501;
    TabOrder := 3;
  end;
  with LButton502 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel501;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form501;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton502';
    Parent := Form501;
    TabOrder := 2;
  end;
  if Form501.ShowModal = mrOk then
  begin
    with Form501 do
    begin
      thrdcmd.c := 37;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit501.Value);
      if boolisitvariable(LEdit501.Text)
        then thrdcmd.p2 := LEdit501.Text
        else thrdcmd.p2 := '"' + LEdit501.Text + '"';
    end;
    LThread501 := TLThread.Create(true);
    with LThread501 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form501);
end;
