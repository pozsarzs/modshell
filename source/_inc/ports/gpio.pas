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

// WRITE A BIT TO A GPIO PORT
function writebittogpioport(number: byte; outdata: boolean): byte;
begin
  result := 0;
end;

// READ A BIT FROM A GPIO PORT
function readbitfromgpioport(number: byte): boolean;
begin
  result := false;
end;
