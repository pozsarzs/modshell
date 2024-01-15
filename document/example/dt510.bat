@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | dt510                                                                      |
# | Example script * Read Datcon DT510 power meter                             |
# +----------------------------------------------------------------------------+

cls
print "Example\ script\ -\ Read\ Datcon\ DT510\ power\ meter"
print "----------------------------------------------"

# variables
var p
var q
var s
var u
var i
var UID 1

print "Protocol:\ Modbus/ASCII"
print "UID:\ " -n
print $UID

# settings
set dev0 ser com1 9600 7 e 1
set pro0 ascii $UID
set con0 dev0 pro0
echo on

# read remote data
print "\ "
print "-\ telegrams:"
read con0 hreg 100 6

#calculations
let $p hreg 100
let $q hreg 101
let $s hreg 102
let $u hreg 103
let $i hreg 104
mul $p $p 3000
div $p $p 32767
mul $q $q 3000
div $q $q 32767
mul $s $s 3000
div $s $s 32767
mul $u $u 367.7
div $u $u 32767
mul $i $i 8.17
div $i $i 32767
round $p $p 1
round $q $q 1
round $s $s 1
round $u $u 1
round $i $i 3

# result
print "\ "
print "-\ measured\ data:"
print "P:\ " -n
print $p -n
print "\ W"
print "Q:\ " -n
print $q -n
print "\ VAr"
print "S:\ " -n
print $s -n
print "\ VA"
print "U:\ " -n
print $u -n
print "\ V"
print "I:\ " -n
print $i -n
print "\ A"

:eof
