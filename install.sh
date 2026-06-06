#!/usr/bin/env bash
# install.sh - install caelestia-rgb-sync

set -e

BIN="$HOME/.local/bin/caelestia-rgb-sync"
CFG_DIR="$HOME/.config/caelestia-rgb"
SYSTEMD_DIR="$HOME/.config/systemd/user"

echo "Installing caelestia-rgb-sync..."

install -Dm755 caelestia-rgb-sync "$BIN"
echo "  installed $BIN"

install -Dm644 systemd/openrgb.service "$SYSTEMD_DIR/openrgb.service"
install -Dm644 systemd/caelestia-rgb.service "$SYSTEMD_DIR/caelestia-rgb.service"
echo "  installed systemd units"

if [ ! -f "$CFG_DIR/config.toml" ]; then
    install -Dm644 config.example.toml "$CFG_DIR/config.toml"
    echo "  installed default config to $CFG_DIR/config.toml"
else
    echo "  skipped config (already exists at $CFG_DIR/config.toml)"
fi

systemctl --user daemon-reload
systemctl --user enable --now openrgb.service
echo "  waiting for OpenRGB to start..."
sleep 10
systemctl --user enable --now caelestia-rgb.service

echo ""
echo "Done. Edit $CFG_DIR/config.toml to tune colors per device."
echo "Apply changes without rebooting: touch ~/.local/share/caelestia/hypr/scheme/current.conf"
