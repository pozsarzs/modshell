@echo off
rem ModShell 0.1 * Command-driven scriptable Modbus utility
rem Copyright (C) 2023-2024 Pozsar Zsolt pozsarzs@gmail.com
rem buildwin32.bat
rem Build program for 32 bit Windows

set buildcui=1
set buildgui=1

:loop
if "%1"=="" goto :done
if "%1"=="/?" goto :help
if "%1"=="/nocui" set buildcui=0
if "%1"=="/nogui" set buildgui=0
shift
goto :loop
:done

if %buildcui%==0 goto :gui
cd modshell
make -f Makefile.w32
cd ..
:gui
if %buildgui%==0 goto :end
cd xmodshell
make -f Makefile.w32
cd ..
goto end

:help
echo Usage: %0 [/?] [nocui] [nogui]
goto end

:end
