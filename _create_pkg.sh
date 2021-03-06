#!/bin/bash

set -e

VER=$1

if [ "$VER" == "" ]; then
	echo "no version given"
	exit 1
fi

rm -fv PoslouchejRadia.zip

# correct version must already be included
sed -i "s#<version>.*</version>#<version>${VER}</version>#" src/install.xml

zip -r PoslouchejRadia.zip *.pm *.txt *.md *.xml HTML

CHK=$(sha1sum -b PoslouchejRadia.zip|awk '{print $1}')

sed -i "s#<sha>.*</sha>#<sha>${CHK}</sha>#" public.xml
sed -i "s#version=\"[0-9\.]*\" #version=\"${VER}\" #" public.xml
