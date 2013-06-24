#!/bin/bash

. ./config.sh

get $BINUTILS_URL/$BINUTILS_PACKAGE
get $GCC_URL/$GCC_PACKAGE

unpack $BINUTILS_PACKAGE
unpack $GCC_PACKAGE

log "patching binutils"
patch -p0 < patch/binutils.patch
cp data/binutils/armelf_pirix.sh $BINUTILS_DIR/ld/emulparams/
cp data/binutils/i386elf_pirix.sh $BINUTILS_DIR/ld/emulparams/

log "patching gcc"
patch -p0 < patch/gcc.patch
cp -r data/gcc/* $GCC_DIR/gcc/config/

mkdir -p $DESTDIR $BUILDDIR
