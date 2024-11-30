> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
>

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="ModShell icon" src="desktop/modshell.png">   

## Modshell

**Command-driven scriptable Modbus utility**

Copyright (C) 2023-2024 Pozsár Zsolt <pozsarzs@gmail.com>  

ModShell is a utility built around a command interpreter, which with the
connected peripherals communicates via various ports using the Modbus, DCON and
HART protocols.  

|features                |                                                                                            |
|------------------------|--------------------------------------------------------------------------------------------|
|version                 |v0.1                                                                                        |
|licence                 |EUPL v1.2                                                                                   |
|language                |en, hu                                                                                      |
|architecture            |amd64, armhf, i386, x86_64                                                                  |
|operation system        |DOS, FreeBSD, Linux, Windows                                                                |
|user interface          |ModShell: CLI and TUI                                                                       |
|                        |XModShell: GUI                                                                              |
|running modes           |normal or interpreter                                                                       |
|variables               |max. 128 variables or constants (stored as string)                                          |
|arrays                  |max. 16 dynamic size array of variables or constants (elements stored as string)            |
|built-in commands       |120 commands in 10 categories                                                               |
|load from file          |registers, script, settings                                                                 |
|save to file            |command history, console traffic, registers, communication settings, user log with timestamp|
|auto save to file       |general settings and console traffic                                                        |
|export to file          |history (TXT), registers (CSV, INI, XML)                                                    |
|import to file          |registers (INI, XML)                                                                        |
|configurable devices    |max. 8 settings, serial and ethernet port                                                   |
|configurable protocols  |max. 8 settings, ASCII, RTU or TCP                                                          |
|configurable connections|max. 8 settings by combining the previous two                                               |
|raw serial communication|read/write serial port and mini serial console with char/hex echo                           |
|raw TCP communication   |read/write network device and mini TCP console with char/hex echo                           |
|DCON communication      |read and write remote devices                                                               |
|HART communication      |read and write remote devices                                                               |
|Modbus communication    |read and write remote device and copy between devices                                       |
|                        |internal server for remote access to own registers                                          |
|                        |gateway to access devices using other ports or protocols                                    |
|local Modbus registers  |2x10000 boolean and 2x10000 word type                                                       |
|script size             |max. 1024 line                                                                              |
|example scripts         |10 scripts (shellscript and batch file versions)                                            |
|script syntax plugins   |for editors using GtkSourceView, MCEdit, Micro, Nano, Notepad++, NeoVim and Vim             |

**Releases**  

_v0.1-beta1:_  
The next release _will be_ with the following changes:  
 - [ ] `echo` command parameters: off|on|hex|swap -> off|ascii|hex|swap;
 - [x] `exist` command;  
 - [x] `chkdevlock`/`rmdevlock` commands (only *nix versions);  
 - [x] `color` -> `set color`: sets all default colors (CLI and TUI);  
 - [ ] `input` command: change data input mode between ascii and hexadecimal;  
 - [x] `printcolor`: sets temporary foreground and background colors for `print` command (CLI and TUI);  
 - [x] `tcpcons`, `tcpread`, `tcpwrite` commands;  
 - [x] `udpcons`, `udpread`, `udpwrite` commands;  
 - [ ] `sercons`, `tcpcons`, `udpcons` commands: character-by-character input with immediate sending or sending as a string with alphanumeric or hexadecimal input, with or without normal or hexadecimal echo;  
 - [ ] `serwrite`, `tcpwrite`, `udpwrite` commands: alphanumeric or hexadecimal input, with or without normal or hexadecimal echo.  
 - [ ] Main menu for all consoles in GUI version;  
 - [ ] New menu item in the main menu for quick execution of Modbus R/W commands.  
 - [ ] New serial baudrates: 150, 300, 600 baud.
 - [x] DCON protocol support;  
 - [ ] HART protocol support;  
 - [ ] Modbus/TCP communication (Unix-like OS and Windows versions).  
 - [x] Support for variable and constant arrays.  
 - [x] Modified source code structure of XModshell: The main menu procedures that create a new form at runtime have been moved to files.  
 - [x] Syntax highlighter file for applications using GTKSourceView (for example: Builder, Geany, Gedit, Mousepad, Pluma, Scribes);  
 - [x] syntax highlighting file for Notepad++ (Windows only);  
 - [x] syntax highlighting file for Vim/Neovim.  
 - [x] TCP and UPD echo server utilities for testing connectivity.  

