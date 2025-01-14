# JACK

JACK_VERSION := 0.121.3
JACK_URL := $(GITHUB)/jackaudio/jack1/archive/$(JACK_VERSION).tar.gz

# disabled by default for now
#PKGS += jack
ifeq ($(call need_pkg,"jack"),)
PKGS_FOUND += jack
endif

$(TARBALLS)/jack1-$(JACK_VERSION).tar.gz:
	$(call download_pkg,$(JACK_URL),jack)

.sum-jack: jack1-$(JACK_VERSION).tar.gz

jack: jack1-$(JACK_VERSION).tar.gz .sum-jack
	$(UNPACK)
ifdef HAVE_MACOSX
	$(APPLY) $(SRC)/jack/config-osx.patch
endif
	$(MOVE)

.jack: jack
	$(RECONF)
	$(MAKEBUILDDIR)
	$(MAKECONFIGURE)
	+$(MAKEBUILD)
	+$(MAKEBUILD) install
	touch $@
