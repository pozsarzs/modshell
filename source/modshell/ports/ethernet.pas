{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ethernet.pas                                                             | }
{ | Ethernet handler procedures and functions                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

function eth_read: string;
begin
  result := '';
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

function  eth_init: boolean;
begin
  result := true;
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

procedure eth_write(s: string);
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;

procedure eth_close;
begin
  {$IFDEF GO32V2}
  {$ELSE}
  {$ENDIF}
end;
