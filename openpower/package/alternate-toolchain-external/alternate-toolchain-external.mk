################################################################################
#
# alternate-toolchain-external
#
################################################################################
ALTERNATE_TOOLCHAIN_EXTERNAL_REDISTRIBUTE = NO
ALTERNATE_TOOLCHAIN_EXTERNAL_SITE =
ALTERNATE_TOOLCHAIN_EXTERNAL_SOURCE =
ALTERNATE_TOOLCHAIN_EXTERNAL_PROVIDES = alternate-toolchain
ALTERNATE_TOOLCHAIN_EXTERNAL_PATH = \
	$(call qstrip,$(BR2_ALTERNATE_TOOLCHAIN_EXTERNAL_PATH))/$(ALTERNATE_TOOLCHAIN_DIR)

define HOST_ALTERNATE_TOOLCHAIN_EXTERNAL_CONFIGURE_CMDS
	test -e $(ALTERNATE_TOOLCHAIN_EXTERNAL_PATH)
endef

define HOST_ALTERNATE_TOOLCHAIN_EXTERNAL_INSTALL_CMDS
	ln -snf $(ALTERNATE_TOOLCHAIN_EXTERNAL_PATH) $(HOST_DIR)/$(ALTERNATE_TOOLCHAIN_DIR)

endef

$(eval $(host-generic-package))
