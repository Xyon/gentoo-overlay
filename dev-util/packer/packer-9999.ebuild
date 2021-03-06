# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A tool for creating machine images"
HOMEPAGE="http://www.packer.io"
SRC_URI=""

EGIT_REPO_URI="git://github.com/mitchellh/packer.git"

inherit git-2 eutils

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	>=dev-lang/go-1.1.2
	dev-vcs/git
"
RDEPEND=""

EGIT_SOURCEDIR="${WORKDIR}/gopath/src/github.com/mitchellh/packer"
S="${EGIT_SOURCEDIR}"

# For an Ansible test case
USER="${whoami}"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	export GOPATH="${WORKDIR}/gopath"
	export PATH="${GOPATH}/bin:${PATH}"
	go get github.com/mitchellh/gox || die
}

src_compile() {
	emake || die
}

src_install() {
	dobin "${GOPATH}"/bin/packer*
}
