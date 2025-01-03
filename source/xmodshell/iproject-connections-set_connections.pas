{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-set_connections.pas                                 | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'set con? ...' WITH DIALOG
// set connection number
procedure TForm1.LSpinEdit411Change(Sender: TObject);
var
  LSpinEdit412, LSpinEdit413: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LSpinEdit412 :=
      TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit412'));
    LSpinEdit413 :=
      TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit413'));
    if assigned(LSpinEdit412) and conn[TSpinEdit(Sender).Value].valid
      then LSpinEdit412.Value := conn[TSpinEdit(Sender).Value].dev
      else LSpinEdit412.Value := 0;
    if assigned(LSpinEdit413) and conn[TSpinEdit(Sender).Value].valid
      then LSpinEdit413.Value := conn[TSpinEdit(Sender).Value].prot
      else LSpinEdit413.Value := 0;
  end;
end;

procedure TForm1.MenuItem41Click(Sender: TObject);
var
  Form411: TForm;
  LBevel411: TBevel;
  LButton411, LButton412: TButton;
  LLabel411, LLabel412, LLabel413, LLabel414, LLabel415, LLabel416: TLabel;
  LSpinEdit411, LSpinEdit412, LSpinEdit413: TSpinEdit;
  cmd: string;
begin
  Form411 := TForm.Create(Nil);
  LBevel411 := TBevel.Create(Form411);
  LButton411 := TButton.Create(Form411);
  LButton412 := TButton.Create(Form411);
  LLabel411 := TLabel.Create(Form411);
  LLabel412 := TLabel.Create(Form411);
  LLabel413 := TLabel.Create(Form411);
  LLabel414 := TLabel.Create(Form411);
  LLabel415 := TLabel.Create(Form411);
  LLabel416 := TLabel.Create(Form411);
  LSpinEdit411 := TSpinEdit.Create(Form411);
  LSpinEdit412 := TSpinEdit.Create(Form411);
  LSpinEdit413 := TSpinEdit.Create(Form411);
  with Form411 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem41.Caption);
    Name := 'Form411';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel411 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel411';
    Parent := Form411;
  end;
  with LSpinEdit411 do  // connection
  begin
    Anchors := [akTop, akLeft];
    AnchorSideTop.Control := LLabel414;
    AnchorSideTop.Side := asrBottom;
    BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel411;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit411';
    Parent := Form411;
    TabOrder := 0;
    Value := 0;
    OnChange := @LSpinEdit411Change;
  end;
  with LLabel412 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit411;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'dev';
    Name := 'LLabel412';
    Parent := Form411;
  end;
  with LSpinEdit412 do  // device
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel412;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit412';
    Parent := Form411;
    TabOrder := 1;
    if conn[LSpinEdit411.Value].valid
      then Value := conn[LSpinEdit411.Value].dev
      else Value := 0;
  end;
  with LLabel413 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit412;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := 'pro';
    Name := 'LLabel413';
    Parent := Form411;
  end;
  with LSpinEdit413 do  // protocol
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel413;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit413';
    Parent := Form411;
    TabOrder := 2;
    if conn[LSpinEdit411.Value].valid
      then Value := conn[LSpinEdit411.Value].prot
      else Value := 0;
  end;
  with LLabel414 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel414';
    Parent := Form411;
  end;
  with LLabel415 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel412;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit412;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Name := 'LLabel415';
    Parent := Form411;
  end;
  with LLabel416 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel413;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit413;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel416';
    Parent := Form411;
  end;
  with LBevel411 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit411;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form411;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form411;
    Name := 'LBevel411';
    Shape := bsTopLine;
  end;
  with LButton411 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton412;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton411';
    Parent := Form411;
    TabOrder := 4;
  end;
  with LButton412 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel411;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form411;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton412';
    Parent := Form411;
    TabOrder := 3;
  end;
  if Form411.ShowModal = mrOk then
  begin
    with Form411 do
      cmd := COMMANDS[8] +
      ' con' + inttostr(LSpinEdit411.Value) +
      ' dev' + inttostr(LSpinEdit412.Value) +
      ' pro' + inttostr(LSpinEdit413.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form411);
end;
