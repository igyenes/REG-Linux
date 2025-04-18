ifeq ($(BR2_PACKAGE_SYSTEM_TARGET_S9GEN4),y)
# Tag: khadas-vims-linux-5.15-v1.7.3-release
S9GEN4_COMMON_DRIVERS_VERSION = f5a6346001a3584135ec72a77762ccd4ee1e31b1

S9GEN4_COMMON_DRIVERS_SOURCE = $(S9GEN4_COMMON_DRIVERS_VERSION).tar.gz
LINUX_HEADERS_EXTRA_DOWNLOADS += https://github.com/khadas/common_drivers/archive/$(S9GEN4_COMMON_DRIVERS_SOURCE)
LINUX_EXTRA_DOWNLOADS += https://github.com/khadas/common_drivers/archive/$(S9GEN4_COMMON_DRIVERS_SOURCE)
BR_NO_CHECK_HASH_FOR += $(S9GEN4_COMMON_DRIVERS_SOURCE)

define LINUX_INSTALL_S9GEN4_COMMON_DRIVERS
	rm -rf $(@D)/common_drivers
	mkdir -p $(@D)/common_drivers
	$(TAR) xf $(LINUX_DL_DIR)/$(S9GEN4_COMMON_DRIVERS_SOURCE) --strip-components=1 -C $(@D)/common_drivers
endef
LINUX_HEADERS_PRE_PATCH_HOOKS += LINUX_INSTALL_S9GEN4_COMMON_DRIVERS
LINUX_PRE_PATCH_HOOKS += LINUX_INSTALL_S9GEN4_COMMON_DRIVERS

endif
