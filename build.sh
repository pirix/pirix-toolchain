#!/bin/bash

. ./config.sh

pushd $BUILDDIR
<<COMMENT
  mkdir -p binutils
  pushd binutils
    $BASEDIR/$BINUTILS_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --enable-interwork \
      --enable-multilib \
      --with-float=soft
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
      --enable-languages=c \
      --with-newlib \
      --with-headers=../../$NEWLIB_DIR/newlib/libc/include \
      --with-float=soft

    make $MAKEFLAGS all-gcc || exit 1
    make $MAKEFLAGS all-target-libgcc || exit 1
    make install-gcc DESTDIR=$DESTDIR || exit 1
    make install-target-libgcc DESTDIR=$DESTDIR || exit 1
  popd

COMMENT

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
      --disable-newlib-supplied-syscalls \
      --with-float=soft

    make $MAKEFLAGS all || exit 1
    make install DESTDIR=$DESTDIR || exit 1
  popd
popd
