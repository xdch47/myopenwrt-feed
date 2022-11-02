#
# Copyright (C) 2022 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sshguard
PKG_VERSION:=2.4.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/$(PKG_NAME)
PKG_HASH:=2770b776e5ea70a9bedfec4fd84d57400afa927f0f7522870d2dcbbe1ace37e8

include $(INCLUDE_DIR)/package.mk

define Package/sshguard
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=SSH
  TITLE:=sshguard block the ssh attacker with a firewall rule
  URL:=http://sshguard.sourceforge.net/
  DEPENDS:= +libpthread
endef

define Package/sshguard/description
  Sshguard monitors servers from their logging activity.
  When logs convey that someone is doing a Bad Thing,
  sshguard reacts by blocking he/she/it for a bit.
  Sshguard has a touchy personality:
  when a naughty tyke insists disturbing your host, it reacts firmer and firmer.
endef
define Package/sshguard/conffiles
/etc/sshguard.conf
endef
PKG_INSTALL=:1

define Package/sshguard/install
	$(INSTALL_DIR) $(1)/usr/sbin
	#$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/$(PKG_NAME) $(1)/usr/sbin/
	# patched version:
	$(INSTALL_BIN) files/$(PKG_NAME) $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/sshg-blocker $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/sshg-fw-nft-sets $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/sshg-logtail $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/sshg-parser $(1)/usr/lib
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/$(PKG_NAME).init $(1)/etc/init.d/$(PKG_NAME)
	$(INSTALL_CONF) files/$(PKG_NAME).conf $(1)/etc/$(PKG_NAME).conf
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d/
	$(INSTALL_CONF) files/$(PKG_NAME).conf.syslog-ng $(1)/etc/syslog-ng.d/$(PKG_NAME).conf
endef

define Package/sshguard/conffiles
/etc/config/$(PKG_NAME).conf
endef

$(eval $(call BuildPackage,sshguard))
