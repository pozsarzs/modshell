@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | setdt510.bat                                                               |
# | Example script * Set ID of the Datcon DT510 power meter                    |
# +----------------------------------------------------------------------------+

# constants and variables
const ORIGID 1
const NEWID 2
var a

# header
cls
print "Example\ script\ -\ Set\ ID\ of\ the\ Datcon\ DT510\ power\ meter"
print "-------------------------------------------------------"
print "Protocol:\ Modbus/ASCII"

# settings
# set device on DOS/Windows:
set dev0 ser COM1 9600 7 e 1
set pro0 ascii $ORIGID
set con0 dev0 pro0
echometh off

# read and print original setting
readreg con0 hreg 200 3
print "\ "
print "Original\ settings:"
print "\ ID:\ " -n
print hreg 200
let $a hreg 201
print "\ Baudrate:\ " -n
if $a = 0 then print $B9 -n
if $a = 1 then print $B4 -n
if $a = 2 then print $B2 -n
if $a = 3 then print $B1 -n
print "\ baud"
let $a hreg 202
print "\ Parity:\ " -n
if $a = 0 then print "even"
if $a = 1 then print "odd"
print "\ "

# set new ID
let hreg 200 $NEWID
writereg con0 hreg 200 $NEWID

# read and print original setting
set pro0 ascii $NEWID
readreg con0 hreg 200 3
print "\ "
print "New\ settings:"
print "\ ID:\ " -n
print hreg 200
let $a hreg 201
print "\ Baudrate:\ " -n
if $a = 0 then print $B9 -n
if $a = 1 then print $B4 -n
if $a = 2 then print $B2 -n
if $a = 3 then print $B1 -n
print "\ baud"
let $a hreg 202
print "\ Parity:\ " -n
if $a = 0 then print "even"
if $a = 1 then print "odd"

:eof
