################################################################################
#
# vpinball
#
################################################################################
VPINBALL_VERSION = v10.8.0-2051-28dd6c3
VPINBALL_SITE = $(call github,vpinball,vpinball,$(VPINBALL_VERSION))
VPINBALL_LICENSE = GPLv3+
VPINBALL_LICENSE_FILES = LICENSE
VPINBALL_DEPENDENCIES = host-libcurl
VPINBALL_DEPENDENCIES += libfreeimage libpinmame libaltsound libdmdutil libdof
VPINBALL_DEPENDENCIES += sdl2 sdl2_image sdl2_ttf ffmpeg
VPINBALL_EXTRACT_DEPENDENCIES = host-dos2unix
VPINBALL_SUPPORTS_IN_SOURCE_BUILD = NO

# handle supported target platforms
ifeq ($(BR2_PACKAGE_SYSTEM_TARGET_SM8250)$(BR2_PACKAGE_SYSTEM_TARGET_SM8550)$(BR2_PACKAGE_SYSTEM_TARGET_RK3588)$(BR2_PACKAGE_SYSTEM_TARGET_MT8395)$(BR2_PACKAGE_SYSTEM_TARGET_ASAHI),y)
    SOURCE = CMakeLists_gl-linux-aarch64.txt
    SOURCE_DIR = linux-aarch64
    ARCH = aarch64
    VPINBALL_CONF_OPTS += "-DBUILD_RK3588=ON"
endif

ifeq ($(BR2_PACKAGE_SYSTEM_TARGET_BCM2711)$(BR2_PACKAGE_SYSTEM_TARGET_BCM2712),y)
    SOURCE = CMakeLists_gl-linux-aarch64.txt
    SOURCE_DIR = linux-aarch64
    ARCH = aarch64
    VPINBALL_CONF_OPTS += "-DBUILD_RPI=ON"
endif

ifeq ($(BR2_PACKAGE_SYSTEM_TARGET_X86_64_ANY),y)
    SOURCE = CMakeLists_gl-linux-x64.txt
    SOURCE_DIR = linux-x64
    ARCH = x86_64
endif

define VPINBALL_FIX_LINE_ENDINGS
    # Normalize line endings
    cd $(@D) && find . -type f -print0 | xargs -0 $(HOST_DIR)/bin/dos2unix
endef

define VPINBALL_CUSTOM_CMAKE
    ## derived from standalone/linux/external.sh ##
    # copy linux x64
    cp $(@D)/standalone/cmake/$(SOURCE) $(@D)/CMakeLists.txt
    $(SED) 's:$${CMAKE_SOURCE_DIR}/standalone/$(SOURCE_DIR)/external/include:$(STAGING_DIR)/usr/include/:g' $(@D)/CMakeLists.txt
    $(SED) 's:$${CMAKE_SOURCE_DIR}/standalone/$(SOURCE_DIR)/external/lib/:$(STAGING_DIR)/usr/lib/:g' $(@D)/CMakeLists.txt
    # make tmp
    rm -rf $(@D)/tmp
    mkdir $(@D)/tmp
    # bass24 - this is ugly...
    cd $(@D)/tmp && $(HOST_DIR)/bin/curl -s https://www.un4seen.com/files/bass24-linux.zip -o bass.zip
    cd $(@D)/tmp && unzip -x bass.zip
    $(INSTALL) -D -m 0755 $(@D)/tmp/libs/$(ARCH)/libbass.so $(STAGING_DIR)/usr/lib
    $(INSTALL) -D -m 0755 $(@D)/tmp/libs/$(ARCH)/libbass.so $(TARGET_DIR)/usr/lib
endef

VPINBALL_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
VPINBALL_CONF_OPTS += -DBUILD_SHARED_LIBS=OFF
VPINBALL_CONF_OPTS += -DPOST_BUILD_COPY_EXT_LIBS=OFF

define VPINBALL_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/bin/vpinball
    # strip binary
    $(TARGET_STRIP) $(@D)/buildroot-build/VPinballX_GL
    # install binary
    $(INSTALL) -D -m 0755 $(@D)/buildroot-build/VPinballX_GL \
        $(TARGET_DIR)/usr/bin/vpinball
    # copy folders
    cp -R $(@D)/buildroot-build/flexdmd $(TARGET_DIR)/usr/bin/vpinball/
    cp -R $(@D)/buildroot-build/assets $(TARGET_DIR)/usr/bin/vpinball/
    cp -R $(@D)/buildroot-build/scripts $(TARGET_DIR)/usr/bin/vpinball/
    cp -R $(@D)/buildroot-build/shader10.8.0 $(TARGET_DIR)/usr/bin/vpinball/
endef

define VPINBALL_EVMAPY
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_REGLINUX_PATH)/package/engines/vpinball/vpinball.keys \
	    $(TARGET_DIR)/usr/share/evmapy
endef

VPINBALL_PRE_CONFIGURE_HOOKS += VPINBALL_CUSTOM_CMAKE

VPINBALL_POST_EXTRACT_HOOKS += VPINBALL_FIX_LINE_ENDINGS
VPINBALL_POST_INSTALL_TARGET_HOOKS += VPINBALL_EVMAPY

$(eval $(cmake-package))
