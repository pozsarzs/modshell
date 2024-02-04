> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
> 
> The next release will be **0.1-alpha2** with the following changes:
> - Bug fixes,
> - Modbus/ASCII and Modbus/RTU communication,
> - handling of constants,
> - two predefined constants and
> - 25 new command (total: 91).
> - Script syntax highlighting file for Micro.
>
> **v0.1-alpha1:**  
> This test release is not yet suitable for work, although it is functional, but
> it can only communicate via Modbus/ASCII.
> 
> The purpose of this release is to test the program's construction, operation,
> packaging, and package installation in all supported environments. In
> addition, the documentation and other files are checked for possible typos and
> errors.

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="ModShell icon" src="desktop/modshell.png">   

## Modshell

**Command-driven scriptable Modbus utility**

Copyright (C) 2023 Pozsár Zsolt <pozsarzs@gmail.com>  
Homepage: <http://www.pozsarzs.hu>  
GitHub: <https://github.com/pozsarzs/modshell>  
Online manual: <https://github.com/pozsarzs/modshell/wiki>  

|features                |                                                                  |
|------------------------|------------------------------------------------------------------|
|architecture            |amd64, armhf, i386, x86_64                                        |
|operation system        |DOS, FreeBSD, Linux, Windows                                      |
|version                 |v0.1                                                              |
|language                |en, hu                                                            |
|licence                 |EUPL v1.2                                                         |
|local user interface    |CLI and TUI                                                       |
|running modes           |command line, full-screen or interpreter                          |
|local Modbus registers  |2x10000 boolean and 2x10000 word type                             |
|variables               |max. 128 variables or constants (stored as string)                |
|built-in commands       |91 commands in 9 categories                                       |
|load from file          |registers, script, settings                                       |
|save to file            |command history, console trafic, registers, communication settings, user log with timestamp|
|auto save to file       |general settings and console traffic                              |
|export to file          |history (TXT), registers (CSV, INI, XML)                          |
|import to file          |registers (INI, XML)                                              |
|configurable devices    |max. 8 settings, serial and ethernet port                         |
|configurable protocols  |max. 8 settings, ASCII, RTU or TCP                                |
|configurable connections|max. 8 settings by combining the previous two                     |
|raw serial communication|read/write serial port and mini serial console with char/hex echo |
|Modbus communication    |read and write remote device and copy between devices             |
|                        |internal server for remote access to own registers                |
|                        |gateway to access devices using other ports or protocols          |
|script size             |max. 256 line                                                     |
|example scripts         |7 scripts (shellscript and batch file versions)                   | 
|script syntax plugins   |for Micro editor                                                  |

#### 1. Screenshots

Normal command line
![CLI](document/picture/modshell.png)
Fullscreen command line

![TUI](document/picture/modshell-f.png)

Run example script on bash with ModShell interpreter
![script running](document/picture/modshell-r.png)

#### 2. Used external libraries

 - _Convert - Bin/Oct/Dec/Hex number converter_  
   Unit for Turbo Pascal v3.0  
   Public Domain, Copyright (C) 1993 Tom Wellige  
 - _Ararat Synapse Release 40_  
   TCP/IP and serial library for FreePascal  
   Modified BSD style license, Copyright (C) 1999-2012 Lukas Gebauer  
 - _ProtCOM v0.1 Protected mode serial port handler for DOS_  
   Unit for FreePascal  
   Creative Common Zero Universal v1.0, Copyright (C) 2024 Pozsar Zsolt  

#### 3. About

