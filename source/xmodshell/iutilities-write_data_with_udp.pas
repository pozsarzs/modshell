{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-write_data_with_udp.pas                                       | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'udpwrite' with DIALOG
procedure TForm1.MenuItem68Click(Sender: TObject);
var
  Form681: TForm;
  LBevel681: TBevel;
  LButton681, LButton682: TButton;
  LLabel681, LLabel683, LLabel684: TLabel;
  LEdit681: TEdit;
  LSpinEdit681: TSpinEdit;
  LThread681: TLThread;
begin
  Form681 := TForm.Create(Nil);
  LBevel681 := TBevel.Create(Form681);
  LButton681 := TButton.Create(Form681);
  LButton682 := TButton.Create(Form681);
  LEdit681 := TEdit.Create(Form681);
  LLabel681 := TLabel.Create(Form681);
  LLabel683 := TLabel.Create(Form681);
  LLabel684 := TLabel.Create(Form681);
  LSpinEdit681 := TSpinEdit.Create(Form681);
  with Form681 do
  begin
    Caption := rmampdot(MenuItem68.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form681';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel681 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit681;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form681;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel681';
    Parent := Form681;
  end;
  with LSpinEdit681 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel683;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel681;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit681';
    Parent := Form681;
    TabOrder := 0;
  end;
  with LEdit681 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit681;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit681;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit681';
    Parent := Form681;
    TabOrder := 1;
    Width := 268;
    Clear;
  end;
  with LLabel683 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form681;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel681;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit681;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel683';
    Parent := Form681;
  end;
  with LLabel684 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form681;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit681;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit681;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74 +'/' + MSG75;
    Name := 'LLabel684';
    Parent := Form681;
  end;
  with LBevel681 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit681;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form681;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form681;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel681';
    Parent := Form681;
    Shape := bsTopLine;
  end;
  with LButton681 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel681;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton682;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton681';
    Parent := Form681;
    TabOrder := 3;
  end;
  with LButton682 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel681;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form681;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton682';
    Parent := Form681;
    TabOrder := 2;
  end;
  if Form681.ShowModal = mrOk then
  begin
    with Form681 do
    begin
      thrdcmd.c := 117;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit681.Value);
      if boolisitvariable(LEdit681.Text)
        then thrdcmd.p2 := LEdit681.Text
        else thrdcmd.p2 := '"' + LEdit681.Text + '"';
    end;
    LThread681 := TLThread.Create(true);
    with LThread681 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form681);
end; 
