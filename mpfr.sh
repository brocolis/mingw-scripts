#!/bin/sh

source ./include.sh
BDIR=build-mpfr

cd $ROOT_DIR
[ ! -d $MPFR_VERSION ] && untar_xzfile $MPFR_VERSION.tar.xz
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

../$MPFR_VERSION/configure \
--prefix=$ROOT_DIR/mpfr-$X_ARCH \
--with-gmp=$ROOT_DIR/gmp-$X_ARCH \
--enable-static \
--disable-shared

make $X_MAKE_JOBS all "CFLAGS=-g0 -O3" "LDFLAGS=-s"
make install
