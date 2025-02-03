# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for many files of the same type                                   |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="help files    "
removetargetdir=1
sourcedir="."
targetdir=$(datarootdir)/$(name)/help
filemode=$(txtmode)
files=`ls $(sourcedir)/*.chm | grep -v Makefile`
projectdirs=en

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir)
	@for x in $(files); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(files); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi;
	@echo "]"

convert:

createhelp:
	@if [ $(chmcmd) != "no" ]; \
	then \
	  for x in $(projectdirs); do \
	    if [ -f $$x/$(name)_$$x.hhp ]; \
	    then \
	      cd $$x; \
	      $(chmcmd) $(name)_$$x.hhp; \
	      mv $(name)_$$x.chm ..; \
	      cd ..; \
	    fi; \
	  done; \
	else \
	  echo "To create CHM help file, install the necessary tools."; \
	fi
