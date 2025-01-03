{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iproject-timeout-set_timeout.pas                                         | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'set timeout'
procedure TForm1.MenuItem62Click(Sender: TObject);
var
  Form621: TForm;
  LBevel621: TBevel;
  LButton621, LButton622: TButton;
  LLabel621, LLabel622: TLabel;
  LSpinEdit621: TSpinEdit;
  cmd: string;
begin
  Form621 := TForm.Create(Nil);
  LBevel621 := TBevel.Create(Form621);
  LButton621 := TButton.Create(Form621);
  LButton622 := TButton.Create(Form621);
  LLabel621 := TLabel.Create(Form621);
  LLabel622 := TLabel.Create(Form621);
  LSpinEdit621 := TSpinEdit.Create(Form621);
  with Form621 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem62.Caption);
    Name := 'Form621';
    Position := poMainFormCenter;
    Parent := Nil;
  end;
  with LSpinEdit621 do  // timeout
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LLabel622;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form621;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := LLabel621;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 12;
    Autosize := true;
    MinValue := 1;
    MaxValue := 60;
    Name := 'LSpinEdit621';
    Parent := Form621;
    TabOrder := 0;
    Value := timeout;
  end;
  with LLabel621 do
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LSpinEdit621;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := 's';
    Name := 'LLabel621';
    Parent := Form621;
  end;
  with LLabel622 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LSpinEdit621;
      AnchorSideLeft.Side := asrCenter;
      BorderSpacing.Left := 0;
    Alignment := taCenter;
    Caption := MSG82;
    Name := 'LLabel622';
    Parent := Form621;
  end;
  with LBevel621 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LSpinEdit621;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form621;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel621';
    Parent := Form621;
    Shape := bsTopLine;
  end;
  with LButton621 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton622;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
      BorderSpacing.Left := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton621';
    Parent := Form621;
    TabOrder := 2;
  end;
  with LButton622 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel621;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form621;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton622';
    Parent := Form621;
    TabOrder := 1;
  end;
  if Form621.ShowModal = mrOk then
  begin
    with Form621 do
      cmd := COMMANDS[8] + ' timeout ' + inttostr(LSpinEdit621.Value);
    Memo1.Lines.Add(fullprompt + cmd);
    parsingcommands(cmd);
  end;
  FreeAndNil(Form621);
end;
