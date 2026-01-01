# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson udev systemd

DESCRIPTION=""
HOMEPAGE="https://github.com/konrad-campowsky/plymouth-new-root"

EGIT_REPO_URI="https://github.com/konrad-campowsky/${PN}"

LICENSE="MIT"
SLOT="0"

DEPEND="sys-apps/systemd virtual/udev"

