#
#
#

#
# ROOT_DIR: Build the toolchain into this location
# export ROOT_DIR=/c/temp should work
export ROOT_DIR=/build/mingw

# Place sources packages (gcc-8.4.0.tar.xz, mingw-w64-v7.0.0.zip, etc) here
export SOURCES_DIR=/build/sources

# Uncomment one
# export X_ARCH=i686
# export X_ARCH=x86_64

# No need to modify this
export Y_ARCH=$X_ARCH-w64-mingw32
export ARCH_CONFIG="--build=$Y_ARCH --host=$Y_ARCH --target=$Y_ARCH"
# export X_DESTDIR=dest
export X_DESTDIR=dest-$X_ARCH

# PATH to existing MinGW plus /usr/bin:/c/Windows/System32:/c/Windows
export PATH="/c/MinGW10/bin:/usr/bin:/c/Windows/System32:/c/Windows"

# Number of `make` jobs: -j2, etc
export X_MAKE_JOBS="-j$NUMBER_OF_PROCESSORS -O"

# Uncomment one
# export GCC_VERSION=gcc-8.4.0
# export GCC_VERSION=gcc-9.3.0
# export GCC_VERSION=gcc-10.2.0

export ISL_VERSION=isl-0.18
export GMP_VERSION=gmp-6.2.1
export MPFR_VERSION=mpfr-4.1.0
export MPC_VERSION=mpc-1.2.1
export BINUTILS_VERSION=binutils-2.35.1
export MINGW_W64_VERSION=mingw-w64-v7.0.0

set -eux

function untar_file {
    tar --extract --directory=$ROOT_DIR --file=$SOURCES_DIR/$*
}

function untar_xzfile {
    tar --extract --xz --directory=$ROOT_DIR --file=$SOURCES_DIR/$*
}

function untar_bz2file {
    tar --extract --bzip2 --directory=$ROOT_DIR --file=$SOURCES_DIR/$*
}

function untar_gzfile {
    tar --extract --gzip --directory=$ROOT_DIR --file=$SOURCES_DIR/$*
}

function unzip_file {
    unzip $SOURCES_DIR/$*
}
