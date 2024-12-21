{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-read_discrete_input.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'readreg con? dinp' WITH DIALOG
procedure TForm1.MenuItem70Click(Sender: TObject);
var
  Form701: TForm;
  LBevel701: TBevel;
  LButton701, LButton702: TButton;
  LLabel701, LLabel704, LLabel705, LLabel706: TLabel;
  LSpinEdit701, LSpinEdit702, LSpinEdit703: TSpinEdit;
  cmd: string;
begin
  Form701 := TForm.Create(Nil);
  LBevel701 := TBevel.Create(Form701);
  LButton701 := TButton.Create(Form701);
  LButton702 := TButton.Create(Form701);
  LLabel701 := TLabel.Create(Form701);
  LLabel704 := TLabel.Create(Form701);
  LLabel705 := TLabel.Create(Form701);
  LLabel706 := TLabel.Create(Form701);
  LSpinEdit701 := TSpinEdit.Create(Form701);
  LSpinEdit702 := TSpinEdit.Create(Form701);
  LSpinEdit703 := TSpinEdit.Create(Form701);
  with Form701 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem70.Caption);
    Name := 'Form701';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel701 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit701;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form701;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel701';
    Parent := Form701;
  end;
  with LSpinEdit701 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel704;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel701;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit701';
    Parent := Form701;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit702 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit701;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit701;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 9998;
    Name := 'LSpinEdit702';
    Parent := Form701;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit703 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit701;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit702;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 125;
    Name := 'LSpinEdit703';
    Parent := Form701;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel704 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form701;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel701;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit701;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel704';
    Parent := Form701;
  end;
  with LLabel705 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form701;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit702;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit702;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel705';
    Parent := Form701;
  end;
  with LLabel706 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form701;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit703;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit703;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel706';
    Parent := Form701;
  end;
  with LBevel701 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit701;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form701;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form701;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form701;
    Name := 'LBevel701';
    Shape := bsTopLine;
  end;
  with LButton701 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel701;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton702;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton701';
    Parent := Form701;
    TabOrder := 4;
  end;
  with LButton702 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel701;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form701;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton702';
    Parent := Form701;
    TabOrder := 3;
  end;
  if Form701.ShowModal = mrOk then
  begin
    with Form701 do
      cmd := COMMANDS[6] +
        ' con' + inttostr(LSpinEdit701.Value) + ' dinp ' +
        inttostr(LSpinEdit702.Value) + ' ' +
        inttostr(LSpinEdit703.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form701);
end;

