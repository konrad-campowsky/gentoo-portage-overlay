# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Utility to switch between IGP and dedicated GPU on caertain Macbook Pro models"
HOMEPAGE="https://github.com/0xbb/gpu-switch"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

src_unpack() {
	mkdir "${S}"
}

src_install() {
	mkdir "${S}"
	dosbin "${FILESDIR}/${PN}"
}

