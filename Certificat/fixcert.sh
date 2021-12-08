#!/bin/bash

PACKAGE="ca-certificates"
VER="20210119"
BASEURL="http://deb.debian.org/debian/pool/main"
URL="$BASEURL/${PACKAGE:0:1}/$PACKAGE/${PACKAGE}_${VER}.tar.xz"
SHA256SUM="daa3afae563711c30a0586ddae4336e8e3974c2b627faaca404c4e0141b64665"
TMPNAME="certs-2021-10-13-13721-6200-16522-29438-11300"
SRCXZ="${PACKAGE}_$VER.tar.xz"
ROOTCERTS="rootcerts-$(date +%F).pem"
SYSTEMKEYCHAIN="/Library/Keychains/System.keychain"


echo "Checking SHA256: $SHA256SUM"
#if openssl sha -sha256 "$SRCXZ" | grep -q "= $SHA256SUM$"; then
#    echo "File OK"
#else
#    echo "Wrong file"
#    exit 1
#fi

sudo cp "$SYSTEMKEYCHAIN" "$SYSTEMKEYCHAIN-$(date +%F-%H%M%S)"

#mkdir "$TMPNAME"
cd "$TMPNAME"
#tar xf "../$SRCXZ"
#cd work
#cd mozilla
#make > /dev/null 2> /dev/null
for c in *.crt; do
    echo "$c"
    sudo security -v add-trusted-cert -d -r trustRoot -k "$SYSTEMKEYCHAIN" "$c"
done 

# rm -rf "$TMPNAME"

