@echo off
rem ModShell 0.1 * Command-driven scriptable Modbus utility
rem Copyright (C) 2023-2024 Pozsar Zsolt pozsarzs@gmail.com
rem buildwin64.bat
rem Build program for 64 bit Windows

set buildcui=1
set buildgui=1
set buildutil=1

:loop
if "%1"=="" goto :done
if "%1"=="/?" goto :help
if "%1"=="/nocui" set buildcui=0
if "%1"=="/nogui" set buildgui=0
if "%1"=="/noutil" set buildutil=0
shift
goto :loop
:done

if %buildcui%==0 goto :util
cd modshell
make -f Makefile.w64
cd ..

:util
if %buildutil%==0 goto :gui
cd serialechoserver
make -f Makefile.w64
cd ..
cd serialmbmonitor
make -f Makefile.w64
cd ..
cd tcpechoserver
make -f Makefile.w64
cd ..
cd udpechoserver
make -f Makefile.w64
cd ..

:gui
if %buildgui%==0 goto :end
cd xmodshell
make -f Makefile.w64
cd ..
goto end

:help
echo Usage: %0 [/?] [/nocui] [/nogui] [/noutil]
goto end

:end
