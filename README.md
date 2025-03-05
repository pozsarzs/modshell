> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
>

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="ModShell icon" src="document/picture/modshell_96x96.png">   

# Modshell

<br>

**Command-driven scriptable Modbus utility**

Copyright (C) 2023-2025 Pozsár Zsolt <pozsarzs@gmail.com>  

## About this project

This project started in December 2023 as a Christmas project, to wind down the
busy end-of-year period.The original goal was to create a utility that would
allow multiple Modbus devices of the same type to be configured without using
a touchpad.  

The project has grown considerably in size over time, but many features have
been implemented that make it more useful. With the growth, the goal has also
been reformulated: the program must have multiple user interfaces, be usable on
many operating systems, handle multiple communication channels and protocols, be
suitable for many tasks, and even work automatically.  

The next goal is to create a field (installed) or handheld (mobile) data
collector, converter, processor, etc., as well as a data and traffic monitoring
device that works reliably, using this program, a single-board computer, and a
mini HMI.  

The choice of source language fell on the outdated and neglected FreePascal.
Partly because of its multiplatform nature ('Write once - compile everywhere'),
partly because it is what I feel most comfortable with. I'm not sure it was the
best choice, but you have to make the most of it.  

The benefit of the project is not the finished product, as there are 'thousands'
of similar products on the market. The biggest benefit is the development of
logical thinking and the knowledge we gain while programming, but the greatest
is the joy of creation. And this is not dependent on the programming language.  

## I. Features

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
|arrays                  |max. 32 dynamic size array of variables or constants (elements stored as string)            |
|built-in commands       |129 commands in 10 categories with macro and script options)                                |
|macros                  |max. 32                                                                                     |
|script size             |max. 1024 line                                                                              |
|example scripts         |10 scripts (shellscript and batch file versions)                                            |
|load from file          |registers, script, settings                                                                 |
|save to file            |command history, console and Modbus traffic, registers, communication settings, user log    |
|auto save to file       |general settings and console traffic                                                        |
|export to file          |history (TXT), registers (CSV, INI, XML)                                                    |
|import to file          |registers (INI, XML)                                                                        |
|configurable devices    |max. 8 settings, serial and ethernet port                                                   |
|configurable protocols  |max. 8 settings, ASCII, RTU or TCP                                                          |
|configurable connections|max. 8 settings by combining the previous two                                               |
|raw serial communication|read/write serial port and mini serial console with A/N or Hex echo                         |
|raw TCP communication   |read/write network device and mini TCP console with A/N or Hex echo                         |
|raw UDP communication   |read/write network device and mini TCP console with A/N or Hex echo                         |
|DCON communication      |read and write remote devices                                                               |
|HART communication      |read and write remote devices                                                               |
|Modbus communication    |read and write remote device and copy between devices                                       |
|                        |internal server for remote access to own registers                                          |
|                        |gateway to access devices using other ports or protocols                                    |
|                        |internal serial monitor for decode ASCII or RTU telegrams                                   |
|direct I/O port access  |supported, on Windows with external freeware DLL                                            |
|local Modbus registers  |2x9999 boolean and 2x9999 word type                                                         |
|script syntax plugins   |for editors using GtkSourceView, MCEdit, Micro, Nano, Notepad++, (Neo)Vim and VSCode        |
|utility scripts         |2 script                                                                                    |
|other utility programs  |command line serial Modbus traffic monitor, serial, TCP and UDP echo servers                |

## II. Releases

### Planned next releases up to v0.1

...that either will or won't.  

<details>
 <summary><i>v0.1</i></summary>
 This is <i>first unstable release</i>.<br>
 Unstable, but it is already complete in its intended functionality.
 The software will not include any new features compared to the previous
 release, only bug fixes. All types of binary and installation packages
 will be released along with the source package.  
</details>

<details>
 <summary><i>v0.1-beta3</i></summary>
 <i>Third user test release</i> will be with the following changes:
 <ul>
   <li>graphical monitoring the change of values over time (only XModShell);</li>
   <li>implementation of additional Modbus functions.</li>
 </ul>
 Only a source package will be released.  
</details>

### Actual release  

