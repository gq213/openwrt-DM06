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
  DEPENDS:= +libpthread +libstdcpp
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
endef

$(eval $(call BuildPackage,platinum))
