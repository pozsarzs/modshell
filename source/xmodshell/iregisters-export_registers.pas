{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iregisters-export_registers.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'expreg' WITH TSaveDialog
procedure TForm1.MenuItem31Click(Sender: TObject);
var
  LSaveDialog311: TSaveDialog;
  Form311: TForm;
  LBevel311: TBevel;
  LButton311, LButton312: TButton;
  LLabel311, LLabel312: TLabel;
  LRadioGroup311: TRadiogroup;
  LSpinEdit311, LSpinEdit312: TSpinEdit;
  b: byte;
  cmd: string;
begin
  Form311 := TForm.Create(Nil);
  LBevel311 := TBevel.Create(Form311);
  LButton311 := TButton.Create(Form311);
  LButton312 := TButton.Create(Form311);
  LLabel311 := TLabel.Create(Form311);
  LLabel312 := TLabel.Create(Form311);
  LRadioGroup311 := TRadioGroup.Create(Form311);
  LSpinEdit311 := TSpinEdit.Create(Form311);
  LSpinEdit312 := TSpinEdit.Create(Form311);
  for b := 0 to 3 do
    LRadioGroup311.Items.Add(REG_TYPE[b]);
  LRadioGroup311.ItemIndex := 0;
  with Form311 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem31.Caption);
    Name := 'Form311';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LRadioGroup311 do  // register type
  begin
    Anchors := [akTop, akBottom, akLeft];
      AnchorSideTop.Control := Form311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 8;
      AnchorSideBottom.Control := LSpinEdit312;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 0;
      AnchorSideLeft.Control := Form311;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
    AutoSize := True;
    Caption := MSG59;
    Name := 'LRadioGroup311';
    Parent := Form311;
    TabOrder := 0;
  end;
  with LLabel311 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit311;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG60;
    Name := 'Form311';
    Parent := Form311;
  end;
  with LSpinEdit311 do  // start address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup311;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit311';
    Parent := Form311;
    Value := 0;
    Width := 100;
    TabOrder := 1;
  end;
  with LLabel312 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit312;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Caption := MSG61;
    Name := 'LLabel312';
    Parent := Form311;
  end;
  with LSpinEdit312 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel312;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      BorderSpacing.Right := 8;
      AnchorSideLeft.Control := LRadioGroup311;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LSpinEdit312';
    Parent := Form311;
    Value := 1;
    TabOrder := 2;
    Width := 100;
  end;
  with LBevel311 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LRadioGroup311;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form311;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form311;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel311';
    Parent := Form311;
    Shape := bsTopLine;
  end;
  with LButton311 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton312;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton311';
    Parent := Form311;
    TabOrder := 4;
  end;
  with LButton312 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel311;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form311;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG62;
    ModalResult := mrOk;
    Name := 'LButton312';
    Parent := Form311;
    TabOrder := 3;
  end;
  if Form311.ShowModal = mrOk then
  begin
    with Form311 do
    begin
      LSaveDialog311 := TSaveDialog.Create(Self);
      with LSaveDialog311 do
      begin
        Title := rmampdot(MenuItem14.Caption);
        InitialDir := vars[13].vvalue;
        Filter := MSG57;
        DefaultExt := 'xml';
        FilterIndex := 3;
        if Execute then
        begin
          if fileexists(FileName) then
            if Application.MessageBox(PChar(MSG14), PChar(rmampdot(MenuItem31.Caption)), MB_ICONQUESTION + MB_YESNO) = IDNO then
            begin
              Free;
              exit;
          end;
          cmd := COMMANDS[15] + ' ' + FileName + ' ' +
            REG_TYPE[LRadioGroup311.ItemIndex] + ' ' +
            inttostr(LSpinEdit311.Value) + ' ' + inttostr(LSpinEdit312.Value);
          Memo1.Lines.Add(fullprompt + cmd);
          parsingcommands(cmd);
        end;
        Free;
      end;
    end;
  end;
  FreeAndNil(Form311);
end;
