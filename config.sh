ARCH=i386
TARGET=$ARCH-elf-pirix
PREFIX=/opt/pirix-toolchain
BASEDIR=`pwd`
BUILDDIR=$BASEDIR/build
PIRIXDIR=$BASEDIR/../pirix
DESTDIR=$BASEDIR/dist

PATH=$DESTDIR/$PREFIX/bin:$PATH
MAKEFLAGS="-j 4"

BINUTILS_VERSION=2.23.2
BINUTILS_URL=http://ftp.gnu.org/gnu/binutils
BINUTILS_DIR=binutils-$BINUTILS_VERSION
BINUTILS_PACKAGE=$BINUTILS_DIR.tar.gz

GCC_VERSION=4.8.0
GCC_URL=http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION
GCC_DIR=gcc-$GCC_VERSION
GCC_PACKAGE=gcc-$GCC_VERSION.tar.gz

GLIBC_URL=https://github.com/pirix/glibc-pirix/tarball/pirix
GLIBC_PACKAGE=glibc-pirix.tar.gz
GLIBC_DIR=glibc-pirix
