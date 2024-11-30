{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-reset_devices.pas                                   | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'reset dev? ...' WITH DIALOG
procedure TForm1.MenuItem43Click(Sender: TObject);
var
  Form: TForm;
  LBevel1: TBevel;
  LButton1, LButton2: TButton;
  LLabel1, LLabel2: TLabel;
  LSpinEdit1: TSpinEdit;
  cmd: string;
begin
  Form := TForm.Create(Nil);
  LBevel1 := TBevel.Create(Form);
  LButton1 := TButton.Create(Form);
  LButton2 := TButton.Create(Form);
  LLabel1 := TLabel.Create(Form);
  LLabel2 := TLabel.Create(Form);
  LSpinEdit1 := TSpinEdit.Create(Form);
  with Form do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem43.Caption);
    Position := poMainFormCenter;
  end;
  with LLabel1 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
    Caption := 'dev';
    Parent := Form;
    Font.Style := [fsBold];
    BorderSpacing.Left := 12;
  end;
  with LSpinEdit1 do  // device
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel2;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Parent := Form;
    MinValue := 0;
    MaxValue := 7;
    TabOrder := 0;
  end;
  with LLabel2 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel1;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit1;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG50;
    Parent := Form;
  end;
  with LBevel1 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit1;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form;
    Shape := bsTopLine;
  end;
  with LButton1 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton2;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Parent := Form;
    TabOrder := 2;
  end;
  with LButton2 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel1;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    Parent := Form;
    ModalResult := mrOk;
    TabOrder := 1;
  end;
  if Form.ShowModal = mrOk then
  begin
    with Form do
      cmd := COMMANDS[7] + ' dev' + inttostr(LSpinEdit1.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form);
end;
