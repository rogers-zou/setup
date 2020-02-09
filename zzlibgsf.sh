#!/bin/bash
# install libgsf
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="libgsf"
TYPE=".tar.xz"
FILE="$NAME$TYPE"
DOWNLOADURL="http://ftp.gnome.org/pub/gnome/sources/libgsf/1.14/libgsf-1.14.46.tar.xz"
echo $NAME will be installed in "$ROOTDIR"

mkdir -p "$ROOTDIR/downloads"
cd "$ROOTDIR"

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

cd src/$NAME

./configure --prefix="$ROOTDIR"
make -j"$(nproc)" && make install

echo $NAME installed on "$ROOTDIR"
