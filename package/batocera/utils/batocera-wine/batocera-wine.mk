################################################################################
#
# batocera wine
#
################################################################################

BATOCERA_WINE_VERSION = 1.1
BATOCERA_WINE_LICENSE = GPL
BATOCERA_WINE_SOURCE=

define BATOCERA_WINE_INSTALL_TARGET_CMDS
	install -m 0755 $(BR2_EXTERNAL_REGLINUX_PATH)/package/batocera/utils/batocera-wine/batocera-wine \
	    $(TARGET_DIR)/usr/bin/batocera-wine
	install -m 0755 $(BR2_EXTERNAL_REGLINUX_PATH)/package/batocera/utils/batocera-wine/batocera-wine-runners \
	    $(TARGET_DIR)/usr/bin/batocera-wine-runners
	ln -fs /userdata/system/99-nvidia.conf $(TARGET_DIR)/etc/X11/xorg.conf.d/99-nvidia.conf

	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_REGLINUX_PATH)/package/batocera/utils/batocera-wine/mugen.keys \
	    $(TARGET_DIR)/usr/share/evmapy
endef

$(eval $(generic-package))
