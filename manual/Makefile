# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for manuals                                                       |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="manuals       "
removetargetdir=0
sourcedir="."
targetdir=$(mandir)
filemode=$(txtmode)
man1files=`ls $(sourcedir)/*.1 | grep -v Makefile | grep -v '\.in'`

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir)/man1;
	@for x in $(man1files); do \
	  if [ -f $$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir)/man1/; \
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

convert:
	@if [ $(man) != "no" ] && [ $(unix2dos) != "no" ]; \
	then \
	  if [ -f $(name).1 ]; \
	  then \
	    $(man) ./$(name).1 > ../package/dos-bin/$(name).txt; \
	    $(unix2dos) ../package/dos-bin/$(name).txt; \
	  fi \
	else \
	  echo "To create manual page for DOS, install the necessary tools."; \
	fi
