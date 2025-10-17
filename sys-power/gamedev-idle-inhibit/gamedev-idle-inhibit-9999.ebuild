# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson udev systemd

DESCRIPTION=""
HOMEPAGE="https://github.com/konrad-campowsky/gamepad-idle-inhibit"

EGIT_REPO_URI="https://github.com/konrad-campowsky/${PN}"

LICENSE="MIT"
SLOT="0"

DEPEND="sys-apps/systemd virtual/udev"

src_configure() {
	local emesonargs=(
		-Dsystemd_system_unit_dir="$(systemd_get_systemunitdir)"
		-Dudev_rules_dir="$(get_udevdir)/rules.d"
	)
	meson_src_configure
}


pkg_postinst() {
	if systemd_is_booted; then
		systemctl daemon-reload || die "daemon-reload failed"
	fi
	udev_reload
}

pkg_postrm() {
	if systemd_is_booted; then
		systemctl daemon-reload || die "daemon-reload failed"
	fi
	udev_reload
}
