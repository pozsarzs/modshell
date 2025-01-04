@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | addition.bat                                                               |
# | Example script * How to use variables?                                     |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ How\ to\ use\ variables?"
print "--------------------------------------"

var a 24
var b
var c
let $b 2

print "Value\ of\ the\ variable\ $A:"
print $a

print "Value\ of\ the\ variable\ $B:"
print $b

add $c $a $b

print "The\ sum\ of\ $A\ and\ $B:"
print $c

print "All\ variables:"
var

:eof