This is a utility that can be used on several operating systems, which can
communicate with connected equipment using [Modbus](https://modbus.org/)/ASCII,
Modbus/RTU and Modbus/TCP protocols. The program can - even automatically -
read, write or copy data from one device to another (e.g. transferring
settings). When copying, the source and destination register areas can be
different.

The program has a *traditional (CLI)* or *full-screen (TUI) command-line*
interface and is also *suitable for running pre-created scripts* independently
(as a command interpreter). The program provides help on the commands that can
be used, and offers possible values when the parameters are entered incorrectly.
The issued commands are placed in history, which can be browsed with the up/down
arrow keys.

**Operating principle**

It must be defined the I/O devices, then the protocols and the connections.
There can be eight of each. The data traffic takes place between the preset
connections. In all cases, the data is sent to or read from the internal buffer.
The size of the buffer is suitable for storing 2*9999 logical and word values of
the same size. One hundred and twenty-eight variables or constant can be created
in the program, to which we can assign a value of any type (eg.: string, boolean
or integer register value, real number, etc.) Variables can be used to perform
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

The script on the disc can be loaded into the already running program and
started manually.

Device, protocol and connection settings can be saved and loaded in their own
format. During saving, three typed files are created, with the following
extensions: DDT, PDT, CDT.

All register values can be saved and loaded in their own format. During saving,
two typed files are created, with the following extensions: BDT, IDT.

One or more same type registers can be exported to file. During saving, one text
file is created, with CSV, INI or XML extension. The program can only import
from INI and XML format files.

We can also create time-stamped log entries with the program.

On exit, the command line history, echo mode and colors are preserved.

**Serial connection**

The program also provides the possibility to send and receive raw data via a
serial port, and also includes a very simple serial console. The display of sent
and received data can be turned off or raw text and hexadecimal viewing can be
selected.

**Already implemented commands:**

|command |category      |hotkey|description                                                      |
|--------|--------------|------|-----------------------------------------------------------------|
|add     |arithmetic    |      |addition                                                         |
|avg     |arithmetic    |      |average calculation                                              |
|conv    |arithmetic    |ALT-C |convert numbers between BIN, DEC, HEX and OCT format             |
|cos     |arithmetic    |      |cosine function                                                  |
|cotan   |arithmetic    |      |cotangent function                                               |
|dec     |arithmetic    |      |decrement integer                                                |
|div     |arithmetic    |      |division                                                         |
|exp     |arithmetic    |      |natural exponential                                              |
|idiv    |arithmetic    |      |integer division                                                 |
|imod    |arithmetic    |      |modulus division                                                 |
|inc     |arithmetic    |      |increment integer                                                |
|inrange |arithmetic    |      |check the value is in the range                                  |
|ln      |arithmetic    |      |natural logarithm                                                |
|mul     |arithmetic    |      |multiplication                                                   |
|mulinv  |arithmetic    |      |multiplicative inverse                                           |
|odd     |arithmetic    |      |odd or event                                                     |
|pow     |arithmetic    |      |exponentiation                                                   |
|pow2    |arithmetic    |      |exponentiation of two                                            |
|prop    |arithmetic    |      |propotional value calculation (with zero and span)               |
|rnd     |arithmetic    |      |create random integer                                            |
|round   |arithmetic    |      |round real number                                                |
|sin     |arithmetic    |      |sine function                                                    |
|sqr     |arithmetic    |      |square root                                                      |
|sqrt    |arithmetic    |      |square root                                                      |
|sub     |arithmetic    |      |substraction                                                     |
|tan     |arithmetic    |      |tangent function                                                 |
|copy    |communication |      |copy one or more remote registers between two connections        |
|mbgw    |communication |      |start internal Modbus gateway                                    |
|mbsrv   |communication |      |start internal Modbus slave/server                               |
|read    |communication |ALT-R |read one or more remote registers                                |
|sercons |communication |F7    |serial console                                                   |
|serread |communication |      |read a string from serial device                                 |
|serwrite|communication |      |write a string from serial device                                |
|write   |communication |ALT-W |write data to one or more remote registers                       |
|get     |configuration |ALT-G |get setting of a device, protocol, connection or get project name|
|reset   |configuration |ALT-T |reset device, protocol or connection or reset project name       |
|set     |configuration |ALT-S |set device, protocol or connection or set project name           |
|applog  |file          |      |append a record to log file (LOG)                                |
|exphis  |file          |      |export command line history to file (TXT)                        |
|expreg  |file          |ALT-E |export one or more registers to file (CSV, INI, XML)             |
|impreg  |file          |ALT-I |import one or more registers from file (INI, XML)                |
|loadcfg |file          |F3    |load settings of device, protocol and connection (?DT)           |
|loadreg |file          |F5    |load all buffer registers from typed file (?DT)                  |
|savecfg |file          |F2    |save settings of device, protocol and connection (?DT)           |
|savereg |file          |F4    |save all registers to typed file (?DT)                           |
|ascii   |general       |      |show ASCII table                                                 |
|beep    |general       |      |make a beep with internal speaker                                |
|cls     |general       |F8    |clear screen                                                     |
|color   |general       |      |set colors                                                       |
|const   |general       |      |show all constant with theirs value or define a new one          |
|cron    |general       |      |loaded script scheduled execution                                |
|date    |general       |      |show system date and time                                        |
|echo    |general       |F9    |enable/hexadecimal/disable local echo for serial connections     |
|exit    |general       |F10   |exit                                                             |
|goto    |general       |      |jump to specified label                                          |
|for     |general       |      |loop iteration                                                   |
|help    |general       |F1    |show description or usage of the commands                        |
|if      |general       |      |selection statement                                              |
|label   |general       |      |define label (for goto command)                                  |
|pause   |general       |      |waits for a keystroke or specified time                          |
|print   |general       |ALT-P |print message, value of the variable and register                |
|var     |general       |      |show all variable with theirs value or define a new one          |
|varmon  |general       |ALT-M |monitoring the value of variables                                |
|ver     |general       |      |show version and build information of this program               |
|and     |logic         |      |AND logical operations                                           |
|bit     |logic         |      |value of the specified bit                                       |
|not     |logic         |      |NOT logical operations                                           |
|or      |logic         |      |OR logical operations                                            |
|roll    |logic         |      |roll bit of integer to left                                      |
|rolr    |logic         |      |roll bit of integer to right                                     |
|shl     |logic         |      |bit shift to left                                                |
|shr     |logic         |      |bit shift to right                                               |
|xor     |logic         |      |XOR logical operations                                           |
|dump    |register      |F6    |dump all registers in binary/hexadecimal format to a table       |
|let     |register      |ALT-L |set value of a variable or register                              |
|list    |script        |F11   |list loaded script                                               |
|loadscr |script        |      |load scriptfile                                                  |
|run     |script        |F12   |run loaded script                                                |
|chr     |string        |      |convert byte to char                                             |
|concat  |string        |      |concatenate strings                                              |
|length  |string        |      |length of string                                                 |
|lowcase |string        |      |conversion to lowercase                                          |
|mkcrc   |string        |      |make CRC value                                                   |
|mklrc   |string        |      |make LRC value                                                   |
|ord     |string        |      |convert char to byte                                             |
|strdel  |string        |      |delete specified element(s) of the string                        |
|strfind |string        |      |find specified element in the string                             |
|strins  |string        |      |insert element into string                                       |
|stritem |string        |      |specified element of the string                                  |
|strrepl |string        |      |replace element in the string                                    |
|upcase  |string        |      |conversion to uppercase                                          |

(Commands with function keys (F?) are executed immediately, modifier keys
(ALT-?) only make typing easier.)

**Predefined constants**

|name  |value                              |
|------|-----------------------------------|
|$?    |exit value of the commands         |
|$PI   |value of Pi (3.1415926535897932385)|
|$EULER|value of e  (2.7182818284590452354)|

**Documentation and Help**

Modshell has a minimal built-in help which you can access by typing help.
Additionally, you can view the manual page from *nix shell (_man modshell_) or
_modshell.txt_ on other systems.

**Contributing**

If you find any bugs, please report them! I am also happy to accept pull
requests from anyone. You can use the GitHub issue tracker to report bugs, ask
questions, or suggest new features.