_v0.1-alpha3:_  
The next release with the following changes:  
New source code directory structure, bug fixes, 8 new commands in system
category (total: 102), GUI (FreeBSD, Linux and Windows), script syntax
highlighting file for MCEdit and Nano and windows size and position saving
and restoring.  

_v0.1-alpha2:_  
The 2nd release with the following changes:
Bug fixes, Modbus/ASCII and Modbus/RTU communication, handling of constants,
three predefined constants and 28 new commands (total: 94) and script syntax
highlighting file for Micro.  

_v0.1-alpha1:_  
This test release is not yet suitable for work, although it is functional, but
it can only communicate via Modbus/ASCII. The purpose of this release is to test
the program's construction, operation, packaging, and package installation in
all supported environments. In addition, the documentation and other files are
checked for possible typos and errors.  

**Planned features**  

...that either will or won't.  

in _v0.1-beta2:_  
 - [ ] compressed HTML (CHM) help in addition to the existing online Wiki (only XModShell);  
 - [ ] Modbus/TCP communication (DOS version).  

in _v0.1-beta3:_  
 - [ ] graphical monitoring the change of values over time (only XModShell);  
 - [ ] implementation of additional Modbus functions.  

#### 1. Screenshots

**ModShell**

Normal command line
![CLI](document/picture/modshell.png)

Fullscreen command line
![TUI](document/picture/modshell-f.png)

Run example script on bash with ModShell interpreter
![script running](document/picture/modshell-r.png)

**XModShell**

Dump input registers  
![dump input registers](document/picture/xmodshell-dump.png)

Mini serial console  
![mini serial console](document/picture/xmodshell-sercons.png)

Script editor  
![script editor](document/picture/xmodshell-edit.png)

Variable monitor  
![variable monitor](document/picture/xmodshell-varmon.png)

#### 2. Used external libraries

 - _Convert - Bin/Oct/Dec/Hex number converter_  
   Unit for Turbo Pascal v3.0  
   Public Domain, Copyright (C) 1993 Tom Wellige  
 - _Ararat Synapse Release 40_ [^1]  
   TCP/IP and serial library for FreePascal  
   Modified BSD style license, Copyright (C) 1999-2012 Lukas Gebauer  
 - _ProtCOM v0.1 Protected mode serial port handler for DOS_ [^2]  
   Unit for FreePascal  
   Creative Common Zero Universal v1.0, Copyright (C) 2024 Pozsar Zsolt  

#### 3. About

This is a utility that can be used on several operating systems, which can
communicate with connected equipment using Modbus/ASCII,
Modbus/RTU and Modbus/TCP protocols [^3]. The basic communication protocol
of the program is Modbus, but DCON  and HART was also implemented due to
communication with other devices. The range of foreign protocols may be expanded
later. The program can - even automatically - read, write or copy data from one
device to another (e.g. transferring settings). When copying, the source and
destination register areas can be different.

The ModShell program has a *traditional (CLI)* or *full-screen (TUI) command-line*
interface and is also *suitable for running pre-created scripts* independently
(as a command interpreter). The program provides help on the commands that can
be used, and offers possible values when the parameters are entered incorrectly.
The issued commands are placed in history, which can be browsed with the up/down
arrow keys.

The XModShell program has a *graphical interface (GUI)*, which helps to perform
several operations with dialog windows, but the original command line input
remained available for them (e.g. file selection, settings, etc.) [^4].

**Operating principle**

It must be defined the I/O devices, then the protocols and the connections.
There can be eight of each. The data traffic takes place between the preset
connections. In all cases, the data is sent to or read from the internal buffer.
The size of the buffer is suitable for storing 2*9999 logical and word values of
the same size.

One hundred and twenty-eight variables and sixteen array
(which can also be constants) can be created in the program, to which
we can assign a value of any type (eg.: string, boolean or integer register
value, real number, etc.). Variables and constants can be used to perform
logical and arithmetical operations, and can be used to pass values to commands.


**Projects**

In the program, you can create projects for easier management of settings and
data. The name of the current project is shown in the prompt. The project
directory will be created in the program directory on DOS, and in the ModShell
directory in the user's home directory on all other systems. If only filename
is specified during file operations (without path), this directory will be the
source/destination directory.

**File operations**

The command line history can be exported to a text file and provides it with
the appropriate 'shebang' for the installation method and operating system. You
can easily create a script from this raw file.

