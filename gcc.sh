#!/bin/sh

source ./include.sh
BDIR=build-gcc

cd $ROOT_DIR
[ ! -d $GCC_VERSION ] && untar_xzfile $GCC_VERSION.tar.xz
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

set +x
echo "==== Please run the following commands in Windows Command Prompt ===="
echo "cd $ROOT_DIR"
[ $X_ARCH == 'x86_64' ] && echo "mklink /J ${X_DESTDIR}\\${Y_ARCH}\lib64 ${X_DESTDIR}\\${Y_ARCH}\lib"
echo "mklink /J ${X_DESTDIR}\mingw ${X_DESTDIR}\\${Y_ARCH}"
echo "mklink /J ${GCC_VERSION}\gcc\winsup ${X_DESTDIR}"
read -p "Press any key to resume ..."
set -x

../$GCC_VERSION/configure --enable-languages=c,c++,fortran $ARCH_CONFIG \
--enable-shared \
--disable-multilib \
--disable-bootstrap \
--prefix=$ROOT_DIR/$X_DESTDIR \
--with-sysroot=$ROOT_DIR/$X_DESTDIR \
--disable-libstdcxx-pch \
--disable-libstdcxx-verbose \
--disable-nls \
--disable-win32-registry \
--enable-threads=posix \
--enable-libgomp \
--with-gmp=$ROOT_DIR/gmp-$X_ARCH \
--with-mpfr=$ROOT_DIR/mpfr-$X_ARCH \
--with-mpc=$ROOT_DIR/mpc-$X_ARCH \
--with-isl=$ROOT_DIR/isl-$X_ARCH

make $X_MAKE_JOBS "CFLAGS=-g0 -O2" "CXXFLAGS=-g0 -O2"
make install-strip

cd $ROOT_DIR/$X_DESTDIR
find -name "*.la" -type f -print -exec rm {} ";"

set +x
echo "==== You can now remove the junctions points ===="
echo "cd $ROOT_DIR"
[ $X_ARCH == 'x86_64' ] && echo "rmdir ${X_DESTDIR}\\${Y_ARCH}\lib64"
echo "rmdir ${X_DESTDIR}\mingw"
echo "rmdir ${GCC_VERSION}\gcc\winsup"
