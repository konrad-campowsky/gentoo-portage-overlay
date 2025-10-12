EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Sober launcher script with a desktop entry and icon"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}/sober"

	domenu "${FILESDIR}/sober.desktop"

	doicon -s 64 "${FILESDIR}/sober.png"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

