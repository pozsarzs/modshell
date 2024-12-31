@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | arrays                                                                     |
# | Example script * How to use arrays?                                        |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ How\ to\ use\ arrays?"
print "-----------------------------------"

# variables
var i
varr empty 10
varr nums 10
varr

for $i 0 to 9 do let $nums[$i] $i
for $i 0 to 9 do let $empty[$i] 0

print "\ "
print "Elements\ of\ the\ NUMS\ array:"
for $i 0 to 9 do print $nums[$i]

print "Elements\ of\ the\ EMPTY\ array:"
for $i 0 to 9 do print $empty[$i]

print "Copy\ NUMS\ ->\ EMPTY..."
for $i 0 to 9 do let $empty[$i] $nums[$i]

print "Elements\ of\ the\ EMPTY\ array:"
for $i 0 to 9 do print $empty[$i]

:eof
