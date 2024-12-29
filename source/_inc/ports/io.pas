{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | io.pas                                                                   | }
{ | I/O port handler procedures and functions                                | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// WRITE A BYTE TO AN I/O PORT
function writebytetoioport(address: word; outdata: byte): byte;
begin
  result := 0;
  try
    {$IFDEF GO32V2}
      port[address] := outdata;
    {$ENDIF}
    {$IFDEF UNIX}
      ioperm(address, 1, 1);
      port[address] := outdata;
    {$ENDIF}
    {$IFDEF WINDOWS}
      Out32(address, outdata);
    {$ENDIF}
  except
    result := 1;
  end;
end;

// READ A BYTE FROM AN I/O PORT
function readbytefromioport(address: word): byte;
begin
  try
    {$IFDEF GO32V2}
      result := port[address];
    {$ENDIF}
    {$IFDEF UNIX}
      ioperm(address, 1, 1);
      result := port[address];
    {$ENDIF}
    {$IFDEF WINDOWS}
      result := Inp32(address);
    {$ENDIF}
  except
    result := 0;
  end;
end;
