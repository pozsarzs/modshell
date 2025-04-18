@modshell.exe -r %0 %1 %2 %3
@goto :eof
# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | numconv                                                                    |
# | NumConv v0.1 * Number converter utility                                    |
# +----------------------------------------------------------------------------+
#
#  This program is free software: you can redistribute it and/or modify it
#  under the terms of the European Union Public License 1.2 version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.

# VARIABLES AND CONSTANTS
# general variables
var i
var valid 255
# input data
var inpval
var numsys_from
var numsys_to
# messages
varr msg 6
  let msg[0] NumConv\ v0.1\ *\ Number\ converter\ utility
  let msg[1] (C)\ 2024-2025\ Pozsar\ Zsolt\ <http://www.pozsarzs.hu>
  let msg[2] Usage:
  let msg[3] \ \ input_value\ bin|oct|dec|hex\ bin|oct|dec|hex
  let msg[4] ERROR:\ Wrong\ input\ value.
  let msg[5] ERROR:\ Can\ only\ be\ run\ from\ the\ shell.
# numeral systems
carr NUMSYS 4
  let $NUMSYS[0] bin
  let $NUMSYS[1] oct
  let $NUMSYS[2] dec
  let $NUMSYS[3] hex

# MAIN
# check running method
runmeth
if $ <> 4 then goto runerr
# select operation mode
if $ARGCNT < 3 then goto usage
  let $inpval $ARG1
  lowcase $numsys_from $ARG2
  lowcase $numsys_to $ARG3
  # check input and output numeral system
  for $i 0 to 3 do if $numsys_from == $NUMSYS[$i] then let $valid $i
  for $i 0 to 3 do if $numsys_to == $NUMSYS[$i] then let $valid $i
  if $valid <> 255 then goto convert
  # print usage
  label usage
    print $msg[0]
    print $msg[1]
    print "\ "
    print $msg[2]
    strins $msg[3] 2 $ARG0
    print $msg[3]
    exit 1
  # converting error
  label converr
    print msg[4]
    exit 2
  # bad running mode
  label runerr
    print msg[5]
    exit 5
  # convert number
  label convert
    let $i 0
    conv $i $numsys_from $numsys_to $inpval
    if $? <> 0 then goto converr
    print $i
    exit

:eof
