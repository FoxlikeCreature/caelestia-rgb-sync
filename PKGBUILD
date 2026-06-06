# Maintainer: your-username <your-email>
pkgname=caelestia-rgb-sync
pkgver=2.0.0
pkgrel=1
pkgdesc='Sync RGB lighting to caelestia theme accent color with interactive calibration'
arch=('any')
url='https://github.com/USERNAME/caelestia-rgb-sync'
license=('MIT')
depends=(
    'python'
    'python-openrgb'
    'python-tomli-w'
    'inotify-tools'
    'openrgb'
)

# For a release tarball on GitHub replace the source line with:
# source=("$pkgname-$pkgver.tar.gz::$url/archive/v$pkgver.tar.gz")
# sha256sums=('SKIP')
source=(
    "caelestia-rgb-sync"
    "config.example.toml"
    "systemd/caelestia-rgb.service"
    "systemd/openrgb.service"
    "README.md"
)
sha256sums=(
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
)

package() {
    install -Dm755 caelestia-rgb-sync \
        "$pkgdir/usr/bin/caelestia-rgb-sync"

    install -Dm644 caelestia-rgb.service \
        "$pkgdir/usr/lib/systemd/user/caelestia-rgb.service"

    install -Dm644 openrgb.service \
        "$pkgdir/usr/lib/systemd/user/openrgb.service"

    install -Dm644 config.example.toml \
        "$pkgdir/usr/share/caelestia-rgb-sync/config.example.toml"

    install -Dm644 README.md \
        "$pkgdir/usr/share/doc/caelestia-rgb-sync/README.md"
}
