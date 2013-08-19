#!/bin/bash

. ./config.sh

wget -c $BINUTILS_URL/$BINUTILS_PACKAGE
wget -c $GCC_URL/$GCC_PACKAGE
wget -c $GLIBC_URL -O $GLIBC_PACKAGE

tar xf $BINUTILS_PACKAGE
tar xf $GCC_PACKAGE

mkdir -p $GLIBC_DIR
tar xf $GLIBC_PACKAGE --strip-components=1 --directory=$GLIBC_DIR

echo "patching binutils"
patch -p0 < patch/binutils.patch
cp data/binutils/armelf_pirix.sh $BINUTILS_DIR/ld/emulparams/
cp data/binutils/i386elf_pirix.sh $BINUTILS_DIR/ld/emulparams/

echo "patching gcc"
patch -p0 < patch/gcc.patch
cp -r data/gcc/* $GCC_DIR/gcc/config/
