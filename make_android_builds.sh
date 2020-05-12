#!/bin/bash

### Builds libffi for all android targets.

# Arguments:
# $1: Android standalone toolchains root folder

# arm
sh make_libffi.sh "$1/arm-linux-androideabi" "arm"
# arm64
sh make_libffi.sh "$1/aarch64" "aarch64"
# x86
sh make_libffi.sh "$1/x86" "x86"
# x86_64
sh make_libffi.sh "$1/x86_64" "x86_64"