@echo off
rem Build programs for 64 bit Windows

cd modshell
make -f Makefile.w64
cd ..\xmodshell
make -f Makefile.w64
cd ..
