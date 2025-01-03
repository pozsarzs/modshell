{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-write_coil.pas                                                   | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'writereg con? coil' WITH DIALOG
procedure TForm1.MenuItem71Click(Sender: TObject);
var
  Form711: TForm;
  LBevel711: TBevel;
  LButton711, LButton712: TButton;
  LLabel711, LLabel714, LLabel715, LLabel716: TLabel;
  LSpinEdit711, LSpinEdit712, LSpinEdit713: TSpinEdit;
  cmd: string;
begin
  Form711 := TForm.Create(Nil);
  LBevel711 := TBevel.Create(Form711);
  LButton711 := TButton.Create(Form711);
  LButton712 := TButton.Create(Form711);
  LLabel711 := TLabel.Create(Form711);
  LLabel714 := TLabel.Create(Form711);
  LLabel715 := TLabel.Create(Form711);
  LLabel716 := TLabel.Create(Form711);
  LSpinEdit711 := TSpinEdit.Create(Form711);
  LSpinEdit712 := TSpinEdit.Create(Form711);
  LSpinEdit713 := TSpinEdit.Create(Form711);
  with Form711 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem71.Caption);
    Name := 'Form711';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel711 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit711;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form711;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel711';
    Parent := Form711;
  end;
  with LSpinEdit711 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel714;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel711;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit711';
    Parent := Form711;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit712 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit711;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit711;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 9998;
    Name := 'LSpinEdit712';
    Parent := Form711;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit713 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit711;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit712;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 125;
    Name := 'LSpinEdit713';
    Parent := Form711;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel714 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form711;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel711;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit711;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel714';
    Parent := Form711;
  end;
  with LLabel715 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form711;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit712;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit712;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel715';
    Parent := Form711;
  end;
  with LLabel716 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form711;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit713;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit713;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel716';
    Parent := Form711;
  end;
  with LBevel711 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit711;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form711;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form711;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form711;
    Name := 'LBevel711';
    Shape := bsTopLine;
  end;
  with LButton711 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel711;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton712;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton711';
    Parent := Form711;
    TabOrder := 4;
  end;
  with LButton712 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel711;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form711;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG69;
    ModalResult := mrOk;
    Name := 'LButton712';
    Parent := Form711;
    TabOrder := 3;
  end;
  if Form711.ShowModal = mrOk then
  begin
    with Form711 do
      cmd := COMMANDS[11] +
        ' con' + inttostr(LSpinEdit711.Value) + ' coil ' +
        inttostr(LSpinEdit712.Value) + ' ' +
        inttostr(LSpinEdit713.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form711);
end;
