SUBDIRS = src doc
.PHONY: $(SUBDIRS) all
prefix = /usr
datadir = $(prefix)/share
pkgdatadir = $(datadir)/mp-sparql

CDEP=doc/common/common.ent

all: $(SUBDIRS)

$(SUBDIRS): $(CDEP)
	$(MAKE) -C $@

clean check: $(CDEP)
	for d in $(SUBDIRS); do \
		$(MAKE) -C $$d $@; \
	done

install:
	mkdir -p $(DESTDIR)$(pkgdatadir)/bibframe
	cp bibframe/*.xml $(DESTDIR)$(pkgdatadir)/bibframe
	for d in $(SUBDIRS); do \
		$(MAKE) -C $$d $@; \
	done

$(CDEP):
	git submodule init
	git submodule update