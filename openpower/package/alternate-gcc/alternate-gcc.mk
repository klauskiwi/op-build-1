################################################################################
#
# alternate-gcc
#
################################################################################

#
# Loosely based on buildroot/package/gcc/*.mk, but most of the time, you'd want
# to check for the patches/configure options being used by the toolchain you are
# replacing/impersonating, and manually apply the exact same as a static 
# configuration here.
#

ALTERNATE_GCC_VERSION = $(call qstrip,$(BR2_ALTERNATE_GCC_VERSION))
ALTERNATE_GCC_SITE = $(BR2_GNU_MIRROR:/=)/gcc/gcc-$(ALTERNATE_GCC_VERSION)
ALTERNATE_GCC_SOURCE = gcc-$(ALTERNATE_GCC_VERSION).tar.xz

HOST_ALTERNATE_GCC_SUBDIR = build

HOST_ALTERNATE_GCC_DEPENDENCIES = \
	host-alternate-binutils \
	host-gmp \
	host-mpc \
	host-mpfr \
	$(BR_LIBC)

HOST_ALTERNATE_GCC_EXCLUDES = \
	libjava/* libgo/*

define HOST_ALTERNATE_GCC_CONFIGURE_SYMLINK
	mkdir -p $(@D)/build
	ln -sf ../configure $(@D)/build/configure
endef

define  HOST_ALTERNATE_GCC_CONFIGURE_CMDS
	(cd $(HOST_ALTERNATE_GCC_SRCDIR) && rm -rf config.cache; \
		CFLAGS_FOR_TARGET="$(TARGET_CFLAGS)" \
		CXXFLAGS_FOR_TARGET="$(TARGET_CXXFLAGS)" \
		CFLAGS="$(HOST_CFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)" \
		MAKEINFO=missing \
		./configure \
		--prefix="$(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)" \
		--enable-static \
		--target=powerpc64le-buildroot-linux-gnu \
		--with-sysroot=$(STAGING_DIR) \
		--enable-__cxa_atexit \
		--with-gnu-ld \
		--disable-libssp \
		--disable-multilib \
		--disable-decimal-float \
		--with-gmp=$(HOST_DIR) \
		--with-mpc=$(HOST_DIR) \
		--with-mpfr=$(HOST_DIR) \
		--disable-libquadmath \
		--enable-tls \
		--disable-libmudflap \
		--enable-threads \
		--without-isl \
		--without-cloog \
		--with-cpu=power8 \
		--with-long-double-128 \
		--enable-languages=c,c++ \
		--enable-shared \
		--disable-libgomp \
		--enable-targets=powerpc64-linux \
		--disable-libsanitizer \
		--with-build-time-tools=$(GNU_TARGET_NAME)/bin \
	)
endef

HOST_ALTERNATE_GCC_PRE_CONFIGURE_HOOKS += HOST_ALTERNATE_GCC_CONFIGURE_SYMLINK

$(eval $(host-autotools-package))

