@modshell.exe -r %0
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | ansi                                                                       |
# | Example script * Color text with ANSI Escape sequences                     |
# +----------------------------------------------------------------------------+

print "Example\ script\ -\ Color\ text\ with\ ANSI\ Escape\ sequences"
print "------------------------------------------------------"

print "Flag\ colors\ of\ our\ neighboring\ countries:"
print "\ \ Austria:\ \ ^[1;31mred\ ^[1;37mwhite\ ^[1;31mred\ ^[1;0m"
print "\ \ Croatia:\ \ ^[1;31mred\ ^[1;37mwhite\ ^[1;34mblue\ ^[1;0m"
print "\ \ Romania:\ \ ^[1;34mblue\ ^[1;33myellow\ ^[1;31mred\ ^[1;0m"
print "\ \ Serbia:\ \ \ ^[1;31mred\ ^[1;34mblue\ ^[1;37mwhite\ ^[1;0m"
print "\ \ Slovakia:\ ^[1;37mwhite\ ^[1;34mblue\ ^[1;31mred\ ^[1;0m"
print "\ \ Slovenia:\ ^[1;37mwhite\ ^[1;34mblue\ ^[1;31mred\ ^[1;0m"
print "\ \ Ukraine:\ \ ^[1;34mblue\ ^[1;33myellow\ ^[1;0m"

:eof
