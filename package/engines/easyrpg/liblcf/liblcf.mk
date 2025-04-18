################################################################################
#
# LIBLCF
#
################################################################################
# Version.: Release on Apr 7, 2025
LIBLCF_VERSION = 0.8.1
LIBLCF_DEPENDENCIES = expat icu inih
LIBLCF_LICENSE = MIT
LIBLCF_SITE = $(call github,EasyRPG,liblcf,$(LIBLCF_VERSION))

LIBLCF_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBLCF_CONF_OPTS += -DBUILD_SHARED_LIBS=ON
LIBLCF_CONF_OPTS += -DBUILD_STATIC_LIBS=ON

LIBLCF_CONF_ENV += LDFLAGS="-lpthread -fPIC" CFLAGS="-fPIC" CXXFLAGS="-fPIC"

# Should be set when the package cannot be built inside the source tree but needs a separate build directory.
LIBLCF_SUPPORTS_IN_SOURCE_BUILD = NO

# We need staging install for player cmake build
LIBLCF_INSTALL_STAGING = YES

$(eval $(cmake-package))
