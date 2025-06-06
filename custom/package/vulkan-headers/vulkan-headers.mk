################################################################################
#
# vulkan-headers
#
################################################################################
# reglinux - bump
VULKAN_HEADERS_VERSION = v1.4.304
VULKAN_HEADERS_SITE = $(call github,KhronosGroup,Vulkan-Headers,$(VULKAN_HEADERS_VERSION))
VULKAN_HEADERS_LICENSE = Apache-2.0
VULKAN_HEADERS_LICENSE_FILES = LICENSE.txt
VULKAN_HEADERS_INSTALL_STAGING = YES

# reglinux
ifeq ($(BR2_PACKAGE_MESA3D),y)
VULKAN_HEADERS_DEPENDENCIES += mesa3d
endif

$(eval $(cmake-package))
