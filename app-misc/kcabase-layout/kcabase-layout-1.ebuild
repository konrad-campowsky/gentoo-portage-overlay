# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="kcabase-layout"
HOMEPAGE=""
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sys-apps/systemd"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

pkg_postinst() {
	systemctl enable sshd
}