Device, protocol and connection settings can be saved and loaded in their own
format. During saving, three typed files are created, with the following
extensions: DDT, PDT, CDT.

All register values can be saved and loaded in their own format. During saving,
two typed files are created, with the following extensions: BDT, IDT.

One or more same type registers can be exported to file. During saving, one text
file is created, with CSV, INI or XML extension. The program can only import
from INI and XML format files.

We can also create time-stamped log entries with the program and or script.

On exit, the command line history, input and echo mode and colors are preserved.

The program also has basic file and directory management commands.

**Script operations**

The script on the disc can be loaded into the already running program and
started manually.

The loaded script can be edited with a line editor, saved to disk or
deleted from the buffer. The graphical version has a simple editor window
with syntax highlighting instead of the line editor.

Variables and constants defined before running the script will be deleted.
It is also possible to observe the values of up to four variables during
runtime and to keep the final values​of constants and variables created
during runtime.

**Raw serial connection**

The program provides the possibility to send and receive raw data via a
serial port, and also includes a very simple serial console. The display of sent
and received data can be turned off or raw text and hexadecimal viewing can be
selected.

**Serial connection with DCON protocol**

The program also provides the possibility to send and receive data with DCON
protocol via a serial port.

**Serial connection with HART protocol**

The program also provides the possibility to send and receive data with HART
protocol via a serial port. A serial/HART gateway may be required for connection.

**Raw TCP and UDP connection**

The program provides the possibility to send and receive raw data via network
device with TCP or UDP, and also includes a very simple TCP and UDP console.
The display of sent and received data can be turned off or raw text and
hexadecimal viewing can be selected.

**Already implemented commands:**

