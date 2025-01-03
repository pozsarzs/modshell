{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | iscript-edit_script.pas                                                  | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// RUN COMMAND 'edit' WITH DIALOG
procedure TForm1.MenuItem30Click(Sender: TObject);
var
  Form301: TForm;
  LSynEdit301: TSynEdit;
  line, sline: integer;
begin
  Form301 := TForm.Create(Nil);
  LSynEdit301 := TSynEdit.Create(Form301);
  with Form301 do
  begin
    BorderStyle := bsSizeable;
    Caption := rmampdot(MenuItem30.Caption);
    Name := 'Form301';
    Parent := Nil;
    Top := formpositions[3, 0];
    Left := formpositions[3, 1];
    if formpositions[3, 2] > 240 then Height := formpositions[3, 2];
    if formpositions[3, 3] > 320 then Width := formpositions[3, 3];
  end;
  with LSynEdit301 do
  begin
    Anchors := [akTop, akBottom, akLeft, akRight];
      AnchorSideTop.Control := Form301;
      AnchorSideTop.Side := asrTop;
      BorderSpacing.Top := 1;
      AnchorSideBottom.Control := Form301;
      AnchorSideBottom.Side := asrBottom;
      BorderSpacing.Bottom := 1;
      AnchorSideLeft.Control := Form301;
      AnchorSideLeft.Side := asrLeft;
      BorderSpacing.Left := 1;
      AnchorSideRight.Control := Form301;
      AnchorSideRight.Side := asrRight;
      BorderSpacing.Right := 1;
    Color := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Background := clNavy;
    Gutter.LineNumberPart.MarkupInfo.Foreground := clYellow;
    Font.Color := clAqua;
    Gutter.Color := clNavy;
    Name := 'LSynEdit301';
    Parent := Form301;
    ReadOnly := False;
    ScrollBars := ssAutoBoth;
    TabOrder := 0;
    Position := poMainFormCenter;
    HighLighter := LSynAnySyn1;
    Clear;
  end;
  for sline := 0 to SCRBUFFSIZE - 1 do
    if length(sbuffer[sline]) > 0 then
      LSynEdit301.Lines.Add(sbuffer[sline]);
  Form301.ShowModal;
  sline := 0;
  for line := 0 to LSynEdit301.Lines.Count -1 do
    if sline < SCRBUFFSIZE - 1 then
      if length(LSynEdit301.Lines[line]) > 0 then
      begin
        sbuffer[sline] := LSynEdit301.Lines[line];
        inc(sline);
      end;
  if length(LSynEdit301.Text) > 0 then scriptisloaded := true;
  with Form301 do
  begin
    formpositions[3, 0] := Top;
    formpositions[3, 1] := Left;
    formpositions[3, 2] := Height;
    formpositions[3, 3] := Width;
  end;
  FreeAndNil(Form301);
end;