_0.1-beta2_
_Second user test release_ will be with the following changes:
 - [ ] new command `abs`;  
 - [ ] new command `gpio` (Industrial PC and RaspberryPi GPIO port support);  
 - [x] new command `input`;  
 - [ ] new command `stack`;  
 - [ ] new command `swp`;  
 - [x] compressed HTML (CHM) help in addition to the existing online Wiki (only XModShell);  
 - [ ] HART protocol support;  
 - [ ] Modbus/TCP communication;  
 - [ ] TCP/UDP communication on DOS;  
 - [x] syntax highlighter and suggestion extension for Visual Studio Code.  
 Only a source package will be released.

### Previous releases  

<details>
 <summary><i>v0.1-beta1</i></summary>  
 <i>First user test release</i> with the following changes:  
 <ul>
  <li>Elimination of confusion between the terms 'register number' and 'data address'</li>  
  <li>in interpreter mode, passing parameters from the OS command line to the script and returning the script's exit value to the OS</li>  
  <li>in interpreter mode, command verbosity level setting with a predefined variable</li>  
  <li>ANSI escape sequences support (only DOS and *nix like systems)</li>  
  <li>command `color` -> `set color`, sets all default colors (CLI and TUI)</li>    
  <li>command `echo` -> `echometh`, parameters: off/on/hex/swap -> off/an/hex/swap</li>  
  <li>commands `sercons`, `tcpcons`, `udpcons`: character-to-character or string sending, with alphanumerical or hexadecimal input, with or without alphanumerical or hexhexadecimal echo</li>    
  <li>commands `serwrite`, `tcpwrite`, `udpwrite`: alphanumerical or hexadecimal input, with or without alphanumerical or hexadecimal echo</li>  
  <li>DCON protocol support</li>    
  <li>keywords (coil, hreg, asc, hex, etc.) should also be specified from variables</li>  
  <li>main menu for all consoles in GUI version</li>    
  <li>Modbus register number/address converter utility (in your own scripting language)</li>  
  <li>Number converter utility (in your own scripting language)</li>  
  <li>modified source code structure of XModshell</li>    
  <li>new command `chkdevlock`/`rmdevlock` (only *nix systems)</li>    
  <li>new command `datatype`</li>    
  <li>new command `exist`</li>    
  <li>new command `inputmeth`</li>    
  <li>new command `macro`</li>  
  <li>new command `mbconv`</li>    
  <li>new command `mbmon`</li>    
  <li>new command `printcolor`(only CLI and TUI)</li>    
  <li>new command `runmeth`</li>    
  <li>new command `sendmeth`</li>    
  <li>new command `tcpcons`, `tcpread`, `tcpwrite`</li>    
  <li>new command `udpcons`, `udpread`, `udpwrite`</li>    
  <li>new commands `ioread` and `iowrite`</li>  
  <li>new menu items in the main menu for quick execution of Modbus R/W commands</li>    
  <li>new menu items for show and edit all register's value in a big table</li>    
  <li>new serial baudrates: 150, 300, 600 baud</li>  
  <li>serial echo server utility for testing connectivity</li>    
  <li>serial ModBus traffic monitor utility</li>  
  <li>support for variable and constant arrays</li>    
  <li>new predefined constants</li>  
  <li>syntax highlighter file for applications using GTKSourceView (for example: Builder, Geany, Gedit, Mousepad, Pluma, Scribes), for Notepad++ (Windows only) and Vim/Neovim</li>  
egzotikusTCP and UPD echo server utilities for testing connectivity.</li>  
 </ul>  
 Only a source package will be released.
</details>
 
<details>
 <summary><i>v0.1-alpha3</i></summary>  
 <i>Third and last developer test release</i> with the following changes:
 <ul>
  <li>New source code directory structure;</li>
  <li>new commands;</li>
  <li>new predefined constants;</li>
  <li>bug fixes;</li>
  <li>GUI (except DOS);</li>
  <li>script syntax highlighting file for MCEdit and Nano.</li>
 </ul>
 Only a source package will be released.  
</details>

<details>
 <summary><i>v0.1-alpha2</i></summary>
 <i>Second developer test release</i> with the following changes:
 <ul>
  <li>Bug fixes;</li>
  <li>Modbus/ASCII and Modbus/RTU communication;</li>
  <li>handling of constants;</li>
  <li>three predefined constants and</li>
  <li>28 new command (total: 94);</li>
  <li>script syntax highlighting file for Micro.</li>
 </ul>
 All types of binary and installation packages will be released along with the source package.  
