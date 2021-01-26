#!/bin/sh

source ./include.sh
BDIR=build-mpc

cd $ROOT_DIR
[ ! -d $MPC_VERSION ] && untar_gzfile $MPC_VERSION.tar.gz
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

../$MPC_VERSION/configure \
--enable-static \
--disable-shared \
--prefix=$ROOT_DIR/mpc-$X_ARCH \
--with-gmp=$ROOT_DIR/gmp-$X_ARCH \
--with-mpfr=$ROOT_DIR/mpfr-$X_ARCH

make $X_MAKE_JOBS all "CFLAGS=-g0 -O3" "LDFLAGS=-s"
make install
