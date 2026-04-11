# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Systemd service for the LAVD sched_ext CPU scheduler"
HOMEPAGE="https://github.com/sched-ext/scx"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

RDEPEND="
	sys-kernel/scx
	sys-apps/systemd
"

src_install() {
	systemd_dounit "${FILESDIR}/scx_lavd.service"
}

