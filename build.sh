. ./config.sh

pushd $BUILDDIR
  mkdir -p binutils
  pushd binutils
    $BASEDIR/$BINUTILS_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --enable-interwork \
      --enable-multilib \
      --with-float=soft
    make all
    make install DESTDIR=$DESTDIR
  popd

  mkdir -p gcc
  pushd gcc
    $BASEDIR/$GCC_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --disable-nls \
      --disable-shared \
      --disable-libssp \
      --enable-interwork \
      --enable-multilib \
      --enable-languages=c \
      --with-newlib \
      --with-headers=../../$NEWLIB_DIR/newlib/libc/include \
      --with-float=soft

    make all-gcc
    make all-target-libgcc
    make install-gcc DESTDIR=$DESTDIR
    make install-target-libgcc DESTDIR=$DESTDIR
  popd

  mkdir -p newlib
  pushd newlib
    $BASEDIR/$NEWLIB_DIR/configure \
      --prefix=$PREFIX \
      --target=$TARGET \
      --enable-interwork \
      --with-gnu-ld \
      --with-gnu-as \
      --with-float=soft

    make all
    make install DESTDIR=$DESTDIR
  popd
popd
