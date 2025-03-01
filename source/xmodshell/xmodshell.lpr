{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | xmodshell.lpr                                                            | }
{ | project file                                                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

{$MODE OBJFPC}{$H+}

program xmodshell;
uses
  {$IFDEF UNIX}
    CMem,
    CThreads,
  {$ENDIF}
  Dialogs,
  Forms, lhelpcontrolpkg,
  Interfaces,
  ModLCLTranslator,
  SySUtils,
  crt,
  frmmain,
  frmmbmn,
  frmsecn,
  frmtccn,
  frmudcn,
  frmvrmn,
  frmregtable,
  ucommon,
  uconfig;
var
  b: byte;
  fn: string;
  opmode: byte;
const
  params: array[1..2, 1..3] of string =
    (
    ('-h', '--help', 'show help'),
    ('-v', '--version', 'show version and build information')
    );

{$R *.res}

procedure help(mode: boolean);
var
  b: byte;
  {$IFDEF WINDOWS} s: string; {$ENDIF}
begin
  if mode
    then ShowMessage('There are one or more bad arguments in command line.')
    else
  begin
    {$IFDEF UNIX}
      writeln('Usage: ', fn, {$IFDEF WINDOWS}'.', fe,{$ENDIF}' [argument]');
      writeln;
      writeln('arguments:');
      for b := 1 to 2 do
      begin
        Write('  ', params[b, 1]);
        gotoxy(8, wherey);
        Write(params[b, 2]);
        gotoxy(30, wherey);
        writeln(params[b, 3]);
      end;
      writeln;
    {$ENDIF}
    {$IFDEF WINDOWS}
      s := 'Usage:' + #13 + #10;
      s := s + ' ' + fn + ' [argument]' + #13 + #10 + #13 + #10;
      s := s + 'arguments:';
      for b := 1 to 2 do
        s := s + #13 + #10 + '  ' + params[b, 1] + ', ' + params[b, 2] + ': ' +
             params[b, 3];
      ShowMessage(s);
    {$ENDIF}
  end;
  halt(0);
end;

{$I version.pas}

begin
  fn := extractfilename(ParamStr(0));
  opmode := 0;
  if length(ParamStr(1)) = 0 then
    opmode := 1
  else
  begin
    for b := 1 to 2 do
      if ParamStr(1) = params[b, 1] then
        opmode := 10 * b;
    for b := 1 to 2 do
      if ParamStr(1) = params[b, 2] then
        opmode := 10 * b;
  end;
  case opmode of
    0: help(True);
    10: help(False);
    20: version(true);
  end;
  RequireDerivedFormResource := true;
  Application.Title := 'XModShell';
  Application.Scaled := true;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
