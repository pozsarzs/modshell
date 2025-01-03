{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | imodbus-read_input_register.pas                                          | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'readreg con? ireg' WITH DIALOG
procedure TForm1.MenuItem72Click(Sender: TObject);
var
  Form721: TForm;
  LBevel721: TBevel;
  LButton721, LButton722: TButton;
  LLabel721, LLabel724, LLabel725, LLabel726: TLabel;
  LSpinEdit721, LSpinEdit722, LSpinEdit723: TSpinEdit;
  cmd: string;
begin
  Form721 := TForm.Create(Nil);
  LBevel721 := TBevel.Create(Form721);
  LButton721 := TButton.Create(Form721);
  LButton722 := TButton.Create(Form721);
  LLabel721 := TLabel.Create(Form721);
  LLabel724 := TLabel.Create(Form721);
  LLabel725 := TLabel.Create(Form721);
  LLabel726 := TLabel.Create(Form721);
  LSpinEdit721 := TSpinEdit.Create(Form721);
  LSpinEdit722 := TSpinEdit.Create(Form721);
  LSpinEdit723 := TSpinEdit.Create(Form721);
  with Form721 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem72.Caption);
    Name := 'Form721';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel721 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit721;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form721;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := 'con';
    Font.Style := [fsBold];
    Name := 'LLabel721';
    Parent := Form721;
  end;
  with LSpinEdit721 do  // connection
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LLabel724;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := LLabel721;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    AutoSize := True;
    MinValue := 0;
    MaxValue := 7;
    Name := 'LSpinEdit721';
    Parent := Form721;
    TabOrder := 0;
    Value := 0;
  end;
  with LSpinEdit722 do  // address
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit721;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit721;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    MinValue := 0;
    MaxValue := 9998;
    Name := 'LSpinEdit722';
    Parent := Form721;
    TabOrder := 1;
    Width := 90;
  end;
  with LSpinEdit723 do  // count
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LSpinEdit721;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LSpinEdit722;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    MinValue := 1;
    MaxValue := 125;
    Name := 'LSpinEdit723';
    Parent := Form721;
    TabOrder := 2;
    Width := 90;
  end;
  with LLabel724 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form721;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel721;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit721;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG73;
    Name := 'LLabel724';
    Parent := Form721;
  end;
  with LLabel725 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form721;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit722;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit722;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG60;
    Name := 'LLabel725';
    Parent := Form721;
  end;
  with LLabel726 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := Form721;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit723;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 0;
      AnchorSideRight.Control := LSpinEdit723;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 0;
    Alignment := taCenter;
    Caption := MSG61;
    Name := 'LLabel726';
    Parent := Form721;
  end;
  with LBevel721 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit721;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form721;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form721;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Parent := Form721;
    Name := 'LBevel721';
    Shape := bsTopLine;
  end;
  with LButton721 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel721;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton722;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton721';
    Parent := Form721;
    TabOrder := 4;
  end;
  with LButton722 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel721;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form721;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG77;
    ModalResult := mrOk;
    Name := 'LButton722';
    Parent := Form721;
    TabOrder := 3;
  end;
  if Form721.ShowModal = mrOk then
  begin
    with Form721 do
      cmd := COMMANDS[6] +
        ' con' + inttostr(LSpinEdit721.Value) + ' ireg ' +
        inttostr(LSpinEdit722.Value) + ' ' +
        inttostr(LSpinEdit723.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form721);
end;
