{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-write_holding_register.pas                                       | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'writereg con? hreg' WITH DIALOG
procedure TForm1.MenuItem75Click(Sender: TObject);
var
  Form751: TForm;
  LBevel751: TBevel;
  LButton751, LButton752: TButton;
  LLabel751, LLabel754, LLabel755, LLabel756: TLabel;
  LSpinEdit751, LSpinEdit752, LSpinEdit753: TSpinEdit;
  cmd: string;
begin
  Form751 := TForm.Create(Nil);
  LBevel751 := TBevel.Create(Form751);
  LButton751 := TButton.Create(Form751);
  LButton752 := TButton.Create(Form751);
  LLabel751 := TLabel.Create(Form751);
  LLabel754 := TLabel.Create(Form751);
  LLabel755 := TLabel.Create(Form751);
  LLabel756 := TLabel.Create(Form751);
  LSpinEdit751 := TSpinEdit.Create(Form751);
  LSpinEdit752 := TSpinEdit.Create(Form751);
  LSpinEdit753 := TSpinEdit.Create(Form751);
  with Form751 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem75.Caption);
    Name := 'Form751';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel751 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit751;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form751;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel751';
    Parent := Form751;
  end;
  with LSpinEdit751 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel754;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel751;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit751';
    Parent := Form751;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit752 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit751;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit751;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 9998;
    Name := 'LSpinEdit752';
    Parent := Form751;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit753 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit751;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit752;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 125;
    Name := 'LSpinEdit753';
    Parent := Form751;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel754 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form751;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel751;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit751;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel754';
    Parent := Form751;
  end;
  with LLabel755 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form751;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit752;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit752;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel755';
    Parent := Form751;
  end;
  with LLabel756 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form751;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit753;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit753;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel756';
    Parent := Form751;
  end;
  with LBevel751 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit751;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form751;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form751;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form751;
    Name := 'LBevel751';
    Shape := bsTopLine;
  end;
  with LButton751 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel751;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton752;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton751';
    Parent := Form751;
    TabOrder := 4;
  end;
  with LButton752 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel751;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form751;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton752';
    Parent := Form751;
    TabOrder := 3;
  end;
  if Form751.ShowModal = mrOk then
  begin
    with Form751 do
      cmd := COMMANDS[11] +
        ' con' + inttostr(LSpinEdit751.Value) + ' hreg ' +
        inttostr(LSpinEdit752.Value) + ' ' +
        inttostr(LSpinEdit753.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form751);
end;
