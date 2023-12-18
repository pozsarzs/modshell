## Modshell * Command-driven scriptable Modbus utility
Copyright (C) 2023 Pozsár Zsolt <pozsarzs@gmail.com>  
Homepage: <http://www.pozsarzs.hu>  
GitHub: <https://github.com/pozsarzs/modshell>

#### Software
|features              |                                             |
|:---------------------|---------------------------------------------|
|architecture          |amd64, armhf, i386, x86_64                   |
|operation system      |DOS, FreeBSD, Linux, Windows                 |
|version               |v0.1                                         |
|language              |en, hu                                       |
|licence               |EUPL v1.2                                    |
|local user interface  |CLI and TUI                                  |

#### Used external libraries
 - Bin/Oct/Dec/Hex number converter unit for Turbo Pascal v3.0
   Public Domain, Copyright (C) 1993 by Tom Wellige

#### About

*ATTENTION! The program is still under development,
it is not yet suitable for its task.*

This is a utility that can be used on several operating systems,
which can communicate with connected equipment using [Modbus](https://modbus.org/)/ASCII,
-/RTU and -/TCP protocols.
The program can - even automatically - read, write or copy data from
one device to another (e.g. transferring settings). When copying, the
source and destination register areas can be different.

The program has a traditional (CLI) or full-screen (TUI) command-line
interface and is also suitable for running pre-created scripts
independently (as a command interpreter). The program provides help
on the commands that can be used, and offers possible values when
the parameters are entered incorrectly.
The issued commands are placed in history, which can be browsed with
the up/down arrow keys. The history can be exported to a text file and
provides it with the appropriate 'shebang' for the installation method
and operating system (eg. #!/usr/local/bin/modshell). You can easily
create a script from this raw file.

**Operating principle:**  

It must be defined the I/O devices, then the protocols and the
connections. There can be eight of each. These can be saved to
disk to binary format and reloaded. The data traffic takes place
between the preset connections.
In all cases, the data is sent to or read from the internal buffer.
The size of the buffer is suitable for storing 2*9999 logical and
word values of the same size. The contents of the buffer can be
exported to a text file.

**Already implemented commands:**  

|command|hotkey|description                                           |
|:------|------|------------------------------------------------------|
|cls    |F8    |clear screen                                          |
|copy   |      |copy one or more register between two connections     |
|conv   |ALT-C |convert numbers between BIN, DEC, HEX and OCT format  |
|date   |      |show system date and time                             |
|exit   |F10   |exit                                                  |
|exphis |      |export history to a text file                         |
|expreg |ALT-E |export content of the one or more buffer registers    |
|get    |ALT-G |get setting of a device, protocol or connection       |
|help   |F1    |show description or usage of the commands             |
|let    |ALT-L |set value of a buffer registers                       |
|loadcfg|F3    |load settings of device, protocol and connection      |
|print  |ALT-P |print content of the one or more buffer registers     |
|read   |ALT-R |read one or more remote registers to buffer           |
|reset  |ALT-T |reset device, protocol or connection                  |
|savecfg|F2    |save settings of device, protocol and connection      |
|set    |ALT-S |set device, protocol or connection                    |
|ver    |      |show version and build information of this program    |
|write  |ALT-W |write data from buffer to one or more remote registers|

(Commands with function keys (F?) are executed immediately,
 modifier keys (ALT-?) only make typing easier.)  

**Planned commands**  

|command|hotkey|description                                         |
|:------|------|----------------------------------------------------|
|if     |      |selection statement                                 |
|for    |      |loop iteration                                      |

**Planned logical operations:**  

|sign             |description               |
|:----------------|--------------------------|
|and; or; not; xor|general logical operations|
|shl; shr         |bit shift                 |

 **Planned mathematical operation:**  

|sign|description                   |
|:---|------------------------------|
|ent |add value to stack            |
|add |addition                      |
|sub |substraction                  |
|mul |multiplication                |
|div |division                      |
|roll|roll down stack               |
|swap|swap number with top of stack |
 
(Reverse Polish Notation mode with 4 word size registers (x, y, z, t))
