#!/bin/bash
dir=`pwd`

if [ ! -d $dir/feeds ]
then
	echo "not found $dir/feeds, please run (./scripts/feeds update -a) first!!!"
	exit -1
fi

echo "patching..."

if [ ! -d $dir/feeds/packages/sound/shairport-sync/patches ]
then
	echo "creat shairport-sync/patches!!!"
	mkdir -p $dir/feeds/packages/sound/shairport-sync/patches
fi
cp -rf $dir/target/linux/ramips/gq213-patches/shairport-sync/* $dir/feeds/packages/sound/shairport-sync/patches

cp -rf $dir/target/linux/ramips/gq213-patches/gst1-plugins-good/* $dir/feeds/packages/multimedia/gst1-plugins-good

echo "done,exit..."
