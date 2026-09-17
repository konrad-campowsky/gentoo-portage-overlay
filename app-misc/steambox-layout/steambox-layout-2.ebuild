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

DEPEND="sys-apps/systemd sys-apps/kutils app-misc/kcabase-layout games-util/xboxdrv net-wireless/bluez[systemd]"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	udev_dorules "${FILESDIR}/91-wakeup.rules"
	insinto /etc/kutils
	doins ${FILESDIR}/start_misc
}

pkg_postinst() {
	systemctl enable start_misc
	systemctl enable systemd-networkd
	systemctl enable xboxdrv
	systemctl enable bluetooth
}

