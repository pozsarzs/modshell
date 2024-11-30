{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-set_protocols.pas                                   | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'set pro? ...' WITH DIALOG
// change protocol number
procedure TForm1.LSpinEdit401Change(Sender: TObject);
var
  LComboBox401: TComboBox;
  LSpinEdit402: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LComboBox401 := TComboBox(TForm(TSpinEdit(Sender).Parent).FindComponent('LComboBox401'));
    LSpinEdit402 := TSpinEdit(TForm(TSpinEdit(Sender).Parent).FindComponent('LSpinEdit402'));
    if assigned(LComboBox401) and prot[TSpinEdit(Sender).Value].valid
      then LComboBox401.ItemIndex := prot[TSpinEdit(Sender).Value].prottype
      else LComboBox401.ItemIndex := 0;
    if assigned(LSpinEdit402) and prot[TSpinEdit(Sender).Value].valid
      then LSpinEdit402.Value := prot[TSpinEdit(Sender).Value].id
      else LSpinEdit402.Value := 1;
  end;
end;

procedure TForm1.MenuItem40Click(Sender: TObject);
var
  Form401: TForm;
  LBevel401: TBevel;
  LButton401, LButton402: TButton;
  LComboBox401: TComboBox;
  LLabel401, LLabel402, LLabel403, LLabel404: TLabel;
  LSpinEdit401, LSpinEdit402: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form401 := TForm.Create(Nil);
  LBevel401 := TBevel.Create(Form401);
  LButton401 := TButton.Create(Form401);
  LButton402 := TButton.Create(Form401);
  LComboBox401 := TComboBox.Create(Form401);
  LLabel401 := TLabel.Create(Form401);
  LLabel402 := TLabel.Create(Form401);
  LLabel403 := TLabel.Create(Form401);
  LLabel404 := TLabel.Create(Form401);
  LSpinEdit401 := TSpinEdit.Create(Form401);
  LSpinEdit402 := TSpinEdit.Create(Form401);
  with Form401 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem40.Caption);
    Name := 'Form401';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel401 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'pro';
    Font.Style := [fsBold];
    Name := 'LLabel401';
    Parent := Form401;
  end;
  with LSpinEdit401 do  // protocol
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel402;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LLabel401';
    Parent := Form401;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
    OnChange := @LSpinEdit401Change;
  end;
  with LComboBox401 do  // protocol type
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      for b:= 0 to 4 do Items.Add(PROT_TYPE[b]);
    if prot[LSpinEdit401.Value].valid
      then ItemIndex := prot[LSpinEdit401.Value].prottype
      else ItemIndex := 0;
    Name := 'LComboBox401';
    Parent := Form401;
    ReadOnly := true;
    TabOrder := 1;
  end;
  with LSpinEdit402 do  // unit ID or address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox401;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 0;
    if LComboBox401.ItemIndex < 3
      then MaxValue := 247
      else MaxValue := 255;
    Name := 'LSpinEdit402';
    if prot[LSpinEdit401.Value].valid
      then Value := prot[LSpinEdit401.Value].id
      else Value := 1;
    Parent := Form401;
    TabOrder := 2;
    Width := 75;
  end;
  with LLabel402 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox401;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Name := 'LLabel402';
    Parent := Form401;
  end;
  with LLabel403 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit402;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG56;
    Name := 'LLabel403';
    Parent := Form401;
  end;
  with LLabel404 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel404';
    Parent := Form401;
  end;
  with LBevel401 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit401;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form401;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel401';
    Parent := Form401;
    Shape := bsTopLine;
  end;
  with LButton401 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton402;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton401';
    Parent := Form401;
    TabOrder := 4;
  end;
  with LButton402 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel401;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form401;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton402';
    Parent := Form401;
    TabOrder := 3;
  end;
  if Form401.ShowModal = mrOk then
  begin
    with Form401 do
      cmd := COMMANDS[8] + ' pro' +
        inttostr(LSpinEdit401.Value) + ' ' +
        LComboBox401.Items[LComboBox401.ItemIndex] + ' ' +
        inttostr(LSpinEdit402.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form401);
end;
