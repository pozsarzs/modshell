{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | resstrng.pas                                                             | }
{ | resource strings                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

resourcestring
  // NUMBERS
  NUM1 = '1st ';
  NUM2 = '2nd ';
  NUM3 = '3rd ';
  NUM4 = '4th ';
  NUM5 = '5th ';
  NUM6 = '6th ';
  NUM7 = '7th ';
  // GENERAL MESSAGES
  MSG01 = '<F1> help <F2> savecfg <F3> loadcfg <F4> savereg <F5> loadreg <F6> dump <F8> clear <F10> exit';
  MSG02 = 'Command-driven scriptable Modbus utility';
  MSG03 = 'Use ''help COMMAND'' to show usage.';
  MSG04 = 'Usage this command:';
  MSG05 = 'parameter:';
  MSG06 = ' is not set.';
  MSG07 = ' device:          ';
  MSG08 = ' port:            ';
  MSG09 = ' baudrate:        ';
  MSG10 = ' bits:            ';
  MSG11 = ' protocol:        ';
  MSG12 = ' IP address:      ';
  MSG13 = ' device ID:       ';
  MSG14 = 'File exist, overwrite? (y/n)';
  MSG15 = 'Command line history has exported to ';
  MSG16 = 'Settings has saved to ';
  MSG17 = 'Settings has loaded from ';
  MSG18 = 'Register content has exported to ';
  MSG19 = 'Register content has imported from ';
  MSG20 = 'Register content has saved to ';
  MSG21 = 'Register content has loaded from ';
  MSG22 = 'Useable file types: ';
  MSG23 = 'Press a key to continue... ';
  MSG24 = 'Note:' +  EOL +
          '  - register: local buffer register' + EOL +
          '  - remote register: register of the connected device' + EOL;
  MSG25 = 'Select register type: ';
  MSG26 = 'Local register type (dinp/coil/ireg/hreg: 1/2/3/4): ';
  MSG27 = 'Start data address (0-9990): ';
  MSG28 = 'Echo method: ';
  MSG29 = 'Mini serial console (exit: <F10>)';
  MSG30 = 'Device number (0-7): ';
  MSG31 = 'Press <Esc> to break receiving.';
  MSG32 = 'Variable monitor mode: ';
  MSG33 = 'This command can only be used in a script!';
  MSG34 = 'line';
  MSG35 = 'hour';
  MSG36 = 'minute';
  MSG37 = 'status';
  MSG38 = 'No script loaded.';
  MSG39 = 'Scroll: [Home][PgUp][Up]-[Down][PgDn][End]';
  MSG40 = 'Move:   [Ctrl-Home][Ctrl-Left][Left]-[Right][Ctrl-Right][Ctrl-End]';
  MSG41 = 'Edit:   [Ins][Del][Esc]';
  MSG42 = 'all file|*';
  MSG43 = 'batch file|*.bat|all file|*.*';
  MSG44 = '&Cancel';
  MSG45 = '&Set';
  MSG46 = '&Reset';
  MSG47 = 'foreground';
  MSG48 = 'background';
  MSG49 = 'type';
  MSG50 = 'device';
  MSG51 = 'baudrate' + EOL + 'IP address';
  MSG52 = 'databits' + EOL + 'port';
  MSG53 = 'parity';
  MSG54 = 'stopbit(s)';
  MSG55 = 'protocol';
  MSG56 = 'ID/address';
  MSG57 = 'CSV file|*.csv|INI file|*.ini|XML file|*.xml';
  MSG58 = 'INI file|*.ini|XML file|*.xml';
  MSG59 = 'registers';
  MSG60 = 'start data address';
  MSG61 = 'count';
  MSG62 = '&Export';
  MSG63 = '&Dump';
  MSG64 = 'Use ''Project/Set console colors'' on GUI version.';
  MSG65 = 'Use ''Script/Edit script'' on GUI version.';
  MSG66 = 'from';
  MSG67 = 'to';
  MSG68 = 'number';
  MSG69 = '&Write';
  MSG70 = '&Start';
  MSG71 = 'New project name:';
  MSG72 = 'name';
  MSG73 = 'connection';
  MSG74 = 'variable';
  MSG75 = 'message';
  MSG76 = '';
  MSG77 = '&Read';
  MSG78 = 'Go on!';
  MSG79 = 'Variables';
  MSG80 = 'Values';
  MSG81 = 'Use ''Utilities/Mini serial console'' on GUI version.';
  MSG82 = 'timeout';
  MSG83 = ' or a variable';
  MSG84 = ' or "text"';
  MSG85 = 'Cannot use it on this operation system!';
  MSG86 = ' device address:  ';
  MSG87 = 'Cannot use it in GUI version!';
  MSG88 = 'Use ''Utilities/Mini TCP console'' on GUI version.';
  MSG89 = 'Input method: ';
  MSG90 = 'Send method: ';
  MSG91 = 'Monitor running...';
  MSG92 = 'Monitor paused.';
  MSG93 = 'Monitor stopped.';
  MSG94 = 'Build date:  ';
  MSG95 = 'Builder:     ';
  MSG96 = 'FPC version: ';
  MSG97 = 'Target OS:   ';
  MSG98 = 'Target CPU:  ';
  MSG99 = 'Sorry, this feature is not yet implemented.';
  MSG100 = '[press space]';
  MSG101 = 'Press [SPACE] to pause or [ESC] to exit.';
  MSG102 = 'Serial port: ';
  MSG103 = 'Protocol:    ';
  MSG104 = 'RC  ';
  MSG105 = '[+]  ';
  MSG106 = '[-]  ';
  MSG107 = 'ID   FC  DATA';
  MSG108 = 'Use ''Modbus/Show serial Modbus traffic'' on GUI version.';
  MSG109 = 'Discrete input contacts';
  MSG110 = 'Discrete output coils';
  MSG111 = 'Analog input registers';
  MSG112 = 'Analog output holding registers';
  // ERROR MESSAGES
  ERR00 = 'No such command!';
  ERR01 = 'Device number must be 0-7!';
  ERR02 = 'Protocol number must be 0-7!';
  ERR03 = 'Connection number must be 0-7!';
  ERR04 = 'IP address is not valid!';
  ERR05 = 'Parameter(s) required!';
  ERR06 = 'Device ID must be 1-247!';
  ERR07 = 'Cannot export command line history to ';
  ERR08 = 'Cannot save settings to ';
  ERR09 = 'Cannot load settings from ';
  ERR10 = 'Cannot export register content to ';
  ERR11 = 'Cannot import register content from ';
  ERR12 = 'Cannot save register content to ';
  ERR13 = 'Cannot load register content from ';
  ERR14 = 'Illegal character in the project name!';
  ERR15 = 'Illegal character in the variable name!';
  ERR16 = 'Cannot define more variable!';
  ERR17 = 'There is already a variable or a constant with that name.';
  ERR18 = 'Cannot initialize serial port: ';
  ERR19 = 'No such variable: ';
  ERR20 = 'Calculating error!';
  ERR21 = 'No such script file: ';
  ERR22 = 'Cannot load script from ';
  ERR23 = 'Script buffer is full!';
  ERR24 = 'Specified device is not a serial port!';
  ERR25 = 'Specified device is not a ethernet port!';
  ERR26 = 'Cannot read data from serial port!';
  ERR27 = 'Cannot write data to serial port!';
  ERR28 = 'Modbus telegram parsing error!';
  ERR29 = 'Modbus error: illegal function.';
  ERR30 = 'Modbus error: illegal data address.';
  ERR31 = 'Modbus error: illegal data value.';
  ERR32 = 'Modbus error: slave device failure.';
  ERR33 = 'Illegal character in the constant name!';
  ERR34 = 'Cannot define more constant!';
  ERR35 = 'No such label: ';
  ERR36 = 'Cannot write log record to ';
  ERR37 = 'Cannot save script to ';
  ERR38 = 'Cannot run default webbrowser!';
  ERR39 = 'Cannot list directory!';
  ERR40 = 'Cannot change directory!';
  ERR41 = 'Cannot make directory!';
  ERR42 = 'Cannot remove directory!';
  ERR43 = 'Cannot erase file!';
  ERR44 = 'Cannot type file!';
  ERR45 = 'Cannot copy file!';
  ERR46 = 'Cannot rename file!';
  ERR47 = 'Cannot set connection timeout!';
  ERR48 = 'Operation error!';
  ERR49 = 'Locked device!';
  ERR50 = 'Cannot create console log file!';
  ERR51 = 'The value of the constant can only be set once!';
  ERR52 = 'No such array: ';
  ERR53 = 'Cannot define more array!';
  ERR54 = 'Address must be 1-255!';
  ERR55 = 'The specified parameter is not a variable array: ';
  ERR56 = 'This can only be used with the DCON protocol!';
  ERR57 = 'You did not provide something!';
  ERR58 = 'Cannot initialize socket!';
  ERR59 = 'Illegal character in the macro name!';
  ERR60 = 'Cannot define more macro!';
  ERR61 = 'Cannot create Modbus traffic log file!';
  ERR99 = 'Minimal terminal size is 80x25!';
  // COMMAND DESCRIPTION
  DES00='         copy one or more remote reg. between two connections';
  DES01='F10      exit from program';
  DES02='ALT-G    show device, protocol, connection or project name';
  DES03='F1       show description or usage of the commands';
  DES04='ALT-L    set value of a variable or a register';
  DES05='ALT-P    print message, value of the variable and register';
  DES06='ALT-R    read one or more remote registers to buffer';
  DES07='ALT-T    reset device, protocol, connection or project name';
  DES08='ALT-S    set device, protocol, connection, default colors, project name or timeout';
  DES09='         show system date and time';
  DES10='         show version and build information of this program';
  DES11='ALT-W    write data from buffer to one or more remote registers';
  DES12='F8       clear screen';
  DES13='F2       save settings of device, protocol and connection';
  DES14='F3       load settings of device, protocol and connection';
  DES15='ALT-E    export value of the one or more registers';
  DES16='         export command line history to make a script easily';
  DES17='ALT-C    convert value between different numeral systems';
  DES18='F4       save all registers';
  DES19='F5       load all registers';
  DES20='         list all variable with value or define a new one';
  DES21='         set temporary foreground and background colors for print command';
  DES22='ALT-I    import value of the one or more registers';
  DES23='         AND logical operations';
  DES24='         OR logical operations';
  DES25='         NOT logical operations';
  DES26='         XOR logical operations';
  DES27='         bit shift to left';
  DES28='         bit shift to right';
  DES29='         addition mathematical operation';
  DES30='         substraction mathematical operation';
  DES31='         multiplication mathematical operation';
  DES32='         division mathematical operation';
  DES33='F6       dump all registers in binary/hexadecimal format to a table';
  DES34='         wait for a keystroke or specified time';
  DES35='F7       open a mini serial console';
  DES36='         read string from serial device';
  DES37='         write string to serial device';
  DES38='F9       query or change local echo status';
  DES39='SHIFT-F3 load ModShell script from file';
  DES40='F12      run loaded ModShell script';
  DES41='F11      list loaded ModShell script';
  DES42='         round real number';
  DES43='         cosine function';
  DES44='         cotangent function';
  DES45='         decrement integer';
  DES46='         natural exponential';
  DES47='         integer division';
  DES48='         modulus division';
  DES49='         increment integer';
  DES50='         natural logarithm';
  DES51='         multiplicative inverse';
  DES52='         odd or event';
  DES53='         create random integer';
  DES54='         tangent function';
  DES55='         sine function';
  DES56='         square';
  DES57='         square root';
  DES58='         roll bit of integer to left';
  DES59='         roll bit of integer to right';
  DES60='         conversion to uppercase';
  DES61='         length of string';
  DES62='         conversion to lowercase';
  DES63='         specified element of the string';
  DES64='         convert byte to char';
  DES65='         convert char to byte';
  DES66='         list all constant with value or define a new one';
  DES67='         value of the specified bit';
  DES68='         exponentiation';
  DES69='         jump to specified label (only in script)';
  DES70='         selection statement';
  DES71='         loop iteration';
  DES72='         define label (only in script)';
  DES73='         start internal Modbus slave/server';
  DES74='         start internal Modbus gateway';
  DES75='         check the value is in the range';
  DES76='         make LRC';
  DES77='         make CRC';
  DES78='         exponentiation of two';
  DES79='         show ASCII table';
  DES80='         make a beep sound with internal speaker';
  DES81='         calculate average';
  DES82='         propotional value calculation (with zero and span)';
  DES83='         concatenate strings';
  DES84='         delete specified element(s) of the string';
  DES85='         find specified element(s) in the string';
  DES86='         insert element(s) into string';
  DES87='         replace element(s) in the string';
  DES88='ALT-M    monitoring the value of variables';
  DES89='         append a record to log file';
  DES90='         loaded script scheduled execution';
  DES91='SHIFT-F4 edit loaded script with line editor';
  DES92='SHIFT-F8 erase script from buffer';
  DES93='SHIFT-F2 save loaded script to disc';
  DES94='         list directory content';
  DES95='         change directory or get name';
  DES96='         make directory';
  DES97='         remove directory';
  DES98='         remove file';
  DES99='         type file';
  DES100='         copy file';
  DES101='         rename file';
  DES102='         existence of a file or directory';
  DES103='         check device lock file';
  DES104='         remove device lock file';
  DES105='         show all constants array with their value or define a new one';
  DES106='         show all variable array with their value or define a new one';
  DES107='         clear content of an array';
  DES108='         fill an array with a character';
  DES109='         get size of an array';
  DES110='         set size of an array';
  DES111='         read/write data from/to remote device with DCON protocol';
  DES112='SHIFT-F7 open a mini TCP console';
  DES113='         read string with TCP from network device';
  DES114='         write string with TCP to network device';
  DES115='         open a mini UDP console';
  DES116='         read string with UDP from network device';
  DES117='         write string with UDP to network device';
  DES118='         read/write data from/to remote device with HART protocol';
  DES119='SHIFT-F9 query or change input method';
  DES120='CTRL-F9  query or change send method';
  DES121='         create one-line macro';
  DES122='         serial Modbus traffic monitor';
  DES123='         Modbus register number/address converter';
  DES124='         specify the type of the value';  
  // COMMAND USAGE
  USG00='copyreg con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG01='exit';
  USG02='get dev?|pro?|con?|project|timeout' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.' + EOL +
        '  - The timeout value is in s.';
  USG03='help [[$]COMMAND]';
  USG04='let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE' + EOL +
        '  let $VARIABLE [$]VALUE' + EOL +
        '  let $VARIABLE nul' + EOL +
        '  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS';
  USG05='print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT] [-n]' + EOL +
        '  print $VARIABLE [-n]' + EOL +
        '  print "single\ line\ message" [-n]';
  USG06='readreg con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]';
  USG07='reset dev?|pro?|con?|project' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG08='set dev? net [$]DEVICE [$]IP_ADDRESS [$]PORT' + EOL +
        '  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT' + EOL +
        '  set pro? ascii|rtu|tcp [$]ID' + EOL +
        '  set pro? dcon [$]ADDRESS' + EOL +
        '  set con? dev? pro?' + EOL +
        '  set color [$]FOREGROUND [$]BACKGROUND [$]RXD_TEXT [$]TXD_TEXT [$]VAR_MON' + EOL +
        '  set project [$]PROJECT_NAME' + EOL +
        '  set timeout [$]TIMEOUT' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.' + EOL +
        '  - The ''TIMEOUT'' value can be 1-60 (s).' + EOL +
        '  - Colors:' + EOL +
        '      0: black  4: red         8: darkgray    12: lightred' + EOL +
        '      1: blue   5: magenta:    9: lightblue   13: lightmagenta' + EOL +
        '      2: green  6: brown      10: lightgreen  14: yellow' + EOL +
        '      3: cyan   7: lightgray  11: lightcyan   15: white';
  USG09='date [$TARGET]';
  USG10='ver';
  USG11='writereg con? coil|hreg [$]ADDRESS [[$]COUNT]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG12='cls';
  USG13='savecfg [$]PATH_AND_FILENAME';
  USG14='loadcfg [$]PATH_AND_FILENAME';
  USG15='expreg [$]PATH_AND_FILENAME dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]';
  USG16='exphis [$]PATH_AND_FILENAME';
  USG17='conv $TARGET $FROM|bin|dec|hex|oct $TO|bin|dec|hex|oct [$]VALUE';
  USG18='savereg [$]PATH_AND_FILENAME';
  USG19='loadreg [$]PATH_AND_FILENAME';
  USG20='var' + EOL +
        '  var NAME [[$]VALUE]';
  USG21='printcolor [$]FOREGROUND [$]BACKGROUND' + EOL +
        'Notes:' + EOL +
        '  - Colors:' + EOL +
        '      0: black  4: red         8: darkgray    12: lightred' + EOL +
        '      1: blue   5: magenta:    9: lightblue   13: lightmagenta' + EOL +
        '      2: green  6: brown      10: lightgreen  14: yellow' + EOL +
        '      3: cyan   7: lightgray  11: lightcyan   15: white';
  USG22='impreg [$]PATH_AND_FILENAME';
  USG23='and $TARGET [$]VALUE1 [$]VALUE2';
  USG24='or $TARGET [$]VALUE1 [$]VALUE2';
  USG25='not $TARGET [$]VALUE';
  USG26='xor $TARGET [$]VALUE1 [$]VALUE2';
  USG27='shl $TARGET [$]VALUE1 [$]VALUE2';
  USG28='shr $TARGET [$]VALUE1 [$]VALUE2';
  USG29='add $TARGET [$]VALUE1 [$]VALUE2';
  USG30='sub $TARGET [$]VALUE1 [$]VALUE2';
  USG31='mul $TARGET [$]VALUE1 [$]VALUE2';
  USG32='div $TARGET [$]VALUE1 [$]VALUE2';
  USG33='dump [[dinp|coil|ireg|hreg] [$]ADDRESS]';
  USG34='pause [[$]TIME]';
  USG35='sercons [dev?]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG36='serread dev? [$TARGET]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG37='serwrite dev? $MESSAGE' + EOL +
        '  serwrite dev? "MESSAGE"' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG38='echometh [off|an|hex|swap]';
  USG39='loadscr [$]PATH_AND_FILENAME';
  USG40='run [-h] [-s]';
  USG41='list';
  USG42='round $TARGET [$]VALUE [$]DEC_PLACES';
  USG43='cos $TARGET [$]VALUE';
  USG44='cotan $TARGET [$]VALUE';
  USG45='dec $VARIABLE';
  USG46='exp $TARGET [$]VALUE';
  USG47='idiv $TARGET [$]VALUE1 [$]VALUE2';
  USG48='imod $TARGET [$]VALUE1 [$]VALUE2';
  USG49='inc $VARIABLE';
  USG50='ln $TARGET [$]VALUE';
  USG51='mulinv $TARGET [$]VALUE';
  USG52='odd $TARGET [$]VALUE';
  USG53='rnd $TARGET [$]VALUE';
  USG54='tan $TARGET [$]VALUE';
  USG55='sin $TARGET [$]VALUE';
  USG56='sqr $TARGET [$]VALUE';
  USG57='sqrt $TARGET [$]VALUE';
  USG58='roll $TARGET [$]VALUE1 [$]VALUE2';
  USG59='rolr $TARGET [$]VALUE1 [$]VALUE2';
  USG60='upcase $TARGET [$]VALUE';
  USG61='length $TARGET [$]VALUE';
  USG62='lowcase $TARGET [$]VALUE';
  USG63='stritem $TARGET [$]VALUE1 [$]VALUE2';
  USG64='chr $TARGET [$]VALUE';
  USG65='ord $TARGET [$]VALUE';
  USG66='const' + EOL +
        '  const NAME [[$]VALUE]';
  USG67='bit $TARGET [$]VALUE1 [$]VALUE2';
  USG68='pow $TARGET [$]BASE [$]EXPONENT';
  USG69='goto LABEL';
  USG70='if [$]VALUE1 RELATIONAL_SIGN [$]VALUE2 then COMMAND';
  USG71='for $VARIABLE [$]VALUE1 to [$]VALUE2 do COMMAND';
  USG72='label NAME';
  USG73='mbsrv con?' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG74='mbgw con? con?' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG75='inrange $TARGET [$]MIN [$]MAX [$]VALUE';
  USG76='mklrc $TARGET [$]STRING';
  USG77='mkcrc $TARGET [$]STRING';
  USG78='pow2 $TARGET [$]EXPONENT';
  USG79='ascii [dec|hex]';
  USG80='beep';
  USG81='avg $TARGET [$]VALUE1 [$]VALUE2 [[$]VALUE3...6]';
  USG82='prop $TARGET [$]MIN [$]MAX [$]ZERO [$]SPAN [$]VALUE';
  USG83='concat $TARGET [$]VALUE1 [$]VALUE2';
  USG84='strdel $TARGET [$]PLACE [$]COUNT';
  USG85='strfind $TARGET [$]VALUE';
  USG86='strins $TARGET [$]PLACE [$]VALUE';
  USG87='strrepl $TARGET [$]OLD [$]NEW';
  USG88='varmon on|off' + EOL +
        '  varmon $VARIABLE on|off';
  USG89='applog [$]LOGFILE $TEXT [$]LEVEL [[$]VALUE1] ... [[$]VALUE4]' + EOL +
        '  applog [$]LOGFILE "TEXT\ $$1\ TEXT" [$]LEVEL [$]VALUE1' + EOL +
        'Notes:' + EOL +
        '  - The ''$$1'' value can be $$1-$$4.' + EOL +
        '  - The ''LEVEL'' value can be 0-4:' + EOL +
        '    NOTE, MESSAGE, WARNING, ERROR, DEBUG.';
  USG90='cron' + EOL +
        '  cron rec_num hour minute' + EOL +
        '  cron [-r rec_num]';
  USG91='edit [LINE_NUMBER]';
  USG92='erasescr';
  USG93='savescr [$]PATH_AND_FILENAME';
  USG94='dir [[$]PATH_AND_DIRECTORYNAME]';
  USG95='cd [[$]PATH_AND_DIRECTORYNAME]';
  USG96='md [$]PATH_AND_DIRECTORYNAME';
  USG97='rd [$]PATH_AND_DIRECTORYNAME';
  USG98='del [$]PATH_AND_FILENAME';
  USG99='type [$]PATH_AND_FILENAME';
  USG100='copy [$]PATH_AND_FILENAME [$]NEW_PATH_AND_FILENAME';
  USG101='ren [$]PATH_AND_FILENAME [$]NEW_PATH_AND_FILENAME';
  USG102='exist [$]PATH_AND_FILENAME';
  USG103='chkdevlock [$]DEVICE';
  USG104='rmdevlock [$]DEVICE';
  USG105='carr' + EOL +
         '  carr ARRAY' + EOL +
         '  carr ARRAY SIZE';
  USG106='varr' + EOL +
         '  varr ARRAY' + EOL +
         '  varr ARRAY SIZE';
  USG107='arrclear ARRAY';
  USG108='arrfill ARRAY [$]DATA';
  USG109='getarrsize ARRAY $TARGET';
  USG110='setarrsize ARRAY [$]SIZE';
  USG111='dcon con? $TXARRAY $RXARRAY' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG112='tcpcons [dev?]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG113='tcpread dev? [$TARGET]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG114='tcpwrite dev? $MESSAGE' + EOL +
        '  tcpwrite dev? "MESSAGE"' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG115='udpcons [dev?]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG116='udpread dev? [$TARGET]' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG117='udpwrite dev? $MESSAGE' + EOL +
        '  udpwrite dev? "MESSAGE"' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG118='hart con? $TXARRAY $RXARRAY' + EOL +
        'Notes:' + EOL +
        '  - The ''?'' value can be 0-7.';
  USG119='inputmeth [an|hex|swap]';
  USG120='sendmeth [chr|str|swap]';
  USG121='macro NAME command with parameters';
  USG122='mbmon [con?]';
  USG123='mbconv $TARGET_REGISTER_TYPE $TARGET_ADDRESS [$]REGISTER_NUMBER' + EOL +
         '  mbconv $TARGET_NUMBER [$]REGISTER_TYPE [$]ADDRESS';
  USG124='datatype [$]VALUE' + EOL +
        'Notes:' + EOL +
        '  - The result will be in the exit code:' + EOL +
        '  0: string, 1: floating-point value, 1: integer value.';
