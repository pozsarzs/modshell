@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | setdt510.bat                                                               |
# | Example script * Read Datcon DT510 power meter                             |
# +----------------------------------------------------------------------------+

# constants and variables
const ORIGUID 1
const NEWUID 2
var a

# header
cls
print "Example\ script\ -\ Set\ UID\ of\ the\ Datcon\ DT510\ power\ meter"
print "--------------------------------------------------------"
print "Protocol:\ Modbus/ASCII"

# settings
# uncomment next line on DOS or Windows:
#set dev0 ser com1 9600 7 e 1
# uncomment next line on Linux:
set dev0 ser /dev/ttyS0 9600 7 e 1
# uncomment next line on FreeBSD:
#set dev0 ser /dev/cuau0 9600 7 e 1
set pro0 ascii $ORIGUID
set con0 dev0 pro0
echo off

# read and print original setting
read con0 hreg 200 3
print "\ "
print "Original\ settings:"
print "\ UID:\ " -n
print hreg 200
let $a hreg 201
print "\ Baudrate:\ " -n
if $a = 0 then print "9600" -n
if $a = 1 then print "4800" -n
if $a = 2 then print "2400" -n
if $a = 3 then print "1200" -n
print "\ baud"
let $a hreg 202
print "\ Parity:\ " -n
if $a = 0 then print "even"
if $a = 1 then print "odd"
print "\ "

# set new UID
let hreg 200 $NEWUID
write con0 hreg 200 $NEWUID

# read and print original setting
set pro0 ascii $NEWUID
read con0 hreg 200 3
print "\ "
print "New\ settings:"
print "\ UID:\ " -n
print hreg 200
let $a hreg 201
print "\ Baudrate:\ " -n
if $a = 0 then print "9600" -n
if $a = 1 then print "4800" -n
if $a = 2 then print "2400" -n
if $a = 3 then print "1200" -n
print "\ baud"
let $a hreg 202
print "\ Parity:\ " -n
if $a = 0 then print "even"
if $a = 1 then print "odd"

:eof