</details>

<details>
 <summary><i>v0.1-alpha1</i></summary>
 <i>First developer test release</i> is not yet suitable for work, although it is
 functional, but it can only communicate via Modbus/ASCII. The purpose of this
 release is to test the program's construction, operation, packaging, and package
 installation in all supported environments. In addition, the documentation and
 other files are checked for possible typos and errors. Only a source package
 will be released.  
</details>

## III. Screenshots

### ModShell  

Normal command line
![CLI](document/picture/modshell.png)

Fullscreen command line
![TUI](document/picture/modshell-f.png)

Run example script on bash with ModShell interpreter
![script running](document/picture/modshell-r.png)

### XModShell  

Dump input registers  
![dump input registers](document/picture/xmodshell-dump.png)

Input registers in Register table  
![register table](document/picture/xmodshell-regtable.png)

Mini serial console  
![mini serial console](document/picture/xmodshell-sercons.png)

Script editor  
![script editor](document/picture/xmodshell-edit.png)

Variable monitor  
![variable monitor](document/picture/xmodshell-varmon.png)

## IV. Used external libraries and programs

 - _Ararat Synapse Release 40_ [^1]  
   TCP/IP and serial library for FreePascal  
   Modified BSD style license, Copyright (C) 1999-2012 Lukas Gebauer  
 - _Convert - Bin/Oct/Dec/Hex number converter_  
   Unit for Turbo Pascal v3.0  
   Public Domain, Copyright (C) 1993 Tom Wellige  
 - _InpOut32 v1.0.07 Driver Interface DLL_ [^2]  
   Windows Dynamic Link Library (DLL)  
   Open source/freeware  
   Copyright (C) 2003-2015 Phil Gibbons  
   Copyright (C) 2000 <logix4u.net>  
 - _LHelp v2021-02-12 CHM help viewer_  
   Application  
   GNU GPL v2.0 or later, Copyright (C) 2005-2014 Andrew Haines, Lazarus contributors  
 - _ProtCOM v0.1 Protected mode serial port handler for DOS_ [^3]  
   Unit for FreePascal  
   Creative Common Zero Universal v1.0, Copyright (C) 2024 Pozsar Zsolt  

## V. About the program in a nutshell

This is a utility that can be used on several operating systems, which can
communicate with connected equipment using Modbus/ASCII,
Modbus/RTU and Modbus/TCP protocols [^4]. The basic communication protocol
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
remained available for them (e.g. file selection, settings, etc.) [^5].

### Operating principle  

It must be defined the I/O devices, then the protocols and the connections.
There can be eight of each. The data traffic takes place between the preset
connections. In all cases, the data is sent to or read from the internal buffer.
The size of the buffer is suitable for storing 2*9999 logical and word values of
the same size.

128 variables and 32 arrays (which can also be constants) can be created in
the program, to which we can assign a value of any type (eg.: string, boolean
or integer register value, real number, etc.). Variables and constants can be
used to perform logical and arithmetical operations, and can be used to pass
values to commands.

It is possible to create 32 single-line macros to replace frequently used longer
commands. The program includes 3 pre-created macros, the content of which can
also be changed.

### Projects  

In the program, you can create projects for easier management of settings and
data. The name of the current project is shown in the prompt. The project
directory will be created in the program directory on DOS, and in the ModShell
directory in the user's home directory on all other systems. If only filename
is specified during file operations (without path), this directory will be the
source/destination directory.

### File operations  

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

### Script operations  

The script on the disc can be loaded into the already running program and
started manually.

The loaded script can be edited with a line editor, saved to disk or
deleted from the buffer. The graphical version has a simple editor window
with syntax highlighting instead of the line editor.

Variables, constants and macros defined before running the script will be
deleted. It is also possible to observe the values of up to four variables
during runtime and to keep the final values​of constants and variables created
during runtime.

In interpreter mode, operating system command line arguments are available as
predefined constants.

### Raw serial connection  

