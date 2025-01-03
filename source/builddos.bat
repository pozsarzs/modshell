@echo off
rem ModShell v0.1 * Command-driven scriptable Modbus utility
rem Copyright (C) 2023-2025 Pozsar Zsolt pozsarzs@gmail.com
rem builddos.bat
rem Build program for DOS in 32 bit protected mode

cd modshell
make -f Makefile.dos
cd ..
