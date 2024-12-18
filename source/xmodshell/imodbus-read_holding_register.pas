{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-read_holding_register.pas                                        | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'readreg con? hreg' WITH DIALOG
procedure TForm1.MenuItem73Click(Sender: TObject);
var
  Form731: TForm;
  LBevel731: TBevel;
  LButton731, LButton732: TButton;
  LLabel731, LLabel734, LLabel735, LLabel736: TLabel;
  LSpinEdit731, LSpinEdit732, LSpinEdit733: TSpinEdit;
  cmd: string;
begin
  Form731 := TForm.Create(Nil);
  LBevel731 := TBevel.Create(Form731);
  LButton731 := TButton.Create(Form731);
  LButton732 := TButton.Create(Form731);
  LLabel731 := TLabel.Create(Form731);
  LLabel734 := TLabel.Create(Form731);
  LLabel735 := TLabel.Create(Form731);
  LLabel736 := TLabel.Create(Form731);
  LSpinEdit731 := TSpinEdit.Create(Form731);
  LSpinEdit732 := TSpinEdit.Create(Form731);
  LSpinEdit733 := TSpinEdit.Create(Form731);
  with Form731 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem73.Caption);
    Name := 'Form731';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel731 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit731;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form731;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel731';
    Parent := Form731;
  end;
  with LSpinEdit731 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel734;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel731;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit731';
    Parent := Form731;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit732 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit731;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit731;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 1;
    MaxValue := 9999;
    Name := 'LSpinEdit732';
    Parent := Form731;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit733 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit731;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit732;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 9999;
    Name := 'LSpinEdit733';
    Parent := Form731;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel734 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form731;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel731;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit731;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel734';
    Parent := Form731;
  end;
  with LLabel735 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form731;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit732;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit732;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel735';
    Parent := Form731;
  end;
  with LLabel736 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form731;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit733;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit733;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel736';
    Parent := Form731;
  end;
  with LBevel731 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit731;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form731;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form731;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form731;
    Name := 'LBevel731';
    Shape := bsTopLine;
  end;
  with LButton731 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel731;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton732;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton731';
    Parent := Form731;
    TabOrder := 4;
  end;
  with LButton732 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel731;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form731;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton732';
    Parent := Form731;
    TabOrder := 3;
  end;
  if Form731.ShowModal = mrOk then
  begin
    with Form731 do
      cmd := COMMANDS[6] +
        ' con' + inttostr(LSpinEdit731.Value) + ' hreg ' +
        inttostr(LSpinEdit732.Value) + ' ' +
        inttostr(LSpinEdit733.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form731);
end;
