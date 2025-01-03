{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-connections-reset_connections.pas                               | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'reset con? ...' WITH DIALOG
procedure TForm1.MenuItem45Click(Sender: TObject);
var
  Form451: TForm;
  LBevel451: TBevel;
  LButton451, LButton452: TButton;
  LLabel451, LLabel452: TLabel;
  LSpinEdit451: TSpinEdit;
  cmd: string;
begin
  Form451 := TForm.Create(Nil);
  LBevel451 := TBevel.Create(Form451);
  LButton451 := TButton.Create(Form451);
  LButton452 := TButton.Create(Form451);
  LLabel451 := TLabel.Create(Form451);
  LLabel452 := TLabel.Create(Form451);
  LSpinEdit451 := TSpinEdit.Create(Form451);
  with Form451 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem45.Caption);
    Name := 'Form451';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel451 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit451;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel451';
    Parent := Form451;
  end;
  with LSpinEdit451 do  // connection
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel452;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel451;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LBevel451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit451';
    Parent := Form451;
    TabOrder := 0;
  end;
  with LLabel452 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel452';
    Parent := Form451;
  end;
  with LBevel451 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit451;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form451;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel451';
    Parent := Form451;
    Shape := bsTopLine;
  end;
  with LButton451 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton452;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton451';
    Parent := Form451;
    TabOrder := 2;
  end;
  with LButton452 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel451;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form451;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG46;
    ModalResult := mrOk;
    Name := 'LButton452';
    Parent := Form451;
    TabOrder := 1;
  end;
  if Form451.ShowModal = mrOk then
  begin
    with Form451 do
      cmd := COMMANDS[7] +
      ' con' + inttostr(LSpinEdit451.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form451);
end;
 
