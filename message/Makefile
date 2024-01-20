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
languages=hu

# convert encoding and line-ending of the .po file for DOS
define conv_encode
  $(install) -d $(1)-cp$(2); \
  $(iconv) -f utf8 -t cp$2 $1/$(name).po > $(1)-cp$(2)/out.po; \
  cat $(1)-cp$(2)/out.po | sed s/"charset=UTF-8"/"charset=cp$(2)"/ > $(1)-cp$(2)/$(name).po; \
  $(rm) $(1)-cp$(2)/out.po; \
  $(unix2dos) $(1)-cp$(2)/$(name).po; \
  $(msgfmt) $(1)-cp$(2)/$(name).po -o $(1)-cp$(2)/$(name).mo
endef

all:
	@if [ $(iconv) != "no" ] && [ $(msgfmt) != "no" ] && [ $(unix2dos) != "no" ]; \
	then \
	  $(call conv_encode,hu,852); \
	else \
	  echo "To create message file for DOS, install the necessary tools."; \
	fi
	
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
