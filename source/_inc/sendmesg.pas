{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | sendmesg.pas                                                             | }
{ | Send a text message to Form1.Memo1                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// SEND A TEXT MESSAGE TO MEMO1
procedure sendmessage(message: string; linefeed: boolean);
begin
  fStatusText := message;
  if linefeed then fStatusText := fStatusText + EOL;
  Synchronize(@Showstatus);
end;
