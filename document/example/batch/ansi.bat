@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | ansi.bat                                                                   |
# | Example script * Color text with ANSI Escape sequences                     |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ Color\ text\ with\ ANSI\ Escape\ sequences"
print "------------------------------------------------------"

print "Flag\ colors\ of\ our\ neighboring\ countries:"
print "\ *\ Austria:\ \ ^[1;31m******\ ^[1;37m******\ ^[1;31m******^[0m,"
print "\ *\ Croatia:\ \ ^[1;31m******\ ^[1;37m******\ ^[1;34m******^[0m,"
print "\ *\ Romania:\ \ ^[1;34m******\ ^[1;33m******\ ^[1;31m******^[0m,"
print "\ *\ Serbia:\ \ \ ^[1;31m******\ ^[1;34m******\ ^[1;37m******^[0m,"
print "\ *\ Slovakia:\ ^[1;37m******\ ^[1;34m******\ ^[1;31m******^[0m,"
print "\ *\ Slovenia:\ ^[1;37m******\ ^[1;34m******\ ^[1;31m******^[0m,"
print "\ *\ Ukraine:\ \ ^[1;34m*********\ ^[1;33m**********^[1;0m"
print "and\ my\ country:"
print "\ *\ Hungary:\ \ ^[1;31m******\ ^[1;37m******\ ^[1;32m******^[0m."

:eof
