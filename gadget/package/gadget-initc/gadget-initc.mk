################################################################################
#
# gadget-initc
#
################################################################################

GADGET_INITC_VERSION = 9e638e23a9bc0bec7da565e8f87db3df91ca9655
GADGET_INITC_SITE = ssh://git@ntc.githost.io/nextthingco/gadgetcli
GADGET_INITC_SITE_METHOD = git

GADGET_INITC_DEPENDENCIES = host-go

GADGET_INITC_GOPATH = "$(@D)/gopath"
GADGET_INITC_MAKE_ENV = $(HOST_GO_TARGET_ENV) \
	GOBIN="$(@D)/bin" \
	GOPATH="$(GADGET_INITC_GOPATH)"\
	$(TARGET_MAKE_ENV)

define GADGET_INITC_BUILD_CMDS
        $(MAKE) clean
        $(GADGET_INITC_MAKE_ENV) $(MAKE) -C $(@D) get
        $(GADGET_INITC_MAKE_ENV) GIT_COMMIT=$(GADGET_INITC_VERSION) $(MAKE) -C $(@D) gadgetosinit_release
endef

define GADGET_INITC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/linux_arm/gadgetosinit $(TARGET_DIR)/usr/bin/gadget-initc
endef

$(eval $(generic-package))