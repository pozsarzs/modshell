{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
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

program xmodshell;
{$MODE OBJFPC}{$H+}
uses
  {$IFDEF UNIX} cthreads, cmem, {$ENDIF}
  Interfaces,
  Dialogs,
  Forms,
  ModLCLTranslator,
  crt,
  sysutils,
  frmmain,
  frmmbmn,
  frmsecn,
  frmtccn,
  frmudcn,
  frmvrmn, frmregtable;
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
  if mode then
    ShowMessage('There are one or more bad parameters in command line.')
  else
  begin
    {$IFDEF UNIX}
      writeln('Usage:');
      writeln(' ', fn, {$IFDEF WINDOWS}'.', fe,{$ENDIF}' [parameter]');
      writeln;
      writeln('parameters:');
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
      s := s + ' ' + fn + ' [parameter]' + #13 + #10 + #13 + #10;
      s := s + 'parameters:';
      for b := 1 to 2 do
        s := s + #13 + #10 + '  ' + params[b, 1] + ', ' + params[b, 2] + ': ' + params[b, 3];
      ShowMessage(s);
    {$ENDIF}
  end;
  halt(0);
end;

procedure verinfo;
{$IFDEF WINDOWS} var s: string; {$ENDIF}
begin
  {$IFDEF UNIX}
     writeln('X' + PRGNAME + ' v' + PRGVERSION);
     writeln;
     writeln('This application was compiled at ',{$I %TIME%}, ' on ',{$I %DATE%}, ' by ',{$I %USER%});
     writeln('FPC version: ',{$I %FPCVERSION%});
     writeln('Target OS:   ',{$I %FPCTARGETOS%});
     writeln('Target CPU:  ',{$I %FPCTARGETCPU%});
  {$ENDIF}
  {$IFDEF WINDOWS}
     s := 'X' + PRGNAME + ' v' + PRGVERSION + #13 + #10 + #13 + #10;
     s := s + 'This was compiled at ' + {$I %TIME%} +' on ' + {$I %DATE%} +' by ' + {$I %USERNAME%} +'.' + #13 + #10 + #13 + #10;
     s := s + 'FPC version: ' + {$I %FPCVERSION%} + #13 + #10;
     s := s + 'Target OS:   ' + {$I %FPCTARGETOS%} + #13 + #10;
     s := s + 'Target CPU:  ' + {$I %FPCTARGETCPU%};
     ShowMessage(s);
  {$ENDIF}
  halt(0);
end;

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
    20: verinfo;
  end;
  RequireDerivedFormResource:=True;
  Application.Title:='XModShell';
  Application.Scaled:=True;
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
