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

// RUN COMMAND 'tcpread' with DIALOG
procedure TForm1.MenuItem64Click(Sender: TObject);
var
  Form641: TForm;
  LBevel641: TBevel;
  LButton641, LButton642: TButton;
  LLabel641, LLabel643, LLabel644: TLabel;
  LEdit641: TEdit;
  LSpinEdit641: TSpinEdit;
  LThread641: TLThread;
begin
  Form641 := TForm.Create(Nil);
  LBevel641 := TBevel.Create(Form641);
  LButton641 := TButton.Create(Form641);
  LButton642 := TButton.Create(Form641);
  LEdit641 := TEdit.Create(Form641);
  LLabel641 := TLabel.Create(Form641);
  LLabel643 := TLabel.Create(Form641);
  LLabel644 := TLabel.Create(Form641);
  LSpinEdit641 := TSpinEdit.Create(Form641);
  with Form641 do
  begin
    Caption := rmampdot(MenuItem64.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form641';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel641 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit641;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form641;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel641';
    Parent := Form641;
  end;
  with LSpinEdit641 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel643;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel641;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit641';
    Parent := Form641;
    TabOrder := 0;
  end;
  with LEdit641 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit641;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit641;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Text := '';
    Name := 'LEdit641';
    Parent := Form641;
    TabOrder := 1;
    Width := 60;
    Clear;
  end;
  with LLabel643 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form641;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel641;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit641;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel643';
    Parent := Form641;
  end;
  with LLabel644 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form641;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit641;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LEdit641;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG74;
    Name := 'LLabel644';
    Parent := Form641;
  end;
  with LBevel641 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit641;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form641;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form641;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel641';
    Parent := Form641;
    Shape := bsTopLine;
  end;
  with LButton641 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel641;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton642;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton641';
    Parent := Form641;
    TabOrder := 3;
  end;
  with LButton642 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel641;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form641;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton642';
    Parent := Form641;
    TabOrder := 2;
  end;
  if Form641.ShowModal = mrOk then
  begin
    with Form641 do
    begin
      thrdcmd.c := 113;
      thrdcmd.p1 := 'dev' + inttostr(LSpinEdit641.Value);
        if length(LEdit641.Text) > 0
          then thrdcmd.p2 := LEdit641.Text
          else thrdcmd.p2 := '';
    end;
    LThread641 := TLThread.Create(true);
    with LThread641 do
    begin
      FreeOnTerminate := true;
      Start;
    end;
  end;
  FreeAndNil(Form641);
end;
