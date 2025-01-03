{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-read_data_from_serial_port.pas                                | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'serread' with DIALOG
procedure TForm1.MenuItem16Click(Sender: TObject);
var
  Form161: TForm;
  LBevel161: TBevel;
  LButton161, LButton162: TButton;
  LLabel161, LLabel163, LLabel164: TLabel;
  LEdit161: TEdit;
  LSpinEdit161: TSpinEdit;
  LThread161: TLThread;
begin
  Form161 := TForm.Create(Nil);
  LBevel161 := TBevel.Create(Form161);
  LButton161 := TButton.Create(Form161);
  LButton162 := TButton.Create(Form161);
  LEdit161 := TEdit.Create(Form161);
  LLabel161 := TLabel.Create(Form161);
  LLabel163 := TLabel.Create(Form161);
  LLabel164 := TLabel.Create(Form161);
  LSpinEdit161 := TSpinEdit.Create(Form161);
  with Form161 do
  begin
    Caption := rmampdot(MenuItem16.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form161';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel161';
    Parent := Form161;
  end;
  with LSpinEdit161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel163;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel161;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit161';
    Parent := Form161;
    TabOrder := 0;
  end;
  with LEdit161 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit161;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit161';
    Parent := Form161;
    TabOrder := 1;
    Width := 60;
    Clear;
  end;
  with LLabel163 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel163';
    Parent := Form161;
  end;
  with LLabel164 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74;
    Name := 'LLabel164';
    Parent := Form161;
  end;
  with LBevel161 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit161;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form161;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel161';
    Parent := Form161;
    Shape := bsTopLine;
  end;
  with LButton161 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton162;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton161';
    Parent := Form161;
    TabOrder := 3;
  end;
  with LButton162 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel161;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form161;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton162';
    Parent := Form161;
    TabOrder := 2;
  end;
  if Form161.ShowModal = mrOk then
  begin
    with Form161 do
    begin
      thrdcmd.c := 36;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit161.Value);
        if length(LEdit161.Text) > 0
          then thrdcmd.p2 := LEdit161.Text
          else thrdcmd.p2 := '';
    end;
    LThread161 := TLThread.Create(true);
    with LThread161 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form161);
end;

