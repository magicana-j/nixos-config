#!/usr/bin/env bash

set -e

CONFIG_DIR="$HOME/nixos"

rsync -av \
	--exclude='.git/' \
	--exclude='.gitignore' \
	--exclude='.gitmodules' \
	--exclude='*.sh' \
	--exclude='README.md' \
	--exclude='flake.lock' \
	./ $CONFIG_DIR

echo "Created ~/nixos directory."

sudo nixos-generate-config --show-hardware-config > $CONFIG_DIR/hardware-configuration.nix
echo "Created hardware-configuration.nix in ~/nixos"

echo ""
echo "Next step:"
echo ""
echo "  1. Move to ~/nixos directory"
echo "     cd ~/nixos"
echo ""
echo "  2. Modify username, hostname, and fullname in flake.nix"
echo ""
echo "  3. Check if the configuration is correct:"
echo "     sudo nixos-rebuild dry-build --flake $CONFIG_DIR#$HOSTNAME"
echo ""
echo "  4. Apply configuration:"
echo "     sudo nixos-rebuild switch --flake $CONFIG_DIR#$HOSTNAME"
echo ""

