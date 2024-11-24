" Vim syntax file
" Language:	ModShell script
" Maintainer:	Pozsar Zsolt <pozsarzs@gmail.com>
" Last Change:	2024 Oct 28

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

syn keyword modshellFunction add and applog arrclear arrcopy arrfill arrsize ascii avg
syn keyword modshellFunction beep bit
syn keyword modshellFunction cd chkdevlock chr cls carr concat const conv copyreg copy cos cotan cron
syn keyword modshellFunction date dcon dec del dir div do dump
syn keyword modshellFunction echo edit erasescr exist exit exphis expreg exp
syn keyword modshellFunction for
syn keyword modshellFunction get goto
syn keyword modshellFunction hart help
syn keyword modshellFunction idiv if imod impreg inc inrange
syn keyword modshellFunction label length let list ln loadcfg loadreg loadscr lowcase
syn keyword modshellFunction mbgw mbsrv md mkcrc mklrc mulinv mul
syn keyword modshellFunction not
syn keyword modshellFunction odd ord or
syn keyword modshellFunction pause pow2 pow print printcolor prop
syn keyword modshellFunction rd readreg ren reset rmdevlock rnd roll rolr round run
syn keyword modshellFunction savecfg savereg savescr sercons serread serwrite set shl shr sin sqrt sqr strdel strfind strins stritem strrepl sub
syn keyword modshellFunction tan tcpcons tcpread tcpwrite then to type
syn keyword modshellFunction udpcons udpread udpwrite upcase
syn keyword modshellFunction varmon var varr ver
syn keyword modshellFunction writereg
syn keyword modshellFunction xor

syn keyword modshellPredefined bin coil csv dec dinp hex hreg ini ireg net
syn keyword modshellPredefined oct off on rtu ser swap tcp xml

syn match modshellSymbolOperator "[<>]=\="
syn match modshellSymbolOperator "="
syn match modshellSymbolOperator "<>"

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
