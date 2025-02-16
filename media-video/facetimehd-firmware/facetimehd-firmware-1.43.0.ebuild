# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware for the Apple Facetime HD Camera"
HOMEPAGE="https://www.apple.com"
SRC_URI="https://updates.cdn-apple.com/2019/cert/041-98131-20191011-4a0623d4-b919-4dc5-aa20-dd04df5762cd/OSXUpdCombo10.11.2.dmg"

LICENSE="APPLE_LICENSE"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

BDEPEND="
	app-alternatives/cpio
	app-alternatives/gzip
	app-arch/pbzx
	|| ( sys-apps/coreutils sys-apps/busybox )
"

S=${WORKDIR}

PKG_URL="https://support.apple.com/downloads/DL1849/en_US/osxupd10.11.2.dmg"

src_unpack() {
	cd "${WORKDIR}"
	7z -bsp0 -bso0 e "${DISTDIR}/${A}" -o"${WORKDIR}" "OS X El Capitan Update/OSXUpdCombo10.11.2.pkg" || die
	7z -bsp0 -bso0 e "${WORKDIR}/OSXUpdCombo10.11.2.pkg" -o"${WORKDIR}" OSXUpdCombo10.11.2.pkg/Payload || die
	mkdir -p "${WORKDIR}/System/Library/Extensions/AppleCameraInterface.kext/Contents/MacOS" || die
	pbzx -n "${WORKDIR}/Payload" | cpio -i ./System/Library/Extensions/AppleCameraInterface.kext/Contents/MacOS/AppleCameraInterface || die
	dd bs=1 skip=81920 count=603715 if="${WORKDIR}/System/Library/Extensions/AppleCameraInterface.kext/Contents/MacOS/AppleCameraInterface" | gunzip > "${WORKDIR}/firmware.bin"
	echo 4e1d11e205e5c55d128efa0029b268fe "${WORKDIR}/firmware.bin" | md5sum || die "firmware checksum mismatch"
}

src_install() {
	insinto "/lib/firmware/facetimehd"
	doins firmware.bin
}
