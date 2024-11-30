{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-read_data_with_udp.pas                                        | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'udpread' with DIALOG
procedure TForm1.MenuItem67Click(Sender: TObject);
var
  Form671: TForm;
  LBevel671: TBevel;
  LButton671, LButton672: TButton;
  LLabel671, LLabel673, LLabel674: TLabel;
  LEdit671: TEdit;
  LSpinEdit671: TSpinEdit;
  LThread671: TLThread;
begin
  Form671 := TForm.Create(Nil);
  LBevel671 := TBevel.Create(Form671);
  LButton671 := TButton.Create(Form671);
  LButton672 := TButton.Create(Form671);
  LEdit671 := TEdit.Create(Form671);
  LLabel671 := TLabel.Create(Form671);
  LLabel673 := TLabel.Create(Form671);
  LLabel674 := TLabel.Create(Form671);
  LSpinEdit671 := TSpinEdit.Create(Form671);
  with Form671 do
  begin
    Caption := rmampdot(MenuItem67.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form671';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel671 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit671;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form671;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel671';
    Parent := Form671;
  end;
  with LSpinEdit671 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel673;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel671;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit671';
    Parent := Form671;
    TabOrder := 0;
  end;
  with LEdit671 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit671;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit671;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit671';
    Parent := Form671;
    TabOrder := 1;
    Width := 60;
    Clear;
  end;
  with LLabel673 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form671;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel671;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit671;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel673';
    Parent := Form671;
  end;
  with LLabel674 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form671;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit671;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit671;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74;
    Name := 'LLabel674';
    Parent := Form671;
  end;
  with LBevel671 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit671;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form671;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form671;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel671';
    Parent := Form671;
    Shape := bsTopLine;
  end;
  with LButton671 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel671;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton672;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton671';
    Parent := Form671;
    TabOrder := 3;
  end;
  with LButton672 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel671;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form671;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton672';
    Parent := Form671;
    TabOrder := 2;
  end;
  if Form671.ShowModal = mrOk then
  begin
    with Form671 do
    begin
      thrdcmd.c := 116;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit671.Value);
        if length(LEdit671.Text) > 0 then thrdcmd.p2 := LEdit671.Text else thrdcmd.p2 := '';
    end;
    LThread671 := TLThread.Create(true);
    with LThread671 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form671);
end; 
