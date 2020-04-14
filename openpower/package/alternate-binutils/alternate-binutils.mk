################################################################################
#
# alternate-binutils
#
################################################################################

#
# Loosely based on buildroot/package/binutils/binutils.mk, but most of the time,
# you'd want to check for the patches/configure options being used by the
# toolchain you are replacing/impersonating, and manually apply the exact same
# as a static configuration here.
#

ALTERNATE_BINUTILS_VERSION = $(call qstrip,$(BR2_ALTERNATE_BINUTILS_VERSION))
ALTERNATE_BINUTILS_SITE ?= $(BR2_GNU_MIRROR)/binutils
ALTERNATE_BINUTILS_SOURCE ?= binutils-$(ALTERNATE_BINUTILS_VERSION).tar.xz

ALTERNATE_BINUTILS_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)
ALTERNATE_BINUTILS_MAKE_OPTS = LIBS=$(TARGET_NLS_LIBS)

HOST_ALTERNATE_BINUTILS_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-doc \
	--disable-docs \
	--disable-documentation \
	--disable-debug \
	--with-xmlto=no \
	--with-fop=no \
	--disable-nls \
	--disable-dependency-tracking  \
	--disable-multilib \
	--disable-werror \
	--target=powerpc64le-buildroot-linux-gnu \
	--disable-shared \
	--enable-static \
	--enable-poison-system-directories \
	--disable-sim \
	--disable-gdb \
	--enable-targets=powerpc64-linux \
	--prefix="$(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)"

ALTERNATE_BINUTILS_MAKE_ENV = $(TARGET_CONFIGURE_ARGS)

ALTERNATE_BINUTILS_TOOLS = ar as ld ld.bfd nm objcopy objdump ranlib readelf strip
define HOST_ALTERNATE_BINUTILS_FIXUP_HARDLINKS
	$(foreach tool,$(ALTERNATE_BINUTILS_TOOLS),\
		rm -f $(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)/$(GNU_TARGET_NAME)/bin/$(tool) && \
		cp -a $(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)/bin/$(GNU_TARGET_NAME)-$(tool) \
			$(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)/$(GNU_TARGET_NAME)/bin/$(tool)
	)
endef
HOST_ALTERNATE_BINUTILS_POST_INSTALL_HOOKS += HOST_ALTERNATE_BINUTILS_FIXUP_HARDLINKS

$(eval $(host-autotools-package))