|   |command     |category     |hotkey  |description                                                          |
|--:|:----------:|:-----------:|:------:|---------------------------------------------------------------------|
|  1|`add`       |arithmetic   |        |addition                                                             |
|  2|`avg`       |arithmetic   |        |average calculation                                                  |
|  3|`conv`      |arithmetic   |ALT-C   |convert numbers between BIN, DEC, HEX and OCT format                 |
|  4|`cos`       |arithmetic   |        |cosine function                                                      |
|  5|`cotan`     |arithmetic   |        |cotangent function                                                   |
|  6|`dec`       |arithmetic   |        |decrement integer                                                    |
|  7|`div`       |arithmetic   |        |division                                                             |
|  8|`exp`       |arithmetic   |        |natural exponential                                                  |
|  9|`idiv`      |arithmetic   |        |integer division                                                     |
| 10|`imod`      |arithmetic   |        |modulus division                                                     |
| 11|`inc`       |arithmetic   |        |increment integer                                                    |
| 12|`inrange`   |arithmetic   |        |check the value is in the range                                      |
| 13|`ln`        |arithmetic   |        |natural logarithm                                                    |
| 14|`mul`       |arithmetic   |        |multiplication                                                       |
| 15|`mulinv`    |arithmetic   |        |multiplicative inverse                                               |
| 16|`odd`       |arithmetic   |        |odd or event                                                         |
| 17|`pow2`      |arithmetic   |        |exponentiation of two                                                |
| 18|`pow`       |arithmetic   |        |exponentiation                                                       |
| 19|`prop`      |arithmetic   |        |propotional value calculation (with zero and span)                   |
| 20|`rnd`       |arithmetic   |        |create random integer                                                |
| 21|`round`     |arithmetic   |        |round real number                                                    |
| 22|`sin`       |arithmetic   |        |sine function                                                        |
| 23|`sqr`       |arithmetic   |        |square                                                               |
| 24|`sqrt`      |arithmetic   |        |square root                                                          |
| 25|`sub`       |arithmetic   |        |substraction                                                         |
| 26|`tan`       |arithmetic   |        |tangent function                                                     |
| 27|`copyreg`   |communication|        |copy one or more remote registers between two connections            |
| 28|`dcon`      |communication|        |read or write data from/to remote device with DCON protocol          |
| 29|`hart`      |communication|        |read or write data from/to remote device with HART protocol          |
| 30|`mbgw`      |communication|        |start internal Modbus gateway                                        |
| 31|`mbsrv`     |communication|        |start internal Modbus slave/server                                   |
| 32|`readreg`   |communication|ALT-R   |read one or more remote registers                                    |
| 33|`sercons`   |communication|F7      |mini serial console                                                  |
| 34|`serread`   |communication|        |read string from a serial device                                     |
| 35|`serwrite`  |communication|        |write string to a serial device                                      |
| 36|`tcpcons`   |communication|SHIFT-F7|mini TCP console                                                     |
| 37|`tcpread`   |communication|        |read string over the network using TCP                               |
| 38|`tcpwrite`  |communication|        |write string over the network using TCP                              |
| 39|`udpcons`   |communication|        |mini UDP console                                                     |
| 40|`udpread`   |communication|        |read string over the network using UDP                               |
| 41|`udpwrite`  |communication|        |write string over the network using UDP                              |
| 42|`writereg`  |communication|ALT-W   |write data to one or more remote registers                           |
| 43|`get`       |configuration|ALT-G   |get device, protocol, connection, colors, project name and timeout   |
| 44|`reset`     |configuration|ALT-T   |reset device, protocol or connection or reset project name           |
| 45|`set`       |configuration|ALT-S   |set device, protocol, connection, colors, project name and timeout   |
| 46|`applog`    |file         |        |append a record to log file (LOG)                                    |
| 47|`exphis`    |file         |        |export command line history to file (TXT)                            |
| 48|`expreg`    |file         |ALT-E   |export one or more registers to file (CSV, INI, XML)                 |
| 49|`impreg`    |file         |ALT-I   |import one or more registers from file (INI, XML)                    |
| 50|`loadcfg`   |file         |F3      |load settings of device, protocol and connection (?DT)               |
| 51|`loadreg`   |file         |F5      |load all buffer registers from typed file (?DT)                      |
| 52|`savecfg`   |file         |F2      |save settings of device, protocol and connection (?DT)               |
| 53|`savereg`   |file         |F4      |save all registers to typed file (?DT)                               |
| 54|`arrclear`  |general      |        |clear content of an array                                            |
| 55|`arrfill`   |general      |        |fill an array with a character                                       |
| 56|`ascii`     |general      |        |show ASCII table                                                     |
| 57|`beep`      |general      |        |make a beep with internal speaker                                    |
| 58|`carr`      |general      |        |show all constants array with theirs size or define a new one        |
| 59|`cls`       |general      |F8      |clear screen                                                         |
| 60|`const`     |general      |        |show all constant with theirs value or define a new one              |
| 61|`cron`      |general      |        |loaded script scheduled execution                                    |
| 62|`date`      |general      |        |show system date and time                                            |
| 63|`echo`      |general      |F9      |ascii/hexadecimal/disable local echo for connections                 |
| 64|`exit`      |general      |F10     |exit                                                                 |
| 65|`for`       |general      |        |loop iteration                                                       |
| 66|`getarrsize`|general      |        |get size of an array                                                 |
| 67|`goto`      |general      |        |jump to specified label                                              |
| 68|`help`      |general      |F1      |show description or usage of the commands                            |
| 69|`if`        |general      |        |selection statement                                                  |
| 70|`input`     |general      |SHIFT-F9|ascii/hexadecimal data input for connections                         |
| 71|`label`     |general      |        |define label (for goto command)                                      |
| 72|`let`       |general      |ALT-L   |set value of a register, variable, a constant or an element of array |
| 73|`pause`     |general      |        |waits for a keystroke or specified time                              |
| 74|`printcolor`|general      |        |set temporary foreground and background colors for print in CLI/TUI  |
| 75|`print`     |general      |ALT-P   |print message, value of the variable and register                    |
| 76|`setarrsize`|general      |        |set size of an array                                                 |
| 77|`var`       |general      |        |show all variable with theirs value or define a new one              |
| 78|`varmon`    |general      |ALT-M   |monitoring the value of variables                                    |
| 79|`varr`      |general      |        |show all variable array with theirs size or define a new one         |
| 80|`ver`       |general      |        |show version and build information of this program                   |
| 81|`and`       |logic        |        |AND logical operations                                               |
| 82|`bit`       |logic        |        |value of the specified bit                                           |
| 83|`not`       |logic        |        |NOT logical operations                                               |
| 84|`or`        |logic        |        |OR logical operations                                                |
| 85|`roll`      |logic        |        |roll bit of integer to left                                          |
| 86|`rolr`      |logic        |        |roll bit of integer to right                                         |
| 87|`shl`       |logic        |        |bit shift to left                                                    |
| 88|`shr`       |logic        |        |bit shift to right                                                   |
| 89|`xor`       |logic        |        |XOR logical operations                                               |
| 90|`dump`      |register     |F6      |dump all registers in binary/hexadecimal format to a table           |
| 91|`edit`      |script       |SHIFT-F4|edit loaded script with line editor                                  |
| 92|`erasescr`  |script       |SHIFT-F8|erase script from buffer                                             |
| 93|`list`      |script       |F11     |list loaded script                                                   |
| 94|`loadscr`   |script       |SHIFT-F3|load ModShell scriptfile from disc                                   |
| 95|`run`       |script       |F12     |run loaded script                                                    |
| 96|`savescr`   |script       |SHIFT-F2|save loaded script to disc                                           |
| 97|`chr`       |string       |        |convert byte to char                                                 |
| 98|`concat`    |string       |        |concatenate strings                                                  |
| 99|`length`    |string       |        |length of string                                                     |
|100|`lowcase`   |string       |        |conversion to lowercase                                              |
|101|`mkcrc`     |string       |        |make CRC value                                                       |
|102|`mklrc`     |string       |        |make LRC value                                                       |
|103|`ord`       |string       |        |convert char to byte                                                 |
|104|`strdel`    |string       |        |delete specified element(s) of the string                            |
|105|`strfind`   |string       |        |find specified element in the string                                 |
|106|`strins`    |string       |        |insert element into string                                           |
|107|`stritem`   |string       |        |specified element of the string                                      |
|108|`strrepl`   |string       |        |replace element in the string                                        |
|109|`upcase`    |string       |        |conversion to uppercase                                              | 
|110|`cd`        |system       |        |change actual directory                                              |
|111|`chkdevlock`|system       |        |check device lock file                                               |
|112|`copy`      |system       |        |copy file                                                            |
|113|`del`       |system       |        |remove file                                                          |
|114|`dir`       |system       |        |list directory content                                               |
|115|`exist`     |system       |        |existence of a file or directory                                     |
|116|`md`        |system       |        |make directory                                                       |
|117|`rd`        |system       |        |remove directory                                                     |
|118|`ren`       |system       |        |rename file                                                          |
|119|`rmdevlock` |system       |        |remove device lock file                                              |
|120|`type`      |system       |        |type file                                                            |

