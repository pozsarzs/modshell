{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | hart.pas                                                                 | }
{ | HART protocol procedures and functions                                   | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// MAKE CHECKSUM
function hr_mkchecksum(s: string): string;
begin
  result := '';
end;

// CHECK RECEIVED STRING WITH CHECKSUM
function hr_chkchecksum(s, checksum: string): boolean;
begin
  result := false;
end;

// READ AND WRITE FROM/TO A REMOTE DEVICE
function hr_readwrite(protocol, device: word; txdata: string;
                      checksum: boolean): string;
begin
  result := '';
end;

// READ AND WRITE HART DCON PROTOCOL
function hart_readwrite(connection: integer; txdata: string;
                        checksum: boolean): string;
begin
  result := '';
end;
