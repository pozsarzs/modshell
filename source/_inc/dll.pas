{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | dll.pas                                                                  | }
{ | DLL handler procedures and functions                                     | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// LOAD 'inpout32.dll'
function loadinpout32dll: boolean;
{$IFDEF WINDOWS}
  var
    libdir: string;
  const
    {$IFDEF WIN32}
      filename: string = 'inpout32.dll';
    {$ENDIF}
    {$IFDEF WIN64}
      filename: string = 'inpoutx64.dll';
    {$ENDIF}
{$ENDIF}
begin
  result := true;
  {$IFDEF WINDOWS}
    libdir := 'library' + SLASH + 'inpout32' + SLASH;
    if fileexists(libdir + filename)
      then inpout32 := loadlibrary(pchar(libdir + filename))
      else inpout32 := loadlibrary(pchar(filename));
    if (inpout32 <> 0) then
    begin
     inp32 := tinp32(getprocaddress(inpout32, 'inp32'));
     if (@inp32 = nil) then result := false;
     out32 := tout32(getprocaddress(inpout32, 'out32'));
     if (@out32 = nil) then result := false;
   end
   else result := false;
  {$ELSE}
    result := false;
  {$ENDIF}
end;

// UNLOAD 'inpout32.dll'
procedure unloadinpout32dll;
begin
  {$IFDEF WINDOWS}
    freelibrary(Inpout32);
  {$ENDIF}
end;
