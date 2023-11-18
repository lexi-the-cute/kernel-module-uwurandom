# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# Maintainer: Alexis <alexis@catgirl.land>
pkgname=uwurandom
pkgver=VERSION
pkgrel=1
epoch=
pkgdesc="Provides a character device, /dev/uwurandom, which has a catgirl furiously typing away"
arch=('x86_64')
url="https://github.com/lexi-the-cute/uwurandom"
license=('GPL', 'MIT')
groups=()
depends=()
makedepends=('git'
	     'linux-headers')
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=("uwurandom::git+https://github.com/lexi-the-cute/uwurandom.git#branch=master")
noextract=()
md5sums=()
sha256sums=('SKIP')
validpgpkeys=()

pkgver() {
  cd "$pkgname"
  git describe --long --abbrev=7 --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}

prepare() {
	cd "$pkgname"
	#patch -p1 -i "$srcdir/$pkgname-$pkgver.patch"
}

build() {
	cd "$pkgname"
	make
}

check() {
	cd "$pkgname"
	#make -k check
}

package() {
	cd "$pkgname"
	make install
	make clean
	modprobe "$pkgname"
}
