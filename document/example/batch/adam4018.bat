@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | adam4018.bat                                                               |
# | Example script * Read data with DCON protocol from ADAM-4018               |
# +----------------------------------------------------------------------------+

# constants and variables
const ID 3
varr txbuff 4
varr rxbuff 2

# header
cls
print "Example\ script\ -\ Read\ data\ with\ DCON\ protocol\ from\ ADAM-4018"
print "------------------------------------------------------------"
print "Protocol:\ DCON"
print "ID:\ " -n
print $ID
echometh hex
print "\ "

# settings
set dev0 ser /dev/ttyUSB2 9600 8 n 1
set pro0 dcon $ID
set con0 dev0 pro0
set timeout 1

# read remote data
let $txbuff[0] #
let $txbuff[2] 6
let $txbuff[3] 0
dcon con0 $txbuff $rxbuff
print "\ "
print "In0:\ " -n
print $rxbuff[2] -n

:eof
