@echo off
rem
rem create zip and exe (SFX zip) package on DOS
rem

set NAME=mdsh
set VERSION=01a2
set UNZIPSFX=c:\utils\unzipsfx.exe

zip -r -9 %NAME%%VERSION%.zip modshell
copy /b %UNZIPSFX%+%NAME%%VERSION%.zip %NAME%%VERSION%.exe
