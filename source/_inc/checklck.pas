{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | checklck.pas                                                             | }
{ | check lock file of device                                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// CHECK LOCK FILE
function checklockfile(device: string; message: boolean): boolean;
var
  fn: string;
begin
  {$IFDEF UNIX}
    // example: /var/lock/LCK..ttyUSB1
    fn := stringreplace(device, '/dev/', 'LCK..', [rfReplaceAll]);
    result := inttobool(length(filesearch(fn, DIR_LOCK)));
  {$ENDIF}
  if result and message
    then {$IFNDEF X} writeln(ERR49); {$ELSE} Form1.Memo1.Lines.Add(ERR49); {$ENDIF}
end;
