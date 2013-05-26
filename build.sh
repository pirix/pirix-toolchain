#!/bin/bash

. ./config.sh

mkdir -p $BUILDDIR

pushd $BUILDDIR
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
    make install DESTDIR=$DESTDIR || exit 1
  popd

  mkdir -p gcc
  pushd gcc
    $BASEDIR/$GCC_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --disable-libssp \
      --enable-interwork \
      --enable-multilib \
      --enable-languages=c,c++ \
      --with-newlib \
      --with-system-zlib \
      --with-headers=$BASEDIR/$NEWLIB_DIR/newlib/libc/include \
      `if [[ $ARCH == arm ]]; then echo "--with-float=soft --with-fpu=vfp --disable-multilib"; fi`

    make $MAKEFLAGS all-gcc || exit 1
    make $MAKEFLAGS all-target-libgcc || exit 1
    make install-gcc DESTDIR=$DESTDIR || exit 1
    make install-target-libgcc DESTDIR=$DESTDIR || exit 1
    make all-target-libstdc++-v3 || exit 1
    make install-target-libstdc++-v3 DESTDIR=$DESTDIR || exit 1
  popd

  mkdir -p newlib
  pushd newlib
    $BASEDIR/$NEWLIB_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --enable-interwork \
      --with-gnu-ld \
      --with-gnu-as \
      --without-libgloss \
      --disable-libgloss \
      --disable-newlib-supplied-syscalls

    make $MAKEFLAGS all || exit 1
    make install DESTDIR=$DESTDIR || exit 1
  popd
popd