(Commands with function keys (F?) are executed immediately, modifier keys
(ALT-?) only make typing easier.)  

**Predefined constants**

|name    |value                              |
|--------|-----------------------------------|
|$?      |exit value of the commands         |
|$B01    |150 (baud)                         |
|$B03    |300 (baud)                         |
|$B06    |600 (baud)                         |
|$B1     |1200 (baud)                        |
|$B2     |2400 (baud)                        |
|$B4     |4800 (baud)                        |
|$B9     |9600 (baud)                        |
|$B19    |19200 (baud)                       |
|$B38    |38400 (baud)                       |
|$B57    |57600 (baud)                       |
|$B115   |115200 (baud)                      |
|$EULER  |value of e (2.7182818284590452354) |
|$HOME   |user's home directory              |
|$PI     |value of Pi (3.1415926535897932385)|
|$PRJDIR |directory of the actual project    |
|$PRJNAME|name of the actual project         |

**Documentation and Help**

Modshell and XModShell has a minimal built-in help which you can access by
typing help. Additionally, you can view the manual page from *nix shell
(_man modshell_) or _modshell.txt_ on other systems.  

In the graphical version, the Online Wiki can be opened directly from the 'Help'
menu.  

**Contributing**

If you find any bugs, please report them! I am also happy to accept pull
requests from anyone. You can use the GitHub issue tracker to report bugs, ask
questions, or suggest new features.  

