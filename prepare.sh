. ./config.sh

get $BINUTILS_URL/$BINUTILS_PACKAGE
get $GCC_URL/$GCC_PACKAGE
get $NEWLIB_URL/$NEWLIB_PACKAGE

unpack $BINUTILS_PACKAGE
unpack $GCC_PACKAGE
unpack $NEWLIB_PACKAGE

log "patching binutils"
patch -p0 < patch/binutils.patch
cp data/binutils/armelf_pirix.sh $BINUTILS_DIR/ld/emulparams/

log "patching gcc"
patch -p0 < patch/gcc.patch
cp data/gcc/pirix.h $GCC_DIR/gcc/config/

log "patching newlib"
patch -p0 < patch/newlib.patch
pushd $NEWLIB_DIR/newlib/libc/sys/
  autoconf
  mkdir -p pirix
  cp $(dirs +1)/data/newlib/* pirix/
  autoconf
  cd pirix/ && autoreconf
popd

mkdir -p $DESTDIR $BUILDDIR
