#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gst1-plugins-wma
PKG_VERSION:=1.4.5

PKG_SOURCE:=gst-plugins-wma.tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/gst-plugins-wma

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/gst1-plugins-wma
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=wma decoder
  DEPENDS:= +libgstreamer1 +libgst1controller +libgst1audio
endef

define Package/gst1-plugins-wma/description
  fixed point wma decoder
endef

EXTRA_LDFLAGS+= \
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

GST_WMA_CONFIGURE:= \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	./configure --host="$(GNU_TARGET_NAME)"

define Build/Configure
	cd $(PKG_BUILD_DIR); ./autogen.sh; $(GST_WMA_CONFIGURE)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/gst1-plugins-wma/install
	$(INSTALL_DIR) $(1)/usr/lib/gstreamer-1.0
	$(CP) $(PKG_INSTALL_DIR)/usr/local/lib/gstreamer-1.0/libgstwma.so $(1)/usr/lib/gstreamer-1.0/
endef

$(eval $(call BuildPackage,gst1-plugins-wma))
