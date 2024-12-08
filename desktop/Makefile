# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for many files of the same type                                   |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="desktop files "
removetargetdir=0
sourcedir="."
filemode=$(txtmode)
targetdir1=$(datarootdir)/applications
files1=`ls $(sourcedir)/*.desktop | grep -v Makefile`
targetdir2=$(datarootdir)/pixmaps
files2=`ls $(sourcedir)/*.png | grep -v Makefile`

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir1)
	@for x in $(files1); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir1); \
	    echo -n "#"; \
	  fi \
	done
	@$(install) -d $(targetdir2)
	@for x in $(files2); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir2); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(files1); do \
	  $(rm) $(targetdir1)/$$x; \
	  echo -n "#"; \
	done
	@for x in $(files2); do \
	  $(rm) $(targetdir2)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir1) ]; then $(rmdir) $(targetdir1); fi; \
	  if [ -d $(targetdir2) ]; then $(rmdir) $(targetdir2); fi; \
	fi;
	@echo "]"

convert:
