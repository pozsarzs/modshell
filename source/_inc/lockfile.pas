{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | lockfile.pas                                                             | }
{ | check or remove device lock file                                         | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// example lock file: /var/lock/LCK..ttyUSB1

// CHECK LOCK FILE
function checklockfile(device: string; message: boolean): boolean;
{$IFDEF UNIX}
  var
    fn: string;
{$ENDIF}
begin
  result := false;
  {$IFDEF UNIX}
    fn := stringreplace(device, '/dev/', 'LCK..', [rfReplaceAll]);
    result := inttobool(length(filesearch(fn, DIR_LOCK)));
    if result and message
      then
        {$IFNDEF X}
          writeln(ERR49);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR49);
        {$ENDIF}
  {$ENDIF}
end;

// REMOVE LOCK FILE
function removelockfile(device: string; message: boolean): boolean;
{$IFDEF UNIX}
  var
    fn: string;
{$ENDIF}
begin
  result := false;
  {$IFDEF UNIX}
    fn := stringreplace(device, '/dev/', 'LCK..', [rfReplaceAll]);
    result := DeleteFile(DIR_LOCK + '/' + fn);
    if result and message
      then
        {$IFNDEF X}
          writeln(ERR43);
        {$ELSE}
          Form1.Memo1.Lines.Add(ERR43);
        {$ENDIF}
  {$ENDIF}
end;
