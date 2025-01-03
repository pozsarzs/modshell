@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | getpm9c1.bat                                                               |
# | Example script * Read Schneider PM9C power meter 1.                        |
# +----------------------------------------------------------------------------+

# constants and variables
const ID 1
var uh
var ul
var u
var ih
var il
var i
var fh
var fl
var f

# header
cls
print "Example\ script\ -\ Read\ Schneider\ PM9C\ power\ meter\ #1"
print "---------------------------------------------------"
print "Protocol:\ Modbus/RTU"
print "ID:\ " -n
print $ID
echometh hex

# settings
set dev0 ser /dev/ttyUSB2 9600 8 n 1
set pro0 rtu $ID
set con0 dev0 pro0
set timeout 1

# read remote data
print "\ "
readreg con0 hreg 1000 22

# calculations
let $uh hreg 1014
let $ul hreg 1015
mul $u $uh 65536
add $u $u $ul
div $u $u 1000
let $ih hreg 1000
let $il hreg 1001
mul $i $ih 65536
add $i $i $il
div $i $i 1000
let $fh hreg 1020
let $fl hreg 1021
mul $f $fh 65536
add $f $f $fl
div $f $f 100

# print result
print "\ "
print "Measured\ data:"
print "\ U:\ " -n
print $u -n
print "\ V"
print "\ I:\ " -n
print $i -n
print "\ A"
print "\ f:\ " -n
print $f -n
print "\ Hz"

:eof
