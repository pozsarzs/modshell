{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-read_coil.pas                                                    | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'readreg con? coil' WITH DIALOG
procedure TForm1.MenuItem74Click(Sender: TObject);
var
  Form741: TForm;
  LBevel741: TBevel;
  LButton741, LButton742: TButton;
  LLabel741, LLabel744, LLabel745, LLabel746: TLabel;
  LSpinEdit741, LSpinEdit742, LSpinEdit743: TSpinEdit;
  cmd: string;
begin
  Form741 := TForm.Create(Nil);
  LBevel741 := TBevel.Create(Form741);
  LButton741 := TButton.Create(Form741);
  LButton742 := TButton.Create(Form741);
  LLabel741 := TLabel.Create(Form741);
  LLabel744 := TLabel.Create(Form741);
  LLabel745 := TLabel.Create(Form741);
  LLabel746 := TLabel.Create(Form741);
  LSpinEdit741 := TSpinEdit.Create(Form741);
  LSpinEdit742 := TSpinEdit.Create(Form741);
  LSpinEdit743 := TSpinEdit.Create(Form741);
  with Form741 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem74.Caption);
    Name := 'Form741';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel741 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit741;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form741;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel741';
    Parent := Form741;
  end;
  with LSpinEdit741 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel744;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel741;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit741';
    Parent := Form741;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit742 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit741;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit741;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 9998;
    Name := 'LSpinEdit742';
    Parent := Form741;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit743 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit741;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit742;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 125;
    Name := 'LSpinEdit743';
    Parent := Form741;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel744 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form741;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel741;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit741;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel744';
    Parent := Form741;
  end;
  with LLabel745 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form741;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit742;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit742;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel745';
    Parent := Form741;
  end;
  with LLabel746 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form741;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit743;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit743;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel746';
    Parent := Form741;
  end;
  with LBevel741 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit741;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form741;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form741;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form741;
    Name := 'LBevel741';
    Shape := bsTopLine;
  end;
  with LButton741 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel741;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton742;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton741';
    Parent := Form741;
    TabOrder := 4;
  end;
  with LButton742 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel741;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form741;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton742';
    Parent := Form741;
    TabOrder := 3;
  end;
  if Form741.ShowModal = mrOk then
  begin
    with Form741 do
      cmd := COMMANDS[6] +
        ' con' + inttostr(LSpinEdit741.Value) + ' coil ' +
        inttostr(LSpinEdit742.Value) + ' ' +
        inttostr(LSpinEdit743.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form741);
end;
