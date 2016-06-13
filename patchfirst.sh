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

cp -rf $dir/target/linux/ramips/gq213-patches/gst1-plugins-base/*.patch $dir/feeds/packages/multimedia/gst1-plugins-base/patches
cp -rf $dir/target/linux/ramips/gq213-patches/gst1-plugins-base/Makefile $dir/feeds/packages/multimedia/gst1-plugins-base

cp -rf $dir/target/linux/ramips/gq213-patches/gst1-plugins-bad/* $dir/feeds/packages/multimedia/gst1-plugins-bad

if [ ! -d $dir/feeds/packages/libs/faad2/patches ]
then
	echo "creat faad2/patches!!!"
	mkdir -p $dir/feeds/packages/libs/faad2/patches
fi
cp -rf $dir/target/linux/ramips/gq213-patches/faad2/* $dir/feeds/packages/libs/faad2/patches

echo "done,exit..."
