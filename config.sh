TARGET=arm-elf-pirix
PREFIX=/usr/local/cross
DESTDIR=`pwd`/cross
BUILDDIR=`pwd`/build
BASEDIR=`pwd`
PATH=$DESTDIR$PREFIX/bin:$PATH
MAKEFLAGS="-j 4"

BINUTILS_VERSION=2.22
BINUTILS_URL=http://ftp.gnu.org/gnu/binutils
BINUTILS_DIR=binutils-$BINUTILS_VERSION
BINUTILS_PACKAGE=$BINUTILS_DIR.tar.gz

GCC_VERSION=4.6.3
GCC_URL=http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION
GCC_DIR=gcc-$GCC_VERSION
GCC_PACKAGE=gcc-core-$GCC_VERSION.tar.gz

NEWLIB_VERSION=2.0.0
NEWLIB_URL=ftp://sourceware.org/pub/newlib
NEWLIB_DIR=newlib-$NEWLIB_VERSION
NEWLIB_PACKAGE=$NEWLIB_DIR.tar.gz

function log() {
    echo $1 "..."
}

function get() {
    wget -c $1
}

function unpack() {
    tar xf $1
}
