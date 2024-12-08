## ANSI Escape Sequences

###Important screen control sequences

Used sequence type is _CSI_ (Control Sequence Introducer). This type starting
with ESC[ (_\x1B[_) or CSI (_\x9B_).  

|Sequence         |Description                                           |
|:----------------|:-----------------------------------------------------|
|`ESC[H`          |moves cursor to home position                         |
|`ESC[{l};{c}H`   |moves cursor to line #, column #                      |
|`ESC[{l};{c}f`   |moves cursor to line #, column #                      |
|`ESC[#A`         |moves cursor up # lines                               |
|`ESC[#B`         |moves cursor down # lines                             |
|`ESC[#C`         |moves cursor right # columns                          |
|`ESC[#D`         |moves cursor left # columns                           |
|`ESC[#E`         |moves cursor to beginning of next line, # lines down  |
|`ESC[#F`         |moves cursor to beginning of previous line, # lines up|
|`ESC[#G`         |moves cursor to column #                              |
|`ESC[6n`         |request cursor position (reports as `ESC[#;#R`)       |
|`ESC[J`          |erase in display                                      |
|`ESC[0J`         |erase from cursor until end of screen                 |
|`ESC[1J`         |erase from cursor to beginning of screen              |
|`ESC[2J`         |erase entire screen                                   |
|`ESC[3J`         |erase saved lines                                     |
|`ESC[K`          |erase in line                                         |
|`ESC[0K`         |erase from cursor to end of line                      |
|`ESC[1K`         |erase start of line to the cursor                     |
|`ESC[2K`         |erase the entire line                                 |
|`ESC[1;34;{...}m`|set graphics modes for cell, separated by semicolon   |
|`ESC[0m`         |reset all modes (styles and colors)                   |
|`ESC[1m`         |set bold mode.                                        |
|`ESC[2m`         |set dim/faint mode.                                   |
|`ESC[3m`         |set italic mode.                                      |
|`ESC[4m`         |set underline mode.                                   |
|`ESC[5m`         |set blinking mode                                     |
|`ESC[7m`         |set inverse/reverse mode                              |
|`ESC[8m`         |set hidden/invisible mode                             |
|`ESC[9m`         |set strikethrough mode.                               |
|`ESC[22m`        |reset bold mode.                                      |
|`ESC[22m`        |reset dim/faint mode.                                 |
|`ESC[23m`        |reset italic mode.                                    |
|`ESC[24m`        |reset underline mode.                                 |
|`ESC[25m`        |reset blinking mode                                   |
|`ESC[27m`        |reset inverse/reverse mode                            |
|`ESC[28m`        |reset hidden/invisible mode                           |
|`ESC[29m`        |reset strikethrough mode.                             |

### Color codes

|Color  |Foreground|Background|
|:------|:--------:|:--------:|
|black  |`30`      |`40`      |
|red    |`31`      |`41`      |
|green  |`32`      |`42`      |
|yellow |`33`      |`43`      |
|blue   |`34`      |`44`      |
|magenta|`35`      |`45`      |
|cyan   |`36`      |`46`      |
|white  |`37`      |`47`      |
|default|`39`      |`49`      |
|reset  |`0`       |`0`       |
