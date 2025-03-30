@echo off
rem create vsix file

cd modshell-script
vsce package
move *.vsix ..
cd ..
