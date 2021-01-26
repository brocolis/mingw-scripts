#!/bin/sh

source ./include.sh
BDIR=build-mingw

cd $ROOT_DIR
mkdir $X_DESTDIR
cp -r binutils-$X_ARCH/* $X_DESTDIR/

cd $ROOT_DIR
[ ! -d $MINGW_W64_VERSION ] && unzip_file $MINGW_W64_VERSION.zip
[ -d $BDIR ] && rm -fr $BDIR
mkdir $BDIR
cd $BDIR

[ $X_ARCH == 'i686'   ] && DS='--disable-lib64'
[ $X_ARCH == 'x86_64' ] && DS='--disable-lib32'

../$MINGW_W64_VERSION/configure $ARCH_CONFIG \
--prefix=$ROOT_DIR/$X_DESTDIR/$Y_ARCH \
--with-sysroot=$ROOT_DIR/$X_DESTDIR/$Y_ARCH \
--enable-wildcard \
--with-libraries=winpthreads \
--enable-shared \
$DS

cd mingw-w64-headers
make $X_MAKE_JOBS all
make install

cd ..
make $X_MAKE_JOBS all
make install

cp $ROOT_DIR/$X_DESTDIR/$Y_ARCH/bin/libwinpthread-1.dll $ROOT_DIR/$X_DESTDIR/bin/
