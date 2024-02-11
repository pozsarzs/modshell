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
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(languages); do \
	  if [ -f $$x/$(name).mo ]; \
	  then \
	    $(rm) $(targetdir)/$$x/LC_MESSAGES/$(name).mo; \
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
	  $(call conv_encode,hu,852); \
	  $(call conv_encode,hu,1250); \
	else \
	  echo "To create message file for DOS and Windows, install the necessary tools."; \
	fi
