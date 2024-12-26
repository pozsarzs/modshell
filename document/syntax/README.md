## Syntax highlighting

### Files

|Editor       |Filename       |Target file or directory                                                  |  
|-------------|---------------|--------------------------------------------------------------------------|  
|GTKSourceView|modshell.lang  |copy file into ~/.local/share/gtksourceview-?/language-specs/             |
|MCEdit       |Syntax         |insert file content to top of ~/.local/share/mc/Syntax                    |
|             |modshell.syntax|copy file into ~/.local/share/mc/Syntax/                                  |
|Micro        |modshell.yaml  |copy file into ~/.config/micro/syntax/                                    |
|Nano         |modshell.nanorc|copy file into /usr/share/nano/                                           |
|Notepad++    |modshell.xml   |copy file into %USERPROFILE%\AppData\Roaming\\Notepad++\\userDefineLangs\ |
|(Neo)Vim     |modshell.vim   |copy file into ~/.config/vim/syntax/                                      |
|             |scripts.vim    |copy file into ~/.config/vim/                                             |

> [!NOTE]
> Applications using GtkSourceView, for example: Builder, Geany, Gedit, Mousepad, Pluma, Scribes.
> The target directory is not the same for all of them.

### Synopsis

 - case: insensitivity  
 - comment: after `#`  
 - start line:  
     `#!\....`  
     `@modshell.exe...`  
     `@goto eof`  
     `@:eof`
 - text: between `""`  
 - word group #1:  
     `dev[0-7]` `pro[0-7]` `con[0-7]` `color` `project` `timeout`  
 - word group #2:  
     `add` `and` `applog` `arrclear` `arrcopy` `arrfill` `ascii` `avg`  
     `beep` `bit`  
     `cd` `chkdevlock` `chr` `cls` `carr` `concat` `const` `conv` `copyreg` `copy` `cos` `cotan` `cron`  
     `date` `dcon` `dec` `del` `dir` `div` `do` `dump`  
     `echometh` `edit` `erasescr` `exist` `exit` `exphis` `expreg` `exp`  
     `for`  
     `get` `getarrsize` `goto`  
     `help`  
     `idiv` `if` `imod` `impreg` `inc` `inputmeth` `inrange`  
     `label` `length` `let` `list` `ln` `loadcfg` `loadreg` `loadscr` `lowcase`  
     `mbgw` `mbmon` `mbsrv` `md` `mkcrc` `mklrc` `mulinv` `mul`  
     `not`  
     `odd` `ord` `or`  
     `pause` `pow2` `pow` `print` `printcolor` `prop`  
     `rd` `readreg` `ren` `reset` `rmdevlock` `rnd` `roll` `rolr` `round` `run`  
     `savecfg` `savereg` `savescr` `sendmeth` `sercons` `serread` `serwrite` `set` `setarrsize` `shl` `shr` `sin` `sqrt` `sqr` `strdel` `strfind` `strins` `stritem` `strrepl` `sub`  
     `tan` `tcpcons` `tcpread` `tcpwrite` `then` `to` `type`  
     `udpcons` `udpread` `udpwrite` `upcase`  
     `varmon` `var` `varr` `ver`  
     `writereg`  
     `xor`
 - word group #3:  
     `an` `ascii` `bin` `coil` `chr` `csv` `dec` `dcon` `dinp` `hart` `hex` `hreg` `ini` `ireg` `net` `oct` `off` `rtu` `ser` `str` `swap` `tcp` `xml`  
 - word group #4:  
     `<` `<=` `=` `=>` `>` `<>` `==`  
