@echo off
rem ModShell v0.1 * Command-driven scriptable Modbus utility
rem Copyright (C) 2023-2025 Pozsar Zsolt pozsarzs@gmail.com
rem buildwin32.bat
rem Build program for 32 bit Windows

set buildcui=1
set buildgui=1
set buildutil=1
set buildlhelp=1

:loop
if "%1"=="" goto :done
if "%1"=="/?" goto :help
if "%1"=="/nocui" set buildcui=0
if "%1"=="/nogui" set buildgui=0
if "%1"=="/noutil" set buildutil=0
if "%1"=="/nolhelp" set buildlhelp=0
shift
goto :loop
:done

if %buildcui%==0 goto :util
cd modshell
make -f Makefile.w32
cd ..

:util
if %buildutil%==0 goto :lhelp
cd serialechoserver
make -f Makefile.w32
cd ..
cd serialmbmonitor
make -f Makefile.w32
cd ..
cd tcpechoserver
make -f Makefile.w32
cd ..
cd udpechoserver
make -f Makefile.w32
cd ..

:lhelp
if %buildlhelp%==0 goto :gui
cd lhelp
make -f Makefile.w32
cd ..

:gui
if %buildgui%==0 goto :end
cd xmodshell
make -f Makefile.w32
cd ..
goto end

:help
echo Usage: %0 [/?] [/nocui] [/nogui] [/noutil] [/nolhelp]
goto end

:end
