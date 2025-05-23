################################################################################
#
# sonic2013
#
################################################################################
# Version: Commits on Apr 9, 2025
SONIC2013_VERSION = 1f1b934c3b277625a1037c510e23abd0c5b054ce
SONIC2013_SITE = https://github.com/RSDKModding/RSDKv4-Decompilation.git
SONIC2013_SITE_METHOD = git
SONIC2013_GIT_SUBMODULES = YES
SONIC2013_LICENSE = Custom

SONIC2013_DEPENDENCIES = sdl2 libogg libvorbis

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
    SONIC2013_DEPENDENCIES += libglew libglu
endif

define SONIC2013_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) -f Makefile VERBOSE=1
endef

define SONIC2013_INSTALL_TARGET_CMDS
	$(TARGET_STRIP) $(@D)/bin/RSDKv4
	$(INSTALL) -D -m 0755 $(@D)/bin/RSDKv4 $(TARGET_DIR)/usr/bin/sonic2013
endef

define SONIC2013_POST_PROCESS
	mkdir -p $(TARGET_DIR)/usr/share/evmapy $(TARGET_DIR)/usr/share/sonic2013
	cp -f $(BR2_EXTERNAL_REGLINUX_PATH)/package/ports/sonic2013/sonicretro.sonic2013.keys \
	    $(TARGET_DIR)/usr/share/evmapy
endef

SONIC2013_POST_INSTALL_TARGET_HOOKS += SONIC2013_POST_PROCESS

$(eval $(generic-package))
