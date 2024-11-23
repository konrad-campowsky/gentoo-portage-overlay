# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="2"

inherit check-reqs kernel-2
detect_version
detect_arch

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="-apple-hybrid-gpu experimental"

src_prepare() {
	default_src_prepare

	if use apple-hybrid-gpu; then
		eapply "${FILESDIR}/${PN}_always-set-apple-os.patch"
	fi
}

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}