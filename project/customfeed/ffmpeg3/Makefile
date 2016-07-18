#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ffmpeg3
PKG_VERSION:=3.0

PKG_SOURCE:=ffmpeg-3.0.tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/ffmpeg-3.0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/ffmpeg3
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=ffmpeg3-mips
  DEPENDS:= +libpthread +zlib
endef

define Package/ffmpeg3/description
  This package contains full-featured FFmpeg shared libraries.
endef

FFMPEG_CONFIGURE:= \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) $(FPIC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	./configure \
	\
	--prefix="/usr" \
	\
	--enable-gpl \
	--enable-version3 \
	\
	--enable-shared \
	--enable-static \
	--enable-small \
	--disable-runtime-cpudetect \
	\
	--disable-programs \
	\
	--disable-doc \
	\
	--enable-cross-compile \
	--cross-prefix="$(TARGET_CROSS)" \
	--arch="$(ARCH)" \
	--target-os=linux \
	--pkg-config="pkg-config" \
	\
	--disable-asm \
	--disable-altivec \
	--disable-vsx \
	--disable-power8 \
	--disable-amd3dnow \
	--disable-amd3dnowext \
	--disable-mmx \
	--disable-mmxext \
	--disable-sse \
	--disable-sse2 \
	--disable-sse3 \
	--disable-ssse3 \
	--disable-sse4 \
	--disable-sse42 \
	--disable-avx \
	--disable-xop \
	--disable-fma3 \
	--disable-fma4 \
	--disable-avx2 \
	--disable-aesni \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armv6t2 \
	--disable-vfp \
	--disable-neon \
	--disable-inline-asm \
	--disable-yasm \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-msa \
	--disable-mipsfpu \
	--disable-mmi \
	\
	--disable-debug \
	\
	--disable-lzma \
	--enable-zlib \
	\
	--disable-d3d11va \
	--disable-dxva2 \
	--disable-vaapi \
	--disable-vda \
	--disable-vdpau \
	\
	--disable-avdevice \
	--disable-postproc \
	--disable-avfilter \
	--enable-pthreads \
	--enable-lzo \
	\
	--disable-encoders \
	--disable-decoders \
	--enable-decoder=ape \
	--enable-decoder=flac \
	--enable-decoder=wmav1 \
	--enable-decoder=wmav2 \
	--disable-hwaccels \
	--disable-muxers \
	--disable-demuxers \
	--enable-demuxer=ape \
	--enable-demuxer=flac \
	--disable-parsers \
	--enable-parser=flac \
	--disable-bsfs \
	--disable-protocols \
	--disable-indevs \
	--disable-outdevs \
	--disable-devices \
	--disable-filters

define Build/Configure
	( cd $(PKG_BUILD_DIR); $(FFMPEG_CONFIGURE) )
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/lib{avcodec,avformat,avutil,swresample,swscale} $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib{avcodec,avformat,avutil,swresample,swscale}.a $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/lib{avcodec,avformat,avutil,swresample,swscale}.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call BuildPackage,ffmpeg3))
