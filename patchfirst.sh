#!/bin/bash
dir=`pwd`

LASTLINE=$(tail -1 $dir/feeds.conf.default)
WRITELINE="src-link customfeed $dir/project/customfeed"
#echo $LASTLINE
#echo $WRITELINE
if [ "$LASTLINE" != "$WRITELINE" ]
then
	echo "modify customfeed path..."
	sed -i '$'d $dir/feeds.conf.default
	echo "$WRITELINE" >> $dir/feeds.conf.default
fi

if [ ! -d $dir/feeds ]
then
	echo "not found $dir/feeds, please run (./scripts/feeds update -a) first!!!"
	exit -1
fi

echo "patching..."

src_dir="$dir/target/linux/ramips/gq213-patches"
src_file=(
"$src_dir/shairport-sync/001-modify_snd_mmap.patch"
"$src_dir/shairport-sync/shairport-sync.init"
"$src_dir/gst1-plugins-good/Makefile"
"$src_dir/gst1-plugins-base/100-modify_snd_mmap.patch"
"$src_dir/gst1-plugins-base/Makefile"
"$src_dir/gst1-plugins-bad/Makefile"
"$src_dir/faad2/001-modify_mult.patch"
"$src_dir/luci/wifi.lua"
"$src_dir/luci/wifi_add.lua"
"$src_dir/luci/wifi_overview.htm"
"$src_dir/luci/index.htm"
"$src_dir/luci/network.lua"
)

dst_dir=(
"$dir/feeds/packages/sound/shairport-sync/patches"
"$dir/feeds/packages/sound/shairport-sync/files"
"$dir/feeds/packages/multimedia/gst1-plugins-good"
"$dir/feeds/packages/multimedia/gst1-plugins-base/patches"
"$dir/feeds/packages/multimedia/gst1-plugins-base"
"$dir/feeds/packages/multimedia/gst1-plugins-bad"
"$dir/feeds/packages/libs/faad2/patches"
"$dir/feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_network"
"$dir/feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_network"
"$dir/feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_network"
"$dir/feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status"
"$dir/feeds/luci/modules/luci-base/luasrc/model"
)
dst_file=(
"/001-modify_snd_mmap.patch"
"/shairport-sync.init"
"/Makefile"
"/100-modify_snd_mmap.patch"
"/Makefile"
"/Makefile"
"/001-modify_mult.patch"
"/wifi.lua"
"/wifi_add.lua"
"/wifi_overview.htm"
"/index.htm"
"/network.lua"
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
	if cmp -s ${src_file[$i]} $files
	then
		echo "same"
	else
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
