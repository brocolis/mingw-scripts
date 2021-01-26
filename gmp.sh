#!/bin/sh

source ./include.sh
BDIR=build-gmp

cd $ROOT_DIR
[ ! -d $GMP_VERSION ] && untar_xzfile $GMP_VERSION.tar.xz
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

../$GMP_VERSION/configure \
--prefix=$ROOT_DIR/gmp-$X_ARCH \
--disable-shared \
--enable-static

make $X_MAKE_JOBS all "CFLAGS=-g0 -O3" "LDFLAGS=-s"
make install
