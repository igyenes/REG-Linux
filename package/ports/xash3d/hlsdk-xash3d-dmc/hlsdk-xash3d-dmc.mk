################################################################################
#
# hlsdk-xash3d-dmc
#
################################################################################

# "dmc" branch on Jan 5, 2025
HLSDK_XASH3D_DMC_VERSION = 2eaaf125bebf9c1a72dc130b0bef55ce321d9ef7
HLSDK_XASH3D_DMC_BRANCH = dmc
HLSDK_XASH3D_DMC_SITE = $(call github,FWGS,hlsdk-portable,$(HLSDK_XASH3D_DMC_VERSION))
HLSDK_XASH3D_DMC_DEPENDENCIES = sdl2 sdl2_mixer sdl2_image sdl2_ttf libsodium
HLSDK_XASH3D_DMC_LICENSE = Half Life 1 SDK LICENSE
HLSDK_XASH3D_DMC_LICENSE_FILES = LICENSE

HLSDK_XASH3D_DMC_CONF_OPTS = -DGOLDSOURCE_SUPPORT=1 -DSERVER_LIBRARY_NAME=dmc -DGAMEDIR=dmc

ifeq ($(BR2_ARCH_IS_64),y)
HLSDK_XASH3D_DMC_CONF_OPTS += -D64BIT=ON
endif

define HLSDK_XASH3D_DMC_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/lib/xash3d/hlsdk/dmc/cl_dlls/ -D $(@D)/cl_dll/*.so
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/usr/lib/xash3d/hlsdk/dmc/dlls/ -D $(@D)/dlls/*.so
endef

$(eval $(cmake-package))
