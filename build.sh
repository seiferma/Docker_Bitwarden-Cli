#!/bin/bash

BINARY=$1
DST=$2

mkdir -p "$DST/usr/local/bin/"
cp "$BINARY" "$DST/usr/local/bin/"

LIBS=$(ldd "$BINARY" | grep /lib/ | sed 's#.*\(/lib/[^ ]\+\).*#\1#g')
for LIB in $LIBS; do
    cp --parents "$LIB" "$DST"
done
mkdir -p "$DST/etc/ssl/certs"
cp /etc/ssl/certs/ca-certificates.crt "$DST/etc/ssl/certs/ca-certificates.crt"