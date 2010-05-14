# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WANT_AUTOMAKE="1.10"

inherit autotools

DESCRIPTION="CELT is a very low delay audio codec designed for high-quality communications."
HOMEPAGE="http://www.celt-codec.org/"
SRC_URI="http://downloads.us.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="ogg doc debug static"

DEPEND="ogg? ( media-libs/libogg )
	dev-util/pkgconfig
	sys-devel/libtool
	doc? ( app-doc/doxygen )"
RDEPEND="ogg? ( media-libs/libogg )"

src_prepare() {
	eautomake
}

src_configure() {
	econf \
		$(use_with ogg ogg /usr) \
		$(use_enable debug assertion) \
		$(use_enable static static-modes) \
				|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README TODO || die "dodoc failed."

	find "${D}" -name '*.la' -delete

#	if use doc;then
#		doxygen Doxyfile
#		dohtml doxy
#	fi
}