**Links**

 - [Homepage](http://www.pozsarzs.hu)  
 - [GitHub repository](https://github.com/pozsarzs/modshell)  
 - [Project webpage on Github](https://pozsarzs.github.io/modshell)  
 - [Online manual on Github](https://github.com/pozsarzs/modshell/wiki)  

**Precompiled binaries and installer packages for several OS and architecture**

> [!TIP]
> The download is done via HTTP. Some browsers are not happy with this and may block it.

|name                                                                                                            |version    |OS              |arch. |type  |note       |
|----------------------------------------------------------------------------------------------------------------|:---------:|:--------------:|:----:|:----:|-----------|
|[source package](https://github.com/pozsarzs/modshell/archive/refs/heads/main.zip)                              |latest     |                |      |zip   |from Github|
|[source package](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha3.tar.gz)                   |v0.1-alpha3|                |      |tar.gz|           |
|[source package](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha2.tar.gz)                   |v0.1-alpha2|                |      |tar.gz|           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/dos/mdsh01a2.exe)                            |v0.1-alpha2|DOS             |i386  |exe   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/dos/mdsh01a2.zip)                            |v0.1-alpha2|DOS             |i386  |zip   |           |
|[binary package with source code](http://www.pozsarzs.hu/packages/software/modshell/freedos/mdsh01a2.zip)       |v0.1-alpha2|FreeDOS         |i386  |zip   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-i386.bin)     |v0.1-alpha2|Linux           |i386  |bin   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-amd64.bin)    |v0.1-alpha2|Linux           |amd64 |bin   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-armhf.bin)    |v0.1-alpha2|Linux           |armhf |bin   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-i386.zip)     |v0.1-alpha2|Linux           |i386  |zip   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-amd64.zip)    |v0.1-alpha2|Linux           |amd64 |zip   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-linux-armhf.zip)    |v0.1-alpha2|Linux           |armhf |zip   |           |
|[installer package](http://www.pozsarzs.hu/deb/i386/modshell_0.1alpha2-1_i386.deb)                              |v0.1-alpha2|Debian GNU/Linux|i386  |deb   |           |
|[installer package](http://www.pozsarzs.hu/deb/amd64/modshell_0.1alpha2-1_amd64.deb)                            |v0.1-alpha2|Debian GNU/Linux|amd64 |deb   |           |
|[installer package](http://www.pozsarzs.hu/deb/armhf/modshell_0.1alpha2-1_armhf.deb)                            |v0.1-alpha2|Raspberry Pi OS |armhf |deb   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-1.i386.rpm)      |v0.1-alpha2|OpenSuSE        |i386  |rpm   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-1.x86_64.rpm)    |v0.1-alpha2|OpenSuSE        |amd64 |rpm   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-i386-1.txz)      |v0.1-alpha2|Slackware       |i386  |txz   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/linux/modshell-0.1alpha2-amd64-1.txz)     |v0.1-alpha2|Slackware       |amd64 |txz   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/modshell-0.1alpha2-freebsd-i386.bin) |v0.1-alpha2|FreeBSD         |i386  |bin   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/modshell-0.1alpha2-freebsd-amd64.bin)|v0.1-alpha2|FreeBSD         |amd64 |bin   |SFX        |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/modshell-0.1alpha2-freebsd-i386.zip) |v0.1-alpha2|FreeBSD         |i386  |zip   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/modshell-0.1alpha2-freebsd-amd64.zip)|v0.1-alpha2|FreeBSD         |amd64 |zip   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/i386/modshell-0.1alpha2.pkg)      |v0.1-alpha2|FreeBSD         |i386  |pkg   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/freebsd/amd64/modshell-0.1alpha2.pkg)     |v0.1-alpha2|FreeBSD         |amd64 |pkg   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/windows/modshell-0.1alpha2-win32.zip)        |v0.1-alpha2|Windows         |i386  |zip   |           |
|[binary package](http://www.pozsarzs.hu/packages/software/modshell/windows/modshell-0.1alpha2-win64.zip)        |v0.1-alpha2|Windows         |x86_64|zip   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/windows/modshell-0.1alpha2-win32.exe)     |v0.1-alpha2|Windows         |i386  |exe   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/windows/modshell-0.1alpha2-win64.exe)     |v0.1-alpha2|Windows         |x86_64|exe   |           |
|[installer package](http://www.pozsarzs.hu/packages/software/modshell/windows/modshell-0.1alpha2-win32.msi)     |v0.1-alpha2|Windows         |i386  |msi   |           |
|[installer package](http://www.pozsarzs.hu.hu/packages/software/modshell/windows/modshell-0.1alpha2-win64.msi)  |v0.1-alpha2|Windows         |x86_64|msi   |           |
|[source package](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha1.tar.gz)                   |v0.1-alpha1|                |      |tar.gz|           |

[^1]: [Synapse Github repository](https://github.com/geby/synapse)
[^2]: [ProtCOM Github repository](https://github.com/pozsarzs/protcom)
[^3]: [Modbus](https://modbus.org)
[^4]: [Wiki - Differents between CUI and GUI version](https://github.com/pozsarzs/modshell/wiki/c.-Differents-between-CUI-and-GUI-version)
