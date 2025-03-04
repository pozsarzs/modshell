## Syntax highlighting

### Syntax files

|Editor            |Filename                  |Install method                                                            |  
|------------------|--------------------------|--------------------------------------------------------------------------|  
|GTKSourceView     |modshell.lang             |copy file into ~/.local/share/gtksourceview-?/language-specs/             |
|MCEdit            |Syntax                    |insert file content to top of ~/.local/share/mc/Syntax                    |
|                  |modshell.syntax           |copy file into ~/.local/share/mc/Syntax/                                  |
|Micro             |modshell.yaml             |copy file into ~/.config/micro/syntax/                                    |
|Nano              |modshell.nanorc           |copy file into /usr/share/nano/                                           |
|Notepad++         |modshell.xml              |copy file into %USERPROFILE%\AppData\Roaming\\Notepad++\\userDefineLangs\ |
|(Neo)Vim          |modshell.vim              |copy file into ~/.config/vim/syntax/                                      |
|                  |scripts.vim               |copy file into ~/.config/vim/                                             |
|Visual Studio Code|modshell-script           |copy directory to ~/.vscode/extensions/                                   |
|Visual Studio Code|modshell-script-0.0.1.vsix|Install with Visual Studio Code application                               |

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
 - word group #1: See file `group-1.lst`.
 - word group #2: See file `group-2.lst`.
 - word group #3: See file `group-3.lst`.
 - word group #4: See file `group-4.lst`.
