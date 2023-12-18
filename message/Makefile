# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for message files                                                 |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="message files "
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
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/$(name).mo $(targetdir)/$$x; \
	    echo -n "#"; \
	  fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
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
