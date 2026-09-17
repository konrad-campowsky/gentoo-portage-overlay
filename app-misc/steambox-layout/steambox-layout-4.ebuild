# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="steambox layout"
HOMEPAGE=""
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sys-apps/systemd sys-apps/kutils app-misc/kcabase-layout net-wireless/bluez[systemd] sys-kernel/scx_lavd-loader net-wireless/iwd"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	udev_dorules "${FILESDIR}/91-wakeup.rules"

	insinto /etc/portage/patches/sys-kernel/gentoo-sources
	doins "${FILESDIR}/ax200-on-aorus-b550-quirk.patch"
}

pkg_postinst() {
	udev_reload

	systemctl enable start_misc
	systemctl enable systemd-networkd
#	systemctl enable xboxdrv
	systemctl enable bluetooth
	systemctl enable scx_lavd
	systemctl enable iwd
}

pkg_postrm() {
	udev_reload
}
