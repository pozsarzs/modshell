@echo off
rem Build programs for 32 bit Windows

cd modshell
make -f Makefile.w32
cd ..\xmodshell
make -f Makefile.w32
cd ..
