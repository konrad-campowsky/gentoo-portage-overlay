# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Color profiles for the Apple Facetime HD Camera"
HOMEPAGE="https://www.apple.com"
SRC_URI="https://download.info.apple.com/Mac_OS_X/031-3384.20140211.Xcc3e/BootCamp5.1.5621.zip"

LICENSE="APPLE_LICENSE"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+1771 +1871 +1874 +9112"

BDEPEND="
	app-arch/unzip
	|| ( app-arch/rar app-arch/unrar )
	|| ( sys-apps/coreutils sys-apps/busybox )
"

S="${WORKDIR}"


src_unpack() {
	unzip -q -j -d "${WORKDIR}" "${DISTDIR}/${A}" BootCamp/Drivers/Apple/AppleCamera64.exe || die
	unrar e -idq -y -op"${WORKDIR}" "${WORKDIR}/AppleCamera64.exe" AppleCamera.sys

	if use 1771; then
		dd bs=1 skip=1644880 count=19040 if=AppleCamera.sys of=1771_01XX.dat status=none || die
		echo a1831db76ebd83e45a016f8c94039406 "${WORKDIR}/1771_01XX.dat" | md5sum -c > /dev/null || die "checksum mismatch for 1771_01XX.dat"
	fi

	if use 1871; then
		dd bs=1 skip=1606800 count=19040 if=AppleCamera.sys of=1871_01XX.dat status=none || die
		echo 017996a51c95c6e11bc62683ad1f356b "${WORKDIR}/1871_01XX.dat" | md5sum -c > /dev/null || die "checksum mismatch for 1871_01XX.dat"
	fi

	if use 1874; then
		dd bs=1 skip=1625840 count=19040 if=AppleCamera.sys of=1874_01XX.dat status=none || die
		echo 3c3cdc590e628fe3d472472ca4d74357 "${WORKDIR}/1874_01XX.dat" | md5sum -c > /dev/null || die "checksum mismatch for 1874_01XX.dat"
	fi

	if use 9112; then
		dd bs=1 skip=1663920 count=33060 if=AppleCamera.sys of=9112_01XX.dat status=none || die
		echo 479ae9b2b7ab018d63843d777a3886d1 "${WORKDIR}/9112_01XX.dat" | md5sum -c > /dev/null || die "checksum mismatch for 9112_01XX.dat"
	fi
}

src_install() {
	insinto "/lib/firmware/facetimehd"
	doins *.dat
}

