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
    `add` `and` `applog` `arrclear` `arrcopy` `arrfill` `arrsize` `ascii` `avg`  
    `beep` `bit`  
    `cd` `chkdevlock` `chr` `cls` `carr` `concat` `const` `conv` `copyreg` `copy` `cos` `cotan` `cron`  
    `date` `dcon` `dec` `del` `dir` `div` `do` `dump`  
    `echo` `edit` `erasescr` `exist` `exit` `exphis` `expreg` `exp`  
    `for`  
    `get` `goto`  
    `help`  
    `idiv` `if` `imod` `impreg` `inc` `inrange`  
    `label` `length` `let` `list` `ln` `loadcfg` `loadreg` `loadscr` `lowcase`  
    `mbgw` `mbsrv` `md` `mkcrc` `mklrc` `mulinv` `mul`  
    `not`  
    `odd` `ord` `or`  
    `pause` `pow2` `pow` `print` `printcolor` `prop`  
    `rd` `readreg` `ren` `reset` `rmdevlock` `rnd` `roll` `rolr` `round` `run`  
    `savecfg` `savereg` `savescr` `sercons` `serread` `serwrite` `set` `shl` `shr` `sin` `sqrt` `sqr` `strdel` `strfind` `strins` `stritem` `strrepl` `sub`  
    `tan` `then` `to` `type`  
    `upcase`  
    `varmon` `var` `varr` `ver`  
    `writereg`  
    `xor`
- word group #3:  
    `ascii` `bin` `coil` `csv` `dec` `dcon` `dinp` `hart` `hex` `hreg` `ini` `ireg` `net` `oct` `off` `on` `rtu` `ser` `swap` `tcp` `xml`
- word group #4:  
    `<` `<=` `=` `=>` `>` `<>`