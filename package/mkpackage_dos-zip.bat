@echo off
rem create zip and exe (SFX zip) package on DOS

set NAME=mdsh
set VERSION=01b2
set UNZIPSFX=c:\utils\unzipsfx.exe

zip -r -9 %NAME%%VERSION%.zip modshell
copy /b %UNZIPSFX%+%NAME%%VERSION%.zip %NAME%%VERSION%.exe
