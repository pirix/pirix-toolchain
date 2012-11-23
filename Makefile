TARGET=arm-elf-pirix
PREFIX=/usr/local/cross

BINUTILS_VERSION=2.22
BINUTILS_URL=http://ftp.gnu.org/gnu/binutils
BINUTILS_DIR=binutils-$(BINUTILS_VERSION)
BINUTILS_PACKAGE=$(BINUTILS_DIR).tar.gz

GCC_VERSION=4.6.3
GCC_URL=http://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}
GCC_DIR=gcc-$(GCC_VERSION)
GCC_PACKAGE=gcc-core-$(GCC_VERSION).tar.gz

NEWLIB_VERSION=1.20.0
NEWLIB_URL=ftp://sources.redhat.com/pub/newlib
NEWLIB_DIR=newlib-$(NEWLIB_VERSION)
NEWLIB_PACKAGE=$(NEWLIB_DIR).tar.gz

DL=wget -c
UNPACK=tar xf

PATH:=$(PATH):$(PREFIX)/bin

all: binutils-make gcc-make newlib-make

install: binutils-install gcc-install newlib-install

clean:
	rm -rf build/
	rm -rf $(BINUTILS_DIR)
	rm -rf $(GCC_DIR)
	rm -rf $(NEWLIB_DIR)

#
# BINUTILS
#

binutils-install:
	make -C build/binutils install

binutils-data: $(BINUTILS_DIR)

binutils-make: $(BINUTILS_DIR)/.patched
	mkdir -p build/binutils
	cd build/binutils && ../../$(BINUTILS_DIR)/configure \
	                     --target=$(TARGET) \
				         --prefix=$(PREFIX) \
                         --disable-nls \
                         --with-float=soft
	make -C build/binutils all

binutils-diff: $(BINUTILS_PACKAGE)
	mv $(BINUTILS_DIR) $(BINUTILS_DIR)-pirix
	$(UNPACK) $(BINUTILS_PACKAGE)
	diff -rupN $(BINUTILS_DIR)/ $(BINUTILS_DIR)-pirix/ > patch/binutils.patch || :

$(BINUTILS_DIR)/.patched: $(BINUTILS_DIR)
	patch -p0 < patch/binutils.patch
	cp data/binutils/armelf_pirix.sh $(BINUTILS_DIR)/ld/emulparams/
	touch $(BINUTILS_DIR)/.patched

$(BINUTILS_DIR): $(BINUTILS_PACKAGE)
	$(UNPACK) $(BINUTILS_PACKAGE)

$(BINUTILS_PACKAGE):
	$(DL) $(BINUTILS_URL)/$(BINUTILS_PACKAGE)

#
# GCC
#

gcc-install:
	make -C build/gcc install-gcc
	make -C build/gcc install-target-libgcc

gcc-data: $(GCC_DIR)

gcc-make: gcc-configure
	make -C build/gcc all-gcc
	make -C build/gcc all-target-libgcc

gcc-configure: $(GCC_DIR)/.patched
	mkdir -p build/gcc
	cd build/gcc && ../../$(GCC_DIR)/configure \
	                     --target=$(TARGET) \
				         --prefix=$(PREFIX) \
	                     --disable-nls \
                         --disable-shared \
                         --disable-libssp \
                         --enable-languages=c \
                         --with-newlib \
                         --with-float=soft

gcc-diff: $(GCC_PACKAGE)
	mv $(GCC_DIR) $(GCC_DIR)-pirix
	$(UNPACK) $(GCC_PACKAGE)
	diff -rupN $(GCC_DIR)/ $(GCC_DIR)-pirix/ > patch/gcc.patch  || :

$(GCC_DIR)/.patched: $(GCC_DIR)
	patch -p0 < patch/gcc.patch
	cp data/gcc/pirix.h $(GCC_DIR)/gcc/config/
	touch $(GCC_DIR)/.patched

$(GCC_DIR): $(GCC_PACKAGE)
	$(UNPACK) $(GCC_PACKAGE)

$(GCC_PACKAGE):
	$(DL) $(GCC_URL)/$(GCC_PACKAGE)

#
# NEWLIB
#


newlib-install:
	make -C build/newlib install

newlib-data: $(NEWLIB_DIR)

newlib-make: $(NEWLIB_DIR)/.patched
	mkdir -p build/newlib
	cd build/newlib && ../../$(NEWLIB_DIR)/configure \
	                     --target=$(TARGET) \
				         --prefix=$(PREFIX) \
                         --enable-interwork \
                         --with-gnu-ld \
                         --with-gnu-as \
                         --with-float=soft
	make -C build/newlib all

newlib-diff: $(NEWLIB_PACKAGE)
	mv $(NEWLIB_DIR) $(NEWLIB_DIR)-pirix
	$(UNPACK) $(NEWLIB_PACKAGE)
	diff -rupN $(NEWLIB_DIR)/ $(NEWLIB_DIR)-pirix/ > patch/newlib.patch || :

$(NEWLIB_DIR)/.patched: $(NEWLIB_DIR)
	patch -p0 < patch/newlib.patch
	cd $(NEWLIB_DIR)/newlib/libc/sys/ && autoconf
	mkdir -p $(NEWLIB_DIR)/newlib/libc/sys/pirix
	cp data/newlib/* $(NEWLIB_DIR)/newlib/libc/sys/pirix/
	cd $(NEWLIB_DIR)/newlib/libc/sys/ && autoconf
	cd $(NEWLIB_DIR)/newlib/libc/sys/pirix/ && autoreconf
	touch $(NEWLIB_DIR)/.patched

$(NEWLIB_DIR): $(NEWLIB_PACKAGE)
	$(UNPACK) $(NEWLIB_PACKAGE)

$(NEWLIB_PACKAGE):
	$(DL) $(NEWLIB_URL)/$(NEWLIB_PACKAGE)
