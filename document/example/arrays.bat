@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | arrays                                                                     |
# | Example script * How to use arrays                                         |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ How\ to\ use\ arrays"
print "----------------------------------"

# constants
carr NUMS 10
for $i 0 to 9 do let $nums[$i] $i

# variables
var i
varr EMPTY 10

print "Elements of the NUMS array:"
for $i 0 to 9 do print $nums[$i]

print "Elements of the EMPTY array:"
for $i 0 to 9 do print $empty[$i]

print "Copy NUMS -> EMPTY..."
copyarr NUMS EMPTY 10

print "Elements of the EMPTY array:"
for $i 0 to 9 do print $empty[$i]

:eof
