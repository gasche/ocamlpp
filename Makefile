###########################################################################
##                                                                       ##
##                               OCamlPP                                 ##
##                                                                       ##
##                            Benoit Vaugon                              ##
##                                                                       ##
##    This file is distributed under the terms of the CeCILL license.    ##
##    See file LICENSE-en.                                               ##
##                                                                       ##
###########################################################################

include etc/Makefile.conf

all: config
	@make --no-print-directory -C src

config:
	@if [ etc/Makefile.conf -ot VERSION -o \
             etc/Makefile.conf -ot configure ]; then \
          echo 'Configuration files are not up to date.' 1>&2; \
	  echo 'Please run `./configure` (with right options).' 1>&2; \
          exit 1; \
	fi

install: all
	mkdir -p "$(BINDIR)"
	mkdir -p "$(MAN1DIR)"
	cp bin/bcpp "$(BINDIR)/bcpp"
	cp bin/cmopp "$(BINDIR)/cmopp"
	cp man/bcpp.1.gz "$(MAN1DIR)/bcpp.1.gz"
	cp man/cmopp.1.gz "$(MAN1DIR)/cmopp.1.gz"

uninstall:
	rm -f "$(BINDIR)/bcpp"
	rm -f "$(BINDIR)/cmopp"
	rm -f "$(MAN1DIR)/bcpp.1.gz"
	rm -f "$(MAN1DIR)/cmopp.1.gz"

etc/Makefile.conf:
	@echo "You must run ./configure before" 1>&2
	@exit 1

dist: clean
	dist/distgen

clean:
	@make --no-print-directory -C src clean

.PHONY: all config install uninstall dist clean
