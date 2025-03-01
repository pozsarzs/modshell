@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | copyset2.bat                                                               |
# | Example script * Copy settings between same devices                        |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ Copy\ settings\ between\ same\ devices"
print "---------------------------------------------------"

# set devices
set dev0 ser COM1 9600 7 E 2
set dev1 ser COM2 9600 7 E 2

# set protocol
set pro0 rtu 1
set pro1 rtu 2

# set connections
set con0 dev0 pro0
set con1 dev1 pro1

# copy settings
copyreg con0 hreg con1 hreg 100 20

print "Contents\ of\ copied\ registers:"
print hreg 100 20

:eof
