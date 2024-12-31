# +----------------------------------------------------------------------------+
# | ModShell 0.1 * Command-driven scriptable Modbus utility                    |
# | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for message files                                                 |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="message files "
removetargetdir=0
sourcedir="."
targetdir=$(localedir)
filemode=$(txtmode)
languages=hu

# convert encoding and line-ending of the .po file for DOS
define conv_encode
  $(install) -d $(2)-cp$(3); \
  $(iconv) -f utf8 -t cp$(3) $(2)/$(1).po > $(2)-cp$(3)/out.po; \
  cat $(2)-cp$(3)/out.po | sed s/"charset=UTF-8"/"charset=cp$(3)"/ > $(2)-cp$(3)/$(1).po; \
  $(rm) $(2)-cp$(3)/out.po; \
  $(unix2dos) $(2)-cp$(3)/$(1).po; \
  $(msgfmt) $(2)-cp$(3)/$(1).po -o $(2)-cp$(3)/$(1).mo
endef

all:
	
clean:

install:
	@echo -n "- Installing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/$(name).mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/x$(name).mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/x$(name).mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/tcpechoserver.mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/tcpechoserver.mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@for x in $(languages); do \
	  if [ -f $$x/udpechoserver.mo ]; \
	  then \
	    $(install) -d $(targetdir)/$$x/LC_MESSAGES/; \
	    $(install) -m $(filemode) $(sourcedir)/$$x/udpechoserver.mo $(targetdir)/$$x/LC_MESSAGES/; \
	    echo -n "#"; \
	  fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/$(name).mo; \
	    echo -n "#"; \
	  fi; \
	done  
	@for x in $(languages); do \
	  if [ -f $$x/x$(name).mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/x$(name).mo; \
	    echo -n "#"; \
	  fi; \
	  if [ $(removetargetdir) -eq 1 ]; \
	  then \
	    if [ -d $(targetdir)/$$x/LC_MESSAGES ]; then $(rmdir) $(targetdir)/$$x/LC_MESSAGES; fi; \
	  fi; \
	done
	@echo "]"

convert:
	@if [ $(iconv) != "no" ] && [ $(msgfmt) != "no" ] && [ $(unix2dos) != "no" ]; \
	then \
	  $(call conv_encode,modshell,hu,852); \
	  $(call conv_encode,modshell,hu,1250); \
	  $(call conv_encode,serialechoserver,hu,1250); \
	  $(call conv_encode,serialmbmonitor,hu,1250); \
	  $(call conv_encode,tcpechoserver,hu,1250); \
	  $(call conv_encode,udpechoserver,hu,1250); \
	else \
	  echo "To create message file for DOS and Windows, install the necessary tools."; \
	fi
