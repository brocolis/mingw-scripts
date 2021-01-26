#!/bin/sh

source ./include.sh
BDIR=build-isl

cd $ROOT_DIR
[ ! -d $ISL_VERSION ] && untar_bz2file $ISL_VERSION.tar.bz2
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

../$ISL_VERSION/configure \
--prefix=$ROOT_DIR/isl-$X_ARCH \
--with-gmp-prefix=$ROOT_DIR/gmp-$X_ARCH

make $X_MAKE_JOBS all "CFLAGS=-g0 -O3" "LDFLAGS=-s"
make install
