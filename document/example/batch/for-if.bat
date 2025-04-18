@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | for-if.bat                                                                 |
# | Example script * How to use for-to-do and if-then?                         |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ How\ to\ use\ for-to-do\ and\ if-then?"
print "--------------------------------------------------"

# constants
const MIN 1
const MAX 1000

# variables
var value
var half

print "minimum:\ " -n
print $MIN
print "maximum:\ " -n
print $MAX
print "\ "
print "I'll\ count\ up\ to\ the\ maximum\ and\ post\ when\ I'm\ halfway\ there:\ " -n
div $half $max 2
for $value $min to $max do if $value = $half then print $value

:eof