The program provides the possibility to send and receive raw data via a
serial port, and also includes a very simple serial console. The display of sent
and received data can be turned off or raw text and hexadecimal viewing can be
selected.

### Serial connection with DCON protocol  

The program also provides the possibility to send and receive data with DCON
protocol via a serial port.

### Serial connection with HART protocol  

The program also provides the possibility to send and receive data with HART
protocol via a serial port. A serial/HART gateway may be required for connection.

### Raw TCP connection  

The program provides the possibility to send and receive raw data via network
device with TCP, and also includes a very simple TCP console. The display of
sent and received data can be turned off or raw text and hexadecimal viewing
can be selected.

### Raw UDP connection  

The program provides the possibility to send and receive raw data via network
device with UDP, and also includes a very simple UDP console. The display of
sent and received data can be turned off or raw text and hexadecimal viewing
can be selected.

### Direct I/O access  

The program provides direct, byte-sized reading and writing of hardware I/O
ports. On Windows operating systems, it uses the included external dynamically
linked library.  

## VI. Implemented commands  

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
| 30|`mbconv`    |communication|        |Modbus register number/address converter                             |
| 31|`mbgw`      |communication|        |start internal Modbus gateway                                        |
| 32|`mbsrv`     |communication|        |start internal Modbus slave/server                                   |
| 33|`mbmon`     |communication|        |start serial Modbus traffic monitor                                  |
| 34|`readreg`   |communication|ALT-R   |read one or more remote registers                                    |
| 35|`sercons`   |communication|F7      |mini serial console                                                  |
| 36|`serread`   |communication|        |read string from a serial device                                     |
| 37|`serwrite`  |communication|        |write string to a serial device                                      |
| 38|`tcpcons`   |communication|SHIFT-F7|mini TCP console                                                     |
| 39|`tcpread`   |communication|        |read string over the network using TCP                               |
| 40|`tcpwrite`  |communication|        |write string over the network using TCP                              |
| 41|`udpcons`   |communication|        |mini UDP console                                                     |
| 42|`udpread`   |communication|        |read string over the network using UDP                               |
| 43|`udpwrite`  |communication|        |write string over the network using UDP                              |
| 44|`writereg`  |communication|ALT-W   |write data to one or more remote registers                           |
| 45|`get`       |configuration|ALT-G   |get device, protocol, connection, colors, project name and timeout   |
| 46|`reset`     |configuration|ALT-T   |reset device, protocol or connection or reset project name           |
| 47|`set`       |configuration|ALT-S   |set device, protocol, connection, colors, project name and timeout   |
| 48|`applog`    |file         |        |append a record to log file (LOG)                                    |
| 49|`exphis`    |file         |        |export command line history to file (TXT)                            |
| 50|`expreg`    |file         |ALT-E   |export one or more registers to file (CSV, INI, XML)                 |
| 51|`impreg`    |file         |ALT-I   |import one or more registers from file (INI, XML)                    |
| 52|`loadcfg`   |file         |F3      |load settings of device, protocol and connection (?DT)               |
| 53|`loadreg`   |file         |F5      |load all buffer registers from typed file (?DT)                      |
| 54|`savecfg`   |file         |F2      |save settings of device, protocol and connection (?DT)               |
| 55|`savereg`   |file         |F4      |save all registers to typed file (?DT)                               |
| 56|`arrclear`  |general      |        |clear content of an array                                            |
| 57|`arrfill`   |general      |        |fill an array with a character                                       |
| 58|`ascii`     |general      |        |show ASCII table                                                     |
| 59|`beep`      |general      |        |make a beep with internal speaker                                    |
| 60|`carr`      |general      |        |show all constant arrays with theirs size or define a new one        |
| 61|`cls`       |general      |F8      |clear screen                                                         |
| 62|`const`     |general      |        |show all constants with theirs value or define a new one             |
| 63|`cron`      |general      |        |loaded script scheduled execution                                    |
| 64|`datatype`  |general      |        |detect type of data                                                  |
| 65|`date`      |general      |        |show system date and time                                            |
| 66|`echometh`  |general      |F9      |alphanumerical/hexadecimal/none local echo method for connections    |
| 67|`exit`      |general      |F10     |exit                                                                 |
| 68|`for`       |general      |        |loop iteration                                                       |
| 69|`getarrsize`|general      |        |get size of an array                                                 |
| 70|`goto`      |general      |        |jump to specified label                                              |
| 71|`help`      |general      |F1      |show description or usage of the commands                            |
| 72|`if`        |general      |        |selection statement                                                  |
| 73|`input`     |general      |        |input data from console                                              |
| 74|`inputmeth` |general      |SHIFT-F9|alphanumerical/hexadecimal data input method for connections         |
| 75|`label`     |general      |        |define label (for goto command)                                      |
| 76|`let`       |general      |ALT-L   |set value of a register, variable, a constant or an element of array |
| 77|`macro`     |general      |        |show all macros with theirs value or define a new one                |
| 78|`pause`     |general      |        |waits for a keystroke or specified time                              |
| 79|`printcolor`|general      |        |set temporary foreground and background colors for print in CLI/TUI  |
| 80|`print`     |general      |ALT-P   |print message, value of the variable and register                    |
| 81|`runmeth`   |general      |        |get execution method                                                 |
| 82|`sendmeth`  |general      |CTRL-F9 |char-to-char or string data send method for connections              |
| 83|`setarrsize`|general      |        |set size of an array                                                 |
| 84|`var`       |general      |        |show all variables with theirs value or define a new one             |
| 85|`varmon`    |general      |ALT-M   |monitoring the value of variables                                    |
| 86|`varr`      |general      |        |show all variable arrays with theirs size or define a new one        |
| 87|`ver`       |general      |        |show version and build information of this program                   |
| 88|`and`       |logic        |        |AND logical operations                                               |
| 89|`bit`       |logic        |        |value of the specified bit                                           |
| 90|`not`       |logic        |        |NOT logical operations                                               |
| 91|`or`        |logic        |        |OR logical operations                                                |
| 92|`roll`      |logic        |        |roll bit of integer to left                                          |
| 93|`rolr`      |logic        |        |roll bit of integer to right                                         |
| 94|`shl`       |logic        |        |bit shift to left                                                    |
| 95|`shr`       |logic        |        |bit shift to right                                                   |
| 96|`xor`       |logic        |        |XOR logical operations                                               |
| 97|`dump`      |register     |F6      |dump all registers in binary/hexadecimal format to a table           |
| 98|`edit`      |script       |SHIFT-F4|edit loaded script with line editor                                  |
| 99|`erasescr`  |script       |SHIFT-F8|erase script from buffer                                             |
|100|`list`      |script       |F11     |list loaded script                                                   |
|101|`loadscr`   |script       |SHIFT-F3|load ModShell scriptfile from disc                                   |
|102|`run`       |script       |F12     |run loaded script                                                    |
|103|`savescr`   |script       |SHIFT-F2|save loaded script to disc                                           |
|104|`chr`       |string       |        |convert byte to char                                                 |
|105|`concat`    |string       |        |concatenate strings                                                  |
|106|`length`    |string       |        |length of string                                                     |
|107|`lowcase`   |string       |        |conversion to lowercase                                              |
|108|`mkcrc`     |string       |        |make CRC value                                                       |
|109|`mklrc`     |string       |        |make LRC value                                                       |
|110|`ord`       |string       |        |convert char to byte                                                 |
|111|`strdel`    |string       |        |delete specified element(s) of the string                            |
|112|`strfind`   |string       |        |find specified element in the string                                 |
|113|`strins`    |string       |        |insert element into string                                           |
|114|`stritem`   |string       |        |specified element of the string                                      |
|115|`strrepl`   |string       |        |replace element in the string                                        |
|116|`upcase`    |string       |        |conversion to uppercase                                              | 
|117|`cd`        |system       |        |change actual directory                                              |
|118|`chkdevlock`|system       |        |check device lock file                                               |
|119|`copy`      |system       |        |copy file                                                            |
|120|`del`       |system       |        |remove file                                                          |
|121|`dir`       |system       |        |list directory content                                               |
|122|`exist`     |system       |        |existence of a file or directory                                     |
|123|`ioread`    |system       |        |read a byte from an I/O port                                         |
|124|`iowrite`   |system       |        |write a byte to an I/O port                                          |
|125|`md`        |system       |        |make directory                                                       |
|126|`rd`        |system       |        |remove directory                                                     |
|127|`ren`       |system       |        |rename file                                                          |
|128|`rmdevlock` |system       |        |remove device lock file                                              |
|129|`type`      |system       |        |type file                                                            |

