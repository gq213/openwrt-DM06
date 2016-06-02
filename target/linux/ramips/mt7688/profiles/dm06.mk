#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/DM06-profile
	NAME:=dm06 iot board
	PACKAGES:=\
		kmod-usb-core kmod-usb2 kmod-usb-ohci \
		luci
endef

define Profile/DM06-profile/Description
	dm06 base packages.
endef
$(eval $(call Profile,DM06-profile))
