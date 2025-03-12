" Vim syntax file
" Language:	ModShell script
" Maintainer:	Pozsar Zsolt <pozsarzs@gmail.com>
" Last Change:	2025 Jan 25

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

syn keyword modshellFunction abs add and applog arrclear arrfill ascii avg
syn keyword modshellFunction beep bit
syn keyword modshellFunction carr cd chkdevlock chr cls concat const conv copy copyreg cos cotan cron
syn keyword modshellFunction datatype date dcon dec del dir div dump
syn keyword modshellFunction echometh edit erasescr exist exit exp exphis expreg
syn keyword modshellFunction for
syn keyword modshellFunction get getarrsize goto gpioread gpiowrite
syn keyword modshellFunction hart help
syn keyword modshellFunction idiv if imod impreg inc input inputmeth inrange ioread iowrite
syn keyword modshellFunction label length let list ln loadcfg loadreg loadscr lowcase
syn keyword modshellFunction macro mbconv mbgw mbmon mbsrv md mkcrc mklrc mul mulinv
syn keyword modshellFunction not
syn keyword modshellFunction odd or ord
syn keyword modshellFunction pause pipe pow pow2 print printcolor prop
syn keyword modshellFunction rd readreg ren reset rmdevlock rnd roll rolr round run runmeth
syn keyword modshellFunction savecfg savereg savescr sendmeth sercons serread serwrite set setarrsize shl shr sin sqr sqrt stack strdel strfind strins stritem strrepl sub swp
syn keyword modshellFunction tan tcpcons tcpread tcpwrite then to type
syn keyword modshellFunction udpcons udpread udpwrite upcase
syn keyword modshellFunction var varmon varr ver
syn keyword modshellFunction writereg
syn keyword modshellFunction xor

syn keyword modshellPredefined an ascii
syn keyword modshellPredefined bin
syn keyword modshellPredefined chr coil csv
syn keyword modshellPredefined dcon dec dinp
syn keyword modshellPredefined hart hex hreg
syn keyword modshellPredefined ini ireg
syn keyword modshellPredefined net
syn keyword modshellPredefined oct off
syn keyword modshellPredefined rtu
syn keyword modshellPredefined ser str swap
syn keyword modshellPredefined tcp
syn keyword modshellPredefined xml

syn match modshellSymbolOperator "[<>]=\="
syn match modshellSymbolOperator "=\=[<>]"
syn match modshellSymbolOperator "="
syn match modshellSymbolOperator "<>"
syn match modshellSymbolOperator "=="

syn match modshellDevice "dev[0-7]"
syn match modshellDevice "pro[0-7]"
syn match modshellDevice "con[0-7]"
syn match modshellDevice "color"
syn match modshellDevice "project"
syn match modshellDevice "timeout"

syn region modshellComment start="@modshell" end="$"
syn region modshellComment start="@goto" end="$"
syn region modshellComment start=":eof" end="$"
syn region modshellComment start="#" end="$"
syn region modshellString matchgroup=modshellString start=+"+ end=+"+ contains=modshellStringEscape
syn match modshellStringEscape	contained '""'

hi def link modshellFunction		Function
hi def link modshellPredefined		pascalStatement
hi def link modshellSymbolOperator	pascalOperator
hi def link modshellComment		Comment
hi def link modshellString		String
hi def link modshellStringEscape	Special
hi def link modshellDevice		Type

let b:current_syntax = "modshell"
