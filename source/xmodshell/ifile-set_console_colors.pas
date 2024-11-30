{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | ifile-set_console_colors.pas                                             | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// SET CONSOLE COLORS
procedure TForm1.MenuItem23Click(Sender: TObject);
var
  Form231: TForm;
  LBevel231: TBevel;
  LButton231, LButton232: TButton;
  LColorBox231, LColorBox232: TColorBox;
  LLabel231, LLabel232: TLabel;
begin
  Form231 := TForm.Create(Nil);
  LBevel231 := TBevel.Create(Form231);
  LButton231 := TButton.Create(Form231);
  LButton232 := TButton.Create(Form231);
  LColorBox231 := TColorBox.Create(Form231);
  LColorBox232 := TColorBox.Create(Form231);
  LLabel231 := TLabel.Create(Form231);
  LLabel232 := TLabel.Create(Form231);
  with Form231 do
  begin
    AutoSize := True;
    BorderStyle := bsDialog;
    Caption := rmampdot(MenuItem23.Caption);
    Name := 'Form231';
    Parent := Nil;
    Position := poMainFormCenter;
  end;
  with LLabel231 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := Form231;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 12;
    Caption := MSG47;
    Name := 'LLabel231';
    Parent := Form231;
  end;
  with LColorBox231 do  // foreground color
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := Form231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 12;
      AnchorSideLeft.Control := LLabel231;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
    Name := 'LColorBox231';
    Parent := Form231;
    Style := [cbStandardColors];
    TabOrder := 0;
  end;
  with LLabel232 do
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LColorBox231;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 16;
    Caption := MSG48;
    Name := 'LLabel232';
    Parent := Form231;
  end;
  with LColorBox232 do  // background color
  begin
    Anchors := [akTop, akLeft];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrCenter;
      BorderSpacing.Top := 0;
      AnchorSideLeft.Control := LLabel232;
      AnchorSideLeft.Side := asrRight;
      BorderSpacing.Left := 8;
      BorderSpacing.Right := 8;
    Name := 'LColorBox232';
    Parent := Form231;
    Style := [cbStandardColors];
    TabOrder := 1;
  end;
  with LBevel231 do
  begin
    Anchors := [akTop, akLeft, akRight];
      AnchorSideTop.Control := LColorBox231;
      AnchorSideTop.Side := asrBottom;
      BorderSpacing.Top := 8;
      AnchorSideLeft.Control := Form231;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 8;
      AnchorSideRight.Control := Form231;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Name := 'LBevel231';
    Parent := Form231;
    Shape := bsTopLine;
  end;
  with LButton231 do  // Cancel
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := LButton232;
      AnchorSideRight.Side := asrLeft;
      BorderSpacing.Right := 8;
    Caption := MSG44;
    Cancel := True;
    ModalResult := mrCancel;
    Name := 'LButton231';
    Parent := Form231;
    TabOrder := 3;
  end;
  with LButton232 do  // OK
  begin
    Anchors := [akTop, akRight];
      AnchorSideTop.Control := LBevel231;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 16;
      AnchorSideRight.Control := Form231;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 8;
    Caption := MSG45;
    ModalResult := mrOk;
    Name := 'LButton232';
    Parent := Form231;
    TabOrder := 2;
  end;
  LColorBox231.Selected := uconfig.guicolors[0];
  LColorBox232.Selected := uconfig.guicolors[1];
  if Form231.ShowModal = mrOk then
  begin
    with Form231 do
    begin
      uconfig.guicolors[0] := LColorBox231.Selected;
      uconfig.guicolors[1] := LColorBox232.Selected;
    end;
    Memo1.Font.Color := uconfig.guicolors[0];
    Memo1.Color := uconfig.guicolors[1];
  end;
  FreeAndNil(Form231);
end;