(Commands with function keys (F?) are executed immediately, modifier keys
(ALT-?) only make typing easier.)  

## VII. Predefined things

### Predefined variables  

|name    |value                                      |
|:-------|:------------------------------------------|
|$verbose|verbosity level (values: NOTHING|ERROR|ALL)|

Empty and any other variable value are equivalent to ALL.

### Predefined constants  

|name    |value                                                     |
|:-------|:---------------------------------------------------------|
|$?      |exit value of the commands                                |
|$ARGx   |OS command line arguments (interpreter mode)              |
|$ARGCNT |number of the OS command line arguments (interpreter mode)|
|$B01    |150 (baud)                                                |
|$B03    |300 (baud)                                                |
|$B06    |600 (baud)                                                |
|$B1     |1200 (baud)                                               |
|$B2     |2400 (baud)                                               |
|$B4     |4800 (baud)                                               |
|$B9     |9600 (baud)                                               |
|$B19    |19200 (baud)                                              |
|$B38    |38400 (baud)                                              |
|$B57    |57600 (baud)                                              |
|$B115   |115200 (baud)                                             |
|$EULER  |value of e (2.7182818284590452354)                        |
|$HOME   |user's home directory                                     |
|$PI     |value of Pi (3.1415926535897932385)                       |
|$PRJDIR |directory of the actual project                           |
|$PRJNAME|name of the actual project                                |
|$SQRT2  |value of square root of 2                                 |
|$SQRT3  |value of square root of 3                                 |

