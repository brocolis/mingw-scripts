#!/bin/sh

source ./include.sh
BDIR=build-binutils

cd $ROOT_DIR
[ ! -d $BINUTILS_VERSION ] && untar_xzfile $BINUTILS_VERSION.tar.xz
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

../$BINUTILS_VERSION/configure $ARCH_CONFIG \
--disable-nls \
--disable-shared \
--disable-multilib \
--prefix=$ROOT_DIR/binutils-$X_ARCH \
--with-gmp=$ROOT_DIR/gmp-$X_ARCH \
--with-mpfr=$ROOT_DIR/mpfr-$X_ARCH \
--with-mpc=$ROOT_DIR/mpc-$X_ARCH \
--with-isl=$ROOT_DIR/isl-$X_ARCH

make $X_MAKE_JOBS all "CFLAGS=-g0 -O3"
make install
