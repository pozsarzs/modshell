# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="binary files  "
removetargetdir=0
sourcedir=_lib/$(architecture)-$(os)
podir=_po
targetdir=$(bindir)
filemode=$(binmode)
projectdirs=modshell serialechoserver serialmbmonitor tcpechoserver \
            udpechoserver xmodshell lhelp

all:
	@mkdir -p $(sourcedir)/
	@for x in $(projectdirs); do \
	  if [ -d $$x ]; \
	  then \
	    cd $$x; \
            if [ ! $(cui) = "no" ] && [ $$x = "modshell" ];  then \
	      if [ -f $$x.pas ]; then $(fpc) $(fpcargs) $$x.pas; fi; \
	    fi; \
            if [ ! $(util) = "no" ] && [ ! $$x = "modshell" ] && [ ! $$x = "xmodshell" ]; then \
              if [ -f $$x.pas ]; then $(fpc) $(fpcargs) $$x.pas; fi; \
	    fi; \
            if [ ! $(gui) = "no" ] && [ $(lclunits) = "yes" ] && [ $$x = "xmodshell" ]; then \
              if [ -f $$x.lpr ]; then $(fpc) $(fpcargs) $$x.lpr; fi; \
	    fi; \
            if [ ! $(gui) = "no" ] && [ ! $(lhelp) = "no" ] && [ $(lclunits) = "yes" ]; then \
              if [ -f $$x.lpr ]; then $(fpc) $(fpcargs) $$x.lpr; fi; \
	    fi; \
	    cd ..; \
	    echo ""; \
	  fi; \
	done
	@for x in $(projectdirs); do \
          if [ -f $(sourcedir)/$$x.rsj ]; \
	  then \
	    $(rstconv) -f po -p utf-8 -i $(sourcedir)/$$x.rsj  -o ../message/$$x.pot; \
	  fi; \
	  if [ -f $(podir)/$$x.pot ]; then mv $(podir)/$$x.pot  ../message/; fi \
	done

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

createhelp:
