# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="binary files  "
removetargetdir=0
sourcedir=_lib/$(architecture)-$(os)
targetdir=$(bindir)
filemode=$(binmode)

projectdirs="modshell"
#projectdirs="modshell xmodshell"

all:
	@mkdir -p $(sourcedir)/
	@for x in $(projectdirs); do \
	  if [ -d $$x ]; \
	  then \
	    cd $$x; \
	    if [ -f $$x.pas ]; then $(fpc) $(fpcargs) $$x.pas; fi; \
	    if [ -f $$x.lpr ]; then $(fpc) $(fpcargs) $$x.lpr; fi; \
	    cd ..; \
	    echo ""; \
	  fi; \
	done
	@if [ -f $(sourcedir)/$(name).rsj ]; \
	  then \
	    $(rstconv) -f po -p utf-8 -i $(sourcedir)/$(name).rsj  -o ../message/$(name).pot; \
	fi

clean:
	@for x in $(projectdirs); do \
	  $(rm) $$x/config.pas; \
	done
	@$(rm) $(sourcedir)/*

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir)
	@for x in $(projectdirs); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(projectdirs); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi
	@echo "]"

convert:
