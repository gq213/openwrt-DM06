#!/bin/bash
dir=`pwd`

if [ ! -d $dir/feeds ]
then
	echo "not found $dir/feeds, please run (./scripts/feeds update -a) first!!!"
	exit -1
fi

echo "patching..."

src_dir="$dir/target/linux/ramips/gq213-patches"
src_file=(
"$src_dir/shairport-sync/001-modify_snd_mmap.patch"
"$src_dir/gst1-plugins-good/Makefile"
"$src_dir/gst1-plugins-base/100-modify_snd_mmap.patch"
"$src_dir/gst1-plugins-base/Makefile"
"$src_dir/gst1-plugins-bad/Makefile"
"$src_dir/faad2/001-modify_mult.patch"
)

dst_dir=(
"$dir/feeds/packages/sound/shairport-sync/patches"
"$dir/feeds/packages/multimedia/gst1-plugins-good"
"$dir/feeds/packages/multimedia/gst1-plugins-base/patches"
"$dir/feeds/packages/multimedia/gst1-plugins-base"
"$dir/feeds/packages/multimedia/gst1-plugins-bad"
"$dir/feeds/packages/libs/faad2/patches"
)
dst_file=(
"/001-modify_snd_mmap.patch"
"/Makefile"
"/100-modify_snd_mmap.patch"
"/Makefile"
"/Makefile"
"/001-modify_mult.patch"
)

for ((i=0; i<${#src_file[@]}; i++))
do
	files=${dst_dir[$i]}${dst_file[$i]}
#	echo ${src_file[$i]}
#	echo ${dst_dir[$i]}
#	echo ${dst_file[$i]}
	echo $files

if [ -f $files ]; then
	echo "compare..."
	if [ ${src_file[$i]} -nt $files ]; then
		echo "overwrite..."
		cp -a ${src_file[$i]} $files
	fi
else
	if [ ! -d ${dst_dir[$i]} ]; then
		echo "creat dir..."
		mkdir -p ${dst_dir[$i]}
	fi

	echo "copy..."
	cp -a ${src_file[$i]} $files
fi

done

echo "done,exit..."
