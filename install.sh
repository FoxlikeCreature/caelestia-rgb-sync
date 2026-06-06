#!/usr/bin/env bash
# install.sh - manual install (for users who cloned the repo directly)
# AUR users: use yay -S caelestia-rgb-sync instead

set -e

BIN="$HOME/.local/bin/caelestia-rgb-sync"
SYSTEMD_DIR="$HOME/.config/systemd/user"

echo "Installing caelestia-rgb-sync..."

install -Dm755 caelestia-rgb-sync "$BIN"
echo "  installed $BIN"

install -Dm644 systemd/openrgb.service "$SYSTEMD_DIR/openrgb.service"
install -Dm644 systemd/caelestia-rgb.service "$SYSTEMD_DIR/caelestia-rgb.service"

# For manual installs, patch the service to use ~/.local/bin instead of /usr/bin
sed -i "s|ExecStart=/usr/bin/|ExecStart=$HOME/.local/bin/|" \
    "$SYSTEMD_DIR/caelestia-rgb.service"
echo "  installed systemd units"

systemctl --user daemon-reload
systemctl --user enable --now openrgb.service

echo "  waiting for OpenRGB to start..."
for i in $(seq 1 15); do
    sleep 1
    if systemctl --user is-active --quiet openrgb.service; then
        echo "  OpenRGB is up"
        break
    fi
    echo "  waiting... ($i/15)"
done

systemctl --user enable --now caelestia-rgb.service

echo ""
echo "Done. Run 'caelestia-rgb-sync init' to detect devices and create your config."
echo "Then run 'caelestia-rgb-sync calibrate device' to calibrate per-device colors."
