# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command line Modbus utility                                 |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for message files                                                 |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="message files\t"
removetargetdir=0
sourcedir="."
targetdir=$(localedir)
filemode=$(txtmode)
languages = hu

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x\$(name).mo ]; \
	  then \
	    $(install) --directory $(targetdir)/$$x; \
	    $(install) --mode $(filemode) $(sourcedir)/$$x.mo/$(name).mo $(targetdir)/$$x; \
	    mv $(targetdir)/$$x/$(name)_$$x.mo $(targetdir)/$$x/$(name).mo; \
	    echo -n "#"; \
	  fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x\$(name).mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/$(name).mo; \
	    echo -n "#"; \
	  fi; \
	  if [ $(removetargetdir) -eq 1 ]; \
	  then \
	    if [ -d $(targetdir)/$$x ]; then $(rmdir) $(targetdir)/$$x; fi; \
	  fi; \
	done
	@echo "]"
