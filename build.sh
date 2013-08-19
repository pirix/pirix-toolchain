#!/bin/bash

. ./config.sh

mkdir -p $BUILDDIR $DESTDIR

function build_binutils() {
  mkdir -p binutils
  pushd binutils
    $BASEDIR/$BINUTILS_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --enable-interwork \
      --disable-multilib \
      `if [[ $ARCH == arm ]]; then echo "--with-float=soft --with-fpu=vfp"; fi`

    make $MAKEFLAGS all || exit 1
    make install-strip DESTDIR=$DESTDIR || exit 1
  popd
}

function build_gcc() {
  mkdir -p gcc
  pushd gcc
    $BASEDIR/$GCC_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --disable-libssp \
      --enable-interwork \
      --disable-multilib \
      --enable-languages=c,c++ \
      --with-system-zlib \
      `if [[ $ARCH == arm ]]; then echo "--with-float=soft --with-fpu=vfp"; fi`

    make $MAKEFLAGS all-gcc || exit 1
    make $MAKEFLAGS all-target-libgcc || exit 1
    make install-strip-gcc DESTDIR=$DESTDIR || exit 1
    make install-strip-target-libgcc DESTDIR=$DESTDIR || exit 1
  popd
}

function build_glibc() {
  mkdir -p glibc
  pushd glibc
    $BASEDIR/$GLIBC_DIR/configure \
      --prefix=$PREFIX/$TARGET \
      --host=i386-elf-pirix \
      --disable-shared \
      --disable-nls \
      --with-__thread \
      --with-headers=$PIRIXDIR/include

    make $MAKEFLAGS || exit 1
    make install DESTDIR=$DESTDIR || exit 1
  popd
}

pushd $BUILDDIR
#  build_binutils
#  build_gcc
  build_glibc
popd
