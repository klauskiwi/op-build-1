################################################################################
#
# alternate-toolchain-internal
#
################################################################################

ALTERNATE_TOOLCHAIN_INTERNAL_SOURCE =
ALTERNATE_TOOLCHAIN_INTERNAL_SITE =

ALTERNATE_TOOLCHAIN_INTERNAL_PROVIDES = alternate-toolchain
HOST_ALTERNATE_TOOLCHAIN_INTERNAL_DEPENDENCIES = host-alternate-gcc

$(eval $(host-generic-package))
