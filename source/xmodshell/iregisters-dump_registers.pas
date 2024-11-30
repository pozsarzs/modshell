{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iregisters-dump_registers.pas                                            | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'dump' WITH DIALOG
procedure TForm1.MenuItem15Click(Sender: TObject);
var
  Form151: TForm;
  LBevel151: TBevel;
  LButton151, LButton152: TButton;
  LLabel151: TLabel;
  LRadioGroup151: TRadiogroup;
  LSpinEdit151: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form151 := TForm.Create(Nil);
  LBevel151 := TBevel.Create(Form151);
  LButton151 := TButton.Create(Form151);
  LButton152 := TButton.Create(Form151);
  LLabel151 := TLabel.Create(Form151);
  LRadioGroup151 := TRadioGroup.Create(Form151);
  LSpinEdit151 := TSpinEdit.Create(Form151);
  for b := 0 to 3 do
    LRadioGroup151.Items.Add(REG_TYPE[b]);
  LRadioGroup151.ItemIndex := 0;
  with Form151 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem15.Caption);
    Name := 'Form151';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup151 do  // register type
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form151;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Name := 'LRadioGroup151';
    Parent := Form151;
    TabOrder := 0;
  end;
  with LLabel151 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit151;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Name := 'LLabel151';
    Parent := Form151;
  end;
  with LSpinEdit151 do  // start address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel151;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup151;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit151';
    Parent := Form151;
    MinValue := 1;
    MaxValue := 9990;
    Value := 1;
    TabOrder := 1;
    Width := 100;
  end;
  with LBevel151 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup151;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form151;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form151;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel151';
    Parent := Form151;
    Shape := bsTopLine;
  end;
  with LButton151 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton152;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton151';
    Parent := Form151;
    TabOrder := 3;
  end;
  with LButton152 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel151;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form151;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG63;
    Name := 'LButton152';
    ModalResult := mrOk;
    Parent := Form151;
    TabOrder := 2;
  end;
  if Form151.ShowModal = mrOk then
  begin
    with Form151 do
    begin
      cmd := COMMANDS[33] + ' ' + REG_TYPE[LRadioGroup151.ItemIndex] + ' ' + inttostr(LSpinEdit151.Value);
      Memo1.Lines.Add(fullprompt + cmd);
      parsingcommands(cmd);
    end;
  end;
  FreeAndNil(Form151);
end;
