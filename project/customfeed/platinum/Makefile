#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# updated to work with latest source from abrasive
#

include $(TOPDIR)/rules.mk

PKG_NAME:=platinum
PKG_VERSION:=1.0.5.13

PKG_SOURCE:=PlatinumKit-1-0-5-13_0ab854.tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/PlatinumKit-1-0-5-13_0ab854

include $(INCLUDE_DIR)/package.mk

define Package/platinum
  SECTION:=multimedia
  CATEGORY:=Multimedia
  DEPENDS:= +libpthread +libstdcpp \
	+gstreamer1-utils \
	+gstreamer1-libs \
	+gstreamer1-plugins-base +gst1-mod-alsa +gst1-mod-playback +gst1-mod-typefindfunctions +gst1-mod-volume \
	+gst1-mod-audioconvert +gst1-mod-audioresample +gst1-mod-ogg +gst1-mod-ivorbisdec \
	+gstreamer1-plugins-good +gst1-mod-audioparsers +gst1-mod-autodetect +gst1-mod-id3demux +gst1-mod-souphttpsrc \
	+gst1-mod-wavparse +gst1-mod-isomp4 +gst1-mod-icydemux +gst1-mod-flac \
	+gstreamer1-plugins-ugly +gst1-mod-mad +gst1-mod-asf \
	+gstreamer1-plugins-bad +gst1-mod-faad +gst1-mod-mms \
	+gst1-plugins-wma
  TITLE:=A framework for upnp applications
endef

define Package/platinum/description
  The Platinum Kit contains all the software packages necessary to build the 
  Platinum framework and sample applications.
endef

define Build/Configure
	cd $(PKG_BUILD_DIR)/Platinum; scons target=mipsel-openwrt-linux build_config=Release
endef

define Build/Compile

endef

define Package/platinum/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Platinum/Targets/mipsel-openwrt-linux/Release/MediaRendererTest $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Platinum/Targets/mipsel-openwrt-linux/Release/FileMediaServerTest $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc
	$(CP) ./files/dlna.sh $(1)/etc/
endef

$(eval $(call BuildPackage,platinum))
