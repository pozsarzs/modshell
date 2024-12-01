{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-set_devices.pas                                     | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'set dev? ...' WITH DIALOG
// set device number
procedure TForm1.LSpinEdit391Change(Sender: TObject);
var
  LComboBox391, LComboBox392, LComboBox393: TComboBox;
  LEdit391, LEdit392: TEdit;
  LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
begin
  if Sender is TSpinEdit then
  begin
    LComboBox391 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox391'));
    LComboBox392 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox392'));
    LComboBox393 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox393'));
    LEdit391 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit391'));
    LEdit392 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit392'));
    LSpinEdit392 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit392'));
    LSpinEdit393 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit393'));
    LSpinEdit394 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit394'));
    if assigned(LComboBox391) and dev[TSpinEdit(Sender).Value].valid
      then LComboBox391.ItemIndex := dev[TSpinEdit(Sender).Value].devtype
      else LComboBox391.ItemIndex := 1;
    LComboBox392.Enabled := inttobool(LComboBox391.ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
    if assigned(LEdit391) and dev[TSpinEdit(Sender).Value].valid
      then LEdit391.Text := dev[TSpinEdit(Sender).Value].device else
      begin
        LEdit391.Clear;
        {$IFDEF GO32V2} LEdit391.Text := 'COM1'; {$ENDIF}
        {$IFDEF LINUX} LEdit391.Text := '/dev/ttyS0'; {$ENDIF}
        {$IFDEF BSD} LEdit391.Text := '/dev/cuau0'; {$ENDIF}
        {$IFDEF WINDOWS} LEdit391.Text := 'COM1'; {$ENDIF}
      end;
    if assigned(LComboBox392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
      then LComboBox392.ItemIndex := dev[TSpinEdit(Sender).Value].speed
      else LComboBox392.ItemIndex := 6;
    if assigned(LSpinEdit392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
       then LSpinEdit392.Value := dev[TSpinEdit(Sender).Value].databit
      else LSpinEdit392.Value := 8;
    if assigned(LComboBox393) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 1)
      then LComboBox393.ItemIndex := dev[TSpinEdit(Sender).Value].parity
      else LComboBox393.ItemIndex := 1;
    if assigned(LSpinEdit393) and dev[TSpinEdit(Sender).Value].valid
      then LSpinEdit393.Value := dev[TSpinEdit(Sender).Value].stopbit
      else LSpinEdit393.Value := 0;
    if assigned(LEdit392) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 0)
      then LEdit392.Text := dev[TSpinEdit(Sender).Value].ipaddress
      else LEdit392.Text := '192.168.0.1';
    if assigned(LSpinEdit394) and dev[TSpinEdit(Sender).Value].valid and
       (dev[TSpinEdit(Sender).Value].devtype = 0)
      then LSpinEdit394.Value := dev[TSpinEdit(Sender).Value].stopbit
      else LSpinEdit394.Value := 502;
  end;
end;

// change device type
procedure TForm1.LComboBox391Change(Sender: TObject);
var
  LComboBox392, LComboBox393: TComboBox;
  LEdit392: TEdit;
  LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
begin
  if Sender is TCombobox then
  begin
    LComboBox392 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox392'));
    LComboBox393 := TComboBox(TForm(TComboBox(Sender).Parent).FindComponent('LComboBox393'));
    LEdit392 := TEdit(TForm(TComboBox(Sender).Parent).FindComponent('LEdit392'));
    LSpinEdit392 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit392'));
    LSpinEdit393 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit393'));
    LSpinEdit394 := TSpinEdit(TForm(TComboBox(Sender).Parent).FindComponent('LSpinEdit394'));
    LComboBox392.Enabled := inttobool(TComboBox(Sender).ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
  end;
end;

procedure TForm1.MenuItem39Click(Sender: TObject);
var
  Form391: TForm;
  LBevel391: TBevel;
  LButton391, LButton392: TButton;
  LComboBox391, LComboBox392, LComboBox393: TComboBox;
  LEdit391, LEdit392: TEdit;
  LLabel391, LLabel392, LLabel393, LLabel394, LLabel395, LLabel396, LLabel397, LLabel398: TLabel;
  LSpinEdit391, LSpinEdit392, LSpinEdit393, LSpinEdit394: TSpinEdit;
  cmd: string;
  b: byte;
begin
  Form391 := TForm.Create(Nil);
  LBevel391 := TBevel.Create(Form391);
  LButton391 := TButton.Create(Form391);
  LButton392 := TButton.Create(Form391);
  LComboBox391 := TComboBox.Create(Form391);
  LComboBox392 := TComboBox.Create(Form391);
  LComboBox393 := TComboBox.Create(Form391);
  LEdit391 := TEdit.Create(Form391);
  LEdit392 := TEdit.Create(Form391);
  LLabel391 := TLabel.Create(Form391);
  LLabel392 := TLabel.Create(Form391);
  LLabel393 := TLabel.Create(Form391);
  LLabel394 := TLabel.Create(Form391);
  LLabel395 := TLabel.Create(Form391);
  LLabel396 := TLabel.Create(Form391);
  LLabel397 := TLabel.Create(Form391);
  LLabel398 := TLabel.Create(Form391);
  LSpinEdit391 := TSpinEdit.Create(Form391);
  LSpinEdit392 := TSpinEdit.Create(Form391);
  LSpinEdit393 := TSpinEdit.Create(Form391);
  LSpinEdit394 := TSpinEdit.Create(Form391);
  with Form391 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem39.Caption);
    Name := 'Form391';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel391 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'dev';
    Font.Style := [fsBold];
    Name := 'LLabel391';
    Parent := Form391;
  end;
  with LSpinEdit391 do  // device number
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 20;
      AnchorSideLeft.Control := LLabel391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form391;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit391';
    TabOrder := 0;
    OnChange := @LSpinEdit391Change;
  end;
  with LComboBox391 do  // device type
  begin
    AutoSize := true;
    AutoComplete:= true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    for b := 0 to 1 do Items.Add(DEV_TYPE[b]);
    if dev[LSpinEdit391.Value].valid
      then ItemIndex := dev[LSpinEdit391.Value].devtype
      else ItemIndex := 1;
    LComboBox392.Enabled := inttobool(ItemIndex);
    LComboBox393.Enabled := LComboBox392.Enabled;
    LEdit392.Enabled := not LComboBox392.Enabled;
    LSpinEdit392.Enabled := LComboBox392.Enabled;
    LSpinEdit393.Enabled := LComboBox392.Enabled;
    LSpinEdit394.Enabled := not LComboBox392.Enabled;
    Name := 'LComboBox391';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 1;
    OnChange := @LComboBox391Change;
  end;
  with LEdit391 do  // device name
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Parent := Form391;
    TabOrder := 2;
    Name := 'LEdit391';
    if dev[LSpinEdit391.Value].valid
      then Text := dev[LSpinEdit391.Value].device else
      begin
        Clear;
        {$IFDEF GO32V2} Text := 'COM1'; {$ENDIF}
        {$IFDEF LINUX} Text := '/dev/ttyS0'; {$ENDIF}
        {$IFDEF BSD} Text := '/dev/cuau0'; {$ENDIF}
        {$IFDEF WINDOWS} Text := 'COM1'; {$ENDIF}
      end;
    Width := 100;
  end;
  with LComboBox392 do  // baudrate
  begin
    AutoComplete:= true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LEdit391;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    for b := 0 to 10 do Items.Add(DEV_SPEED[b]);
    if dev[LSpinEdit391.Value].valid and
       (dev[LSpinEdit391.Value].devtype = 1)
      then ItemIndex := dev[LSpinEdit391.Value].speed
      else ItemIndex := 6;
    Name := 'LComboBox392';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 3;
    Width := 120;
  end;
  with LSpinEdit392 do  // databits
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 7;
    Name := 'LSpinEdit392';
    Parent := Form391;
    MinValue := 7;
    MaxValue := 8;
    if dev[LSpinEdit391.Value].valid and
      (dev[LSpinEdit391.Value].devtype = 1)
      then Value := dev[LSpinEdit391.Value].databit
      else Value := 8;
    TabOrder := 4;
    Width := 60;
  end;
  with LComboBox393 do  // parity
  begin
    AutoComplete:= true;
    AutoSize := true;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    for b := 0 to 2 do Items.Add(upcase(DEV_PARITY[b]));
    if dev[LSpinEdit391.Value].valid and
      (dev[LSpinEdit391.Value].devtype = 1)
      then ItemIndex := dev[LSpinEdit391.Value].parity
      else ItemIndex := 1;
    Name := 'LComboBox393';
    Parent := Form391;
    ReadOnly := true;
    TabOrder := 5;
  end;
  with LSpinEdit393 do  // stopbits
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit391;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LComboBox393;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Name := 'LSpinEdit393';
    Parent := Form391;
    MinValue := 1;
    MaxValue := 2;
    if dev[LSpinEdit391.Value].valid and
    (dev[LSpinEdit391.Value].devtype = 1)
      then Value := dev[LSpinEdit391.Value].stopbit
      else Value := 1;
    TabOrder := 6;
  end;
  with LLabel392 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox391;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG49;
    Parent := Form391;
  end;
  with LLabel393 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LEdit391;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG72;
    Parent := Form391;
  end;
  with LLabel394 do
  begin
    Alignment := taCenter;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG51;
    Parent := Form391;
  end;
  with LLabel395 do
  begin
    Alignment := taCenter;
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG52;
    Parent := Form391;
  end;
  with LLabel396 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LComboBox393;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
      Caption := MSG53;
    Parent := Form391;
  end;
  with LLabel397 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit393;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
      BorderSpacing.Right := 8;
    Caption := MSG54;
    Parent := Form391;
  end;
  with LLabel398 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form391;
  end;
  with LEdit392 do  // IP-address
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LComboBox392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LComboBox392;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LComboBox392;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Name := 'LEdit392';
    Parent := Form391;
    TabOrder := 7;
    if dev[LSpinEdit391.Value].valid and
       (dev[LSpinEdit391.Value].devtype = 0)
      then Text := dev[LSpinEdit391.Value].ipaddress
      else Text := '192.168.0.1';
  end;
  with LSpinEdit394 do  // port
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LSpinEdit392;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit392;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Name := 'LSpinEdit394';
    Parent := Form391;
    MinValue := 0;
    MaxValue := 65535;
    if dev[LSpinEdit391.Value].valid and
    (dev[LSpinEdit391.Value].devtype = 0)
      then Value := dev[LSpinEdit391.Value].port
      else Value := 502;
    TabOrder := 8;
  end;
  with LBevel391 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LEdit392;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form391;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form391;
    Shape := bsTopLine;
  end;
  with LButton391 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton392;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form391;
    TabOrder := 10;
  end;
  with LButton392 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel391;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form391;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Parent := Form391;
    TabOrder := 9;
  end;
  if Form391.ShowModal = mrOk then
  begin
   with Form391 do
     if LComboBox391.ItemIndex = 0 then
       cmd := COMMANDS[8] + ' dev' + inttostr(LSpinEdit391.Value) + ' ' +
         LComboBox391.Items[LComboBox391.ItemIndex] + ' ' +
         LEdit391.Text + ' ' +
         LEdit392.Text + ' ' +
         inttostr(LSpinEdit394.Value)
     else
       cmd := COMMANDS[8] + ' dev' + inttostr(LSpinEdit391.Value) + ' ' +
         LComboBox391.Items[LComboBox391.ItemIndex] + ' ' +
         LEdit391.Text + ' ' +
         LComboBox392.Items[LComboBox392.ItemIndex] + ' ' +
         inttostr(LSpinEdit392.Value) + ' ' +
         LComboBox393.Items[LComboBox393.ItemIndex] + ' ' +
         inttostr(LSpinEdit393.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form391);
end;
