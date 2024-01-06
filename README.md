#### Attention! This software is still under development.
---
## Modshell * Command-driven scriptable Modbus utility
Copyright (C) 2023 Pozsár Zsolt <pozsarzs@gmail.com>
Homepage: <http://www.pozsarzs.hu>
GitHub: <https://github.com/pozsarzs/modshell>
Online manual: <https://github.com/pozsarzs/modshell/wiki>

#### Software
|features             |                            |
|---------------------|----------------------------|
|architecture         |amd64, armhf, i386, x86_64  |
|operation system     |DOS, FreeBSD, Linux, Windows|
|version              |v0.1                        |
|language             |en, hu                      |
|licence              |EUPL v1.2                   |
|local user interface |CLI and TUI                 |

#### Screenshots
Normal command line
![CLI](document/picture/modshell.png)
Fullscreen command line

![TUI](document/picture/modshell-f.png)

Run example script on bash with ModShell interpreter
![script running](document/picture/modshell-r.png)

#### Used external libraries
 - Bin/Oct/Dec/Hex number converter unit for Turbo Pascal v3.0
   Public Domain, Copyright (C) 1993 Tom Wellige
 - Ararat Synapse Release 40
   modified BSD style license, Copyright (c) 1999-2012 Lukas Gebauer

#### About

*ATTENTION! The program is still under development,
it is not yet suitable for its task.*

This is a utility that can be used on several operating systems,
which can communicate with connected equipment using
[Modbus](https://modbus.org/)/ASCII, Modbus/RTU and Modbus/TCP protocols.
The program can - even automatically - read, write or copy data from
one device to another (e.g. transferring settings). When copying, the
source and destination register areas can be different.

The program has a *traditional (CLI)* or *full-screen (TUI) command-line* interface
and is also *suitable for running pre-created scripts* independently (as a command
interpreter). The program provides help on the commands that can be used, and
offers possible values when the parameters are entered incorrectly. The issued
commands are placed in history, which can be browsed with the up/down arrow keys.

**Operating principle**

It must be defined the I/O devices, then the protocols and the connections.
There can be eight of each. The data traffic takes place between the preset
connections. In all cases, the data is sent to or read from the internal buffer.
The size of the buffer is suitable for storing 2*9999 logical and word values of
the same size. Sixty-four variables can be created in the program, to which we
can assign a value of any type (eg.: message, boolean or integer register
value, etc.) Variables can be used to perform logical and basic mathematical
operations, and can be used to pass values to commands.

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

One or more same type registers can be exported to file.
During saving, one text file is created, with CSV extension.

On exit, the command line history and full screen mode command line colors are
preserved.

**Already implemented commands:**

|command |category|hotkey|description                                                      |
|--------|--------|------|-----------------------------------------------------------------|
|cls     |general |F8    |clear screen                                                     |
|color   |general |      |set foreground and background color in full screen mode          |
|date    |general |      |show system date and time                                        |
|echo    |general |      |enable/disable local echo for serial connections                 |
|exit    |general |F10   |exit                                                             |
|help    |general |F1    |show description or usage of the commands                        |
|pause   |general |      |print a message and wait for a keystroke or specified time       |
|print   |general |ALT-P |print message, value of the variable and register                |
|var     |general |      |show all variable with theirs value or define a new one          |
|ver     |general |      |show version and build information of this program               |
|copy    |comm.   |      |copy one or more remote registers between two connections        |
|read    |comm.   |ALT-R |read one or more remote registers                                |
|write   |comm.   |ALT-W |write data to one or more remote registers                       |
|sercons |comm.   |F7    |serial console                                                   |
|serread |comm.   |      |read a string from serial device                                 |
|serwrite|comm.   |      |write a string from serial device                                |
|exphis  |file op.|      |export command line history to file (TXT)                        |
|expreg  |file op.|ALT-E |export one or more registers to file (CSV, INI, XML)             |
|impreg  |file op.|ALT-I |export one or more registers from file (CSV, INI, XML)           |
|loadcfg |file op.|F3    |load settings of device, protocol and connection (?DT)           |
|loadreg |file op.|F5    |load all buffer registers from typed file (?DT)                  |
|savecfg |file op.|F2    |save settings of device, protocol and connection (?DT)           |
|savereg |file op.|F4    |save all registers to typed file (?DT)                           |
|and     |logic   |      |AND logical operations                                           |
|or      |logic   |      |OR logical operations                                            |
|not     |logic   |      |NOT logical operations                                           |
|shl     |logic   |      |bit shift to left                                                |
|shr     |logic   |      |bit shift to right                                               |
|xor     |logic   |      |XOR logical operations                                           |
|add     |maths   |      |addition                                                         |
|conv    |maths   |ALT-C |convert numbers between BIN, DEC, HEX and OCT format             |
|div     |maths   |      |division                                                         |
|mul     |maths   |      |multiplication                                                   |
|sub     |maths   |      |substraction                                                     |
|dump    |register|F6    |dump all registers in binary/hexadecimal format to a table       |
|let     |register|ALT-L |set value of a variable or register                              |
|get     |settings|ALT-G |get setting of a device, protocol, connection or get project name|
|reset   |settings|ALT-T |reset device, protocol or connection or reset project name       |
|set     |settings|ALT-S |set device, protocol or connection or set project name           |

(Commands with function keys (F?) are executed immediately,
 modifier keys (ALT-?) only make typing easier.)

**Planned commands in next release (v0.2)**

|command|category      |hotkey|description                                                   |
|-------|--------------|------|--------------------------------------------------------------|
|srvtcp |communication |      |start/stop transparent Modbus/TCP server                      |
|srvrtu |communication |      |start/stop transparent Modbus/RTU slave                       |
|if     |general       |      |selection statement                                           |
|for    |general       |      |loop iteration                                                |
