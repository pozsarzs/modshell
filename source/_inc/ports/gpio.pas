{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | gpio.pas                                                                 | }
{ | GPIO port handler procedures and functions                               | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// SET GPIO PORT ON RASPBERRY PI
function initgpioport(rpiversion: byte; number: byte; portmode: byte): byte; overload;
begin
  result := 0;
  try
    {$IFDEF GO32V2}
      result := 1;
    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}

      {$ELSE}
        result := 1;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
      result := 1;
    {$ENDIF}
  except
    result := 1;
  end;
end;

// SET GPIO PORT ON IPC
function initgpioport(baseaddress: byte): byte; overload;
begin
  result := 0;
  try
    {$IFDEF GO32V2}

    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}
        result := 1;
      {$ELSE}

      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}

    {$ENDIF}
  except
    result := 1;
  end;
end;

// WRITE A BIT TO A GPIO PORT
function writebittogpioport(number: byte; outdata: boolean): byte;
begin
  result := 0;
  try
    {$IFDEF GO32V2}

    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}

      {$ELSE}

      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}

    {$ENDIF}
  except
    result := 1;
  end;
end;

// READ A BIT FROM A GPIO PORT
function readbitfromgpioport(number: byte): boolean;
begin
  try
    {$IFDEF GO32V2}

    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}

      {$ELSE}

      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}

    {$ENDIF}
  except
    result := false;
  end;
end;
