#!/bin/bash

### Builds libffi as a shared / static library for a specific android target.

# Arguments:
# $1: Toolchain path (ex: ~/Stuff//standalone-toolchains/x86)
# $2: Target architecture (x86, x86_64, arm, aarch64)

TOOLCHAIN="$1"
ARCH="$2"

case $ARCH in
    arm)
        DEST_CPU="$ARCH"
        SUFFIX="$ARCH-linux-androideabi"
        PLATFORM="arm-unknown-linux-androideabi"
        ;;
    aarch64)
        DEST_CPU="$ARCH"
        SUFFIX="$ARCH-linux-android"
        PLATFORM="aarch64-unknown-linux-android"
        ;;
    x86)
        DEST_CPU="ia32"
        SUFFIX="i686-linux-android"
        PLATFORM="i686-pc-linux-android"
        ;;
    x86_64)
        DEST_CPU="x64"
        SUFFIX="$ARCH-linux-android"
        PLATFORM="x86_64-pc-linux-android"
        ;;
    *)
        echo "Unsupported architecture provided: $ARCH"
        exit 1
        ;;
esac

export PATH=$TOOLCHAIN/bin/:$PATH
export AR=$SUFFIX-ar
export AS=$SUFFIX-clang
export CC=$SUFFIX-clang
export CXX=$SUFFIX-clang++
export LD=$SUFFIX-ld
export STRIP=$SUFFIX-strip
export CFLAGS="-fPIC"
export LDFLAGS="-pie"

cd deps/libffi
./autogen.sh
./configure --host=$SUFFIX --prefix=`pwd`/build/android/$ARCH && make install
mkdir -p config/android/$ARCH
cp $PLATFORM/include/ffi.h $PLATFORM/include/ffitarget.h $PLATFORM/fficonfig.h config/android/$ARCH
make clean
rm -Rf $PLATFORM