### Predefined macros  

|name    |value                               |
|:-------|:-----------------------------------|
|mydev0  |set dev0 set /dev/ttyUSB0 9600 8 n 1|
|mypro0  |set pro0 rtu 1                      |
|mycon0  |set con0 dev0 pro0                  |

These macros can also be changed.

## VIII. Documentation and Help  

Modshell and XModShell has a minimal built-in help which you can access by
typing help. Additionally, you can view the manual page from *nix shell
(_man modshell_) or _modshell.txt_ on other systems.  

In the graphical version, the Online Wiki can be opened directly from the 'Help'
menu.  

## IX. Contributing  

If you find any bugs, please report them! I am also happy to accept pull
requests from anyone. You can use the GitHub issue tracker to report bugs, ask
questions, or suggest new features. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
for details.  

## X. Links  

 - [Homepage](http://www.pozsarzs.hu)  
 - [GitHub repository](https://github.com/pozsarzs/modshell)  
 - [Project webpage on Github](https://pozsarzs.github.io/modshell)  
 - [Online manual on Github](https://github.com/pozsarzs/modshell/wiki)  

### Source packages  

|name                                                                                                    |version    |
|--------------------------------------------------------------------------------------------------------|:---------:|
|[main.zip](https://github.com/pozsarzs/modshell/archive/refs/heads/main.zip)                            |latest     |
|[modshell-0.1beta1.tar.gz](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1beta1.tar.gz)|v0.1-beta1|
|[modshell-0.1alpha3.tar.gz](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha3.tar.gz)|v0.1-alpha3|
|[modshell-0.1alpha2.tar.gz](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha2.tar.gz)|v0.1-alpha2|
|[modshell-0.1alpha1.tar.gz](http://www.pozsarzs.hu/packages/software/modshell/modshell-0.1alpha1.tar.gz)|v0.1-alpha1|

### Binaries and installer packages for several OS and architecture

Not all test versions have binary or installation packages.
To download, visit [Modshell's webpage](http://www.pozsarzs.hu/software/modshell_en.html).

[^1]: [Synapse Github repository](https://github.com/geby/synapse)
[^2]: [InpOut32 Github repository](https://github.com/ellysh/InpOut32)
[^3]: [ProtCOM Github repository](https://github.com/pozsarzs/protcom)
[^4]: [Modbus](https://modbus.org)
[^5]: [Wiki - Differents between CUI and GUI version](https://github.com/pozsarzs/modshell/wiki/c.-Differents-between-CUI-and-GUI-version)
