#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mplayer
PKG_VERSION:=1.3.0

PKG_SOURCE:=MPlayer-1.3.0.tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/MPlayer-1.3.0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/mplayer
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=mplayer-mips
  DEPENDS:= +ffmpeg3 +libmad +alsa-lib +libncurses +libgnutls +libfaad2 +libogg +libvorbisidec +zlib
endef

define Package/mplayer/description
  audio player
endef

CONFIGURE_ARGS += \
\
--disable-runtime-cpudetection \
--enable-cross-compile \
--yasm='' \
\
--disable-mencoder \
--disable-tv \
--disable-ftp \
--disable-unrarexec \
\
--disable-ffmpeg_a \
--disable-xanim \
--disable-libopus \
--disable-libmpeg2 \
--disable-liblzo \
--disable-theora \
--disable-libvorbis \
--disable-jpeg \
--disable-png \
\
--disable-dvb \
--disable-v4l2 \
--disable-yuv4mpeg \
--disable-md5sum \
--disable-pnm \
--disable-tga \
\
--disable-ossaudio

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/mplayer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/mplayer $(1)/usr/bin/
endef

$(eval $(call BuildPackage,mplayer))
