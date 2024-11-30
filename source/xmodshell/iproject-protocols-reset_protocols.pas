{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-reset_protocols.pas                                 | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'reset pro? ...' WITH DIALOG
procedure TForm1.MenuItem44Click(Sender: TObject);
var
  Form441: TForm;
  LBevel441: TBevel;
  LButton441, LButton442: TButton;
  LLabel441, LLabel442: TLabel;
  LSpinEdit441: TSpinEdit;
  cmd: string;
begin
  Form441 := TForm.Create(Nil);
  LBevel441 := TBevel.Create(Form441);
  LButton441 := TButton.Create(Form441);
  LButton442 := TButton.Create(Form441);
  LLabel441 := TLabel.Create(Form441);
  LLabel442 := TLabel.Create(Form441);
  LSpinEdit441 := TSpinEdit.Create(Form441);
  with Form441 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem44.Caption);
    Name := 'Form441';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel441 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit441;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'pro';
    Font.Style := [fsBold];
    Name := 'LLabel441';
    Parent := Form441;
  end;
  with LSpinEdit441 do  // protocol
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel442;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel441;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit441';
    Parent := Form441;
    TabOrder := 0;
  end;
  with LLabel442 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG55;
    Name := 'LLabel442';
    Parent := Form441;
  end;
  with LBevel441 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit441;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form441;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel441';
    Parent := Form441;
    Shape := bsTopLine;
  end;
  with LButton441 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton442;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton441';
    Parent := Form441;
    TabOrder := 2;
  end;
  with LButton442 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel441;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form441;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    ModalResult := mrOk;
    Name := 'LButton442';
    Parent := Form441;
    TabOrder := 1;
  end;
  if Form441.ShowModal = mrOk then
  begin
    with Form441 do
      cmd := COMMANDS[7] +
      ' pro' + inttostr(LSpinEdit441.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form441);
end;
