# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/konrad-campowsky/kutils"

EGIT_REPO_URI="https://github.com/konrad-campowsky/kutils"
EGIT_BRANCH="main"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-alternatives/cpio virtual/linux-sources"

src_install() {
	dosbin sbin/kmake
	dosbin sbin/mkinitramfs
	keepdir /etc/kutils
	insinto /etc
	doins -r etc/kutils
}
