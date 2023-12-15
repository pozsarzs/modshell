# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command line Modbus utility                                 |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for manuals                                                       |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="manuals\t\t"
removetargetdir=0
sourcedir="."
targetdir=$(mandir)
filemode=$(txtmode)
man1files=`ls $(sourcedir)/*.1 | grep -v Makefile | grep -v '\.in'`

all:

clean:
	@for x in $(man1files); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(rm) $(sourcedir)/$$x; \
	  fi \
	done

install:
	@echo -n "- Installing "$(title)"["
	@$(install) --directory $(targetdir)/man1;
	@for x in $(man1files); do \
	  if [ -f $$x ]; \
	  then \
	    $(install) --mode $(filemode) $(sourcedir)/$$x $(targetdir)/man1/; \
	    echo -n "#"; \
	    fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(man1files); do \
	  if [ -f $$x ]; \
	  then \
	    $(rm) $(targetdir)/man1/$$x; \
	    echo -n "#"; \
	  fi; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir)/man1 ]; then $(rmdir) $(targetdir)/man1; fi; \
	fi;
	@echo "]"
