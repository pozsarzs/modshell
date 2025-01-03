{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iutilities-number_converter.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'conv' with DIALOG

// change numerical systems or input value
procedure TForm1.LEdit261Change(Sender: TObject);
var
  LEdit261, LEdit262: TEdit;
  LRadioGroup261, LRadioGroup262: TRadioGroup;
begin
  if (Sender is TEdit) or (Sender is TRadioGroup) then
  begin
    LEdit261 := TEdit(TForm(TEdit(Sender).Parent).FindComponent('LEdit261'));
    LEdit262 := TEdit(TForm(TEdit(Sender).Parent).FindComponent('LEdit262'));
    LRadioGroup261 :=
      TRadioGroup(TForm(TEdit(Sender).Parent).FindComponent('LRadioGroup261'));
    LRadioGroup262 :=
      TRadioGroup(TForm(TEdit(Sender).Parent).FindComponent('LRadioGroup262'));
    if (assigned(LEdit261)) and
       (assigned(LEdit262)) and
       (assigned(LRadioGroup261)) and
       (assigned(LRadioGroup262)) then
    begin
      if length(LEdit261.Text) > 0 then
      begin
        {
          y-axis: from (ns1)
          x-axis: to (ns2)

           |B  D  H  O
          -+-----------
          B|   01 02 03
          D|10    12 13
          H|20 21    23
          O|30 31 32
        }
        case (10 * LRadioGroup261.ItemIndex + LRadioGroup262.ItemIndex) of
          0: LEdit262.Text := BinToDez(DezToBin(LEdit261.Text));
          1: LEdit262.Text := BinToDez(LEdit261.Text);
          2: LEdit262.Text := BinToHex(LEdit261.Text);
          3: LEdit262.Text := BinToOkt(LEdit261.Text);
          10: LEdit262.Text := DezToBin(LEdit261.Text);
          11: LEdit262.Text := DezToHex(HexToDez(LEdit261.Text));
          12: LEdit262.Text := DezToHex(LEdit261.Text);
          13: LEdit262.Text := DezToOkt(LEdit261.Text);
          20: LEdit262.Text := HexToBin(LEdit261.Text);
          21: LEdit262.Text := HexToDez(LEdit261.Text);
          22: LEdit262.Text := HexToDez(DezToHex(LEdit261.Text));
          23: LEdit262.Text := HexToOkt(LEdit261.Text);
          30: LEdit262.Text := OktToBin(LEdit261.Text);
          31: LEdit262.Text := OktToDez(LEdit261.Text);
          32: LEdit262.Text := OktToHex(LEdit261.Text);
          33: LEdit262.Text := OktToDez(DezToOkt(LEdit261.Text));
        end;
      end else LEdit262.Clear;
    end;
  end;
end;

// change target variable
procedure TForm1.LEdit263Change(Sender: TObject);
var
  LButton262: TButton;
begin
  if Sender is TEdit then
  begin
    LButton262 := 
      TButton(TForm(TEdit(Sender).Parent).FindComponent('LButton262'));
    if assigned(LButton262) then
    begin
      if length(TEdit(Sender).Text) > 0
        then LButton262.Enabled := true
        else LButton262.Enabled := false;
    end;
  end;
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
var
  Form261: TForm;
  LBevel261: TBevel;
  LButton261, LButton262: TButton;
  LEdit261, LEdit262, LEdit263: TEdit;
  LRadioGroup261, LRadioGroup262: TRadiogroup;
  cmd: string;
begin
  Form261 := TForm.Create(Nil);
  LBevel261 := TBevel.Create(Form261);
  LButton261 := TButton.Create(Form261);
  LButton262 := TButton.Create(Form261);
  LEdit261 := TEdit.Create(Form261);
  LEdit262 := TEdit.Create(Form261);
  LEdit263 := TEdit.Create(Form261);
  LRadioGroup261 := TRadioGroup.Create(Form261);
  LRadioGroup262 := TRadioGroup.Create(Form261);
  for b := 0 to 3 do
  begin
    LRadioGroup261.Items.Add(NUM_SYS[b]);
    LRadioGroup262.Items.Add(NUM_SYS[b]);
  end;
  LRadioGroup261.ItemIndex := 1;
  LRadioGroup262.ItemIndex := 2;
  with Form261 do
  begin
    Caption := rmampdot(MenuItem26.Caption);
    AutoSize := True;
    BorderStyle := bsDialog;
    Name := 'Form261';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup261 do
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LEdit263;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := Form261;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG66;
    Name := 'LRadioGroup261';
    Parent := Form261;
    TabOrder := 0;
    OnSelectionChanged := @LEdit261Change;
  end;
  with LRadioGroup262 do
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LRadioGroup261;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := LRadioGroup261;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG67;
    Name := 'LRadioGroup262';
    Parent := Form261;
    TabOrder := 1;
    OnSelectionChanged := @LEdit261Change;
  end;
  with LEdit261 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Hint := MSG66;
    Name := 'LEdit261';
    Parent := Form261;
    TabOrder := 2;
    ShowHint := true;
    Width := 100;
    Clear;
    OnChange := @LEdit261Change;
  end;
  with LEdit262 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit261;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LEdit261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Hint := MSG67;
    Name := 'LEdit262';
    Parent := Form261;
    ReadOnly := True;
    ShowHint := true;
    TabOrder := 3;
    Clear;
  end;
  with LEdit263 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit262;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup262;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LEdit262;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Hint := MSG74;
    Name := 'LEdit263';
    Parent := Form261;
    ShowHint := true;
    TabOrder := 4;
    Clear;
    OnChange := @LEdit263Change;
  end;
  with LBevel261 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup261;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form261;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel261';
    Parent := Form261;
    Shape := bsTopLine;
  end;
  with LButton261 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton262;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton261';
    Parent := Form261;
    TabOrder := 6;
  end;
  with LButton262 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel261;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form261;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    Enabled := false;
    ModalResult := mrOk;
    Name := 'LButton262';
    Parent := Form261;
    TabOrder := 5;
  end;
  if Form261.ShowModal = mrOk then
    if length(LEdit263.Text) > 0 then
    begin
      with Form261 do
      begin
        cmd := COMMANDS[17] + ' ' +
          LEdit263.Text + ' ' +
          NUM_SYS[LRadioGroup261.ItemIndex] + ' ' +
          NUM_SYS[LRadioGroup262.ItemIndex] + ' ' +
          LEdit261.Text;
        Memo1.Lines.Add(fullprompt + cmd);
        parsingcommands(cmd);
      end;
    end;
  FreeAndNil(Form261);
end;
