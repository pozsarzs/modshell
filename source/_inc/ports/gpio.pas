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
function initgpioport(baseaddress: word): byte; overload;
begin
  result := 0;
  try
    {$IFDEF GO32V2}
      gpio_ba := baseaddress;
    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}
        result := 1;
      {$ELSE}
        gpio_ba := baseaddress;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
      gpio_ba := baseaddress;
    {$ENDIF}
  except
    result := 1;
  end;
end;

// WRITE A BIT TO A GPIO PORT
function writebittogpioport(number: byte; outdata: boolean): byte;
var
  b: byte;
  {$IFNDEF CPUARM}
    outdata_byte: byte = 0;
  {$ENDIF}
begin
  result := 0;
  {$IFNDEF CPUARM}
    gpio_mirror[number div 8, number mod 8] := outdata;
    for b := 0 to 7 do
      outdata_byte := outdata_byte + (1 shl b) * ord(gpio_mirror[number div 8, b]);
  {$ENDIF}
  try
    {$IFDEF GO32V2}
      port[gpio_ba + number div 8] := outdata_byte;
    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}

      {$ELSE}
        ioperm(gpio_ba + number div 8, 1, 1);
        port[gpio_ba + number div 8] := outdata_byte;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
      out32(gpio_ba + number div 8, outdata_byte);
    {$ENDIF}
  except
    result := 1;
  end;
end;

// READ A BIT FROM A GPIO PORT
function readbitfromgpioport(number: byte): boolean;
{$IFNDEF CPUARM}
  var
    indata_byte: byte = 0;
{$ENDIF}
begin
  result := false;
  try
    {$IFDEF GO32V2}
      indata_byte := port[gpio_ba + number div 8];
    {$ENDIF}
    {$IFDEF UNIX}
      {$IFDEF CPUARM}

      {$ELSE}
        ioperm(gpio_ba + number div 8, 1, 1);
        indata_byte := port[gpio_ba + number div 8];
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WINDOWS}
      indata_byte := inp32(gpio_ba + number div 8);
    {$ENDIF}
  except
    result := false;
  end;
  {$IFNDEF CPUARM}
    indata_byte :=  indata_byte and (1 shl b);
    indata_byte := indata_byte shr b;
    gpio_mirror[number div 8, number mod 8] := inttobool(indata_byte);
    result := gpio_mirror[number div 8, number mod 8];
  {$ENDIF}
end;
