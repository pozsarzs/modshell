{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-write_data_with_tcp.pas                                       | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'tcpwrite' with DIALOG
procedure TForm1.MenuItem65Click(Sender: TObject);
var
  Form651: TForm;
  LBevel651: TBevel;
  LButton651, LButton652: TButton;
  LLabel651, LLabel653, LLabel654: TLabel;
  LEdit651: TEdit;
  LSpinEdit651: TSpinEdit;
  LThread651: TLThread;
begin
  Form651 := TForm.Create(Nil);
  LBevel651 := TBevel.Create(Form651);
  LButton651 := TButton.Create(Form651);
  LButton652 := TButton.Create(Form651);
  LEdit651 := TEdit.Create(Form651);
  LLabel651 := TLabel.Create(Form651);
  LLabel653 := TLabel.Create(Form651);
  LLabel654 := TLabel.Create(Form651);
  LSpinEdit651 := TSpinEdit.Create(Form651);
  with Form651 do
  begin
    Caption := rmampdot(MenuItem65.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form651';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel651 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit651;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form651;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel651';
    Parent := Form651;
  end;
  with LSpinEdit651 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel653;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel651;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit651';
    Parent := Form651;
    TabOrder := 0;
  end;
  with LEdit651 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit651;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit651;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit651';
    Parent := Form651;
    TabOrder := 1;
    Width := 265;
    Clear;
  end;
  with LLabel653 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form651;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel651;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit651;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel653';
    Parent := Form651;
  end;
  with LLabel654 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form651;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit651;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit651;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74 +'/' + MSG75;
    Name := 'LLabel654';
    Parent := Form651;
  end;
  with LBevel651 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit651;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form651;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form651;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel651';
    Parent := Form651;
    Shape := bsTopLine;
  end;
  with LButton651 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel651;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton652;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton651';
    Parent := Form651;
    TabOrder := 3;
  end;
  with LButton652 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel651;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form651;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton652';
    Parent := Form651;
    TabOrder := 2;
  end;
  if Form651.ShowModal = mrOk then
  begin
    with Form651 do
    begin
      thrdcmd.c := 114;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit651.Value);
      if boolisitvariable(LEdit651.Text)
        then thrdcmd.p2 := LEdit651.Text
        else thrdcmd.p2 := '"' + LEdit651.Text + '"';
    end;
    LThread651 := TLThread.Create(true);
    with LThread651 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form651);
end;
