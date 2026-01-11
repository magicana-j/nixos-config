#!/usr/bin/env bash

set -e

CONFIG_DIR="~/nixos"
CURRENT_USER=$(whoami)

rsync -av \
	--exclude='.git/' \
	--exclude='.gitignore' \
	--exclude='.gitmodules' \
	--exclude='*.sh' \
	--exclude='README.md' \
	--exclude='flake.lock' \
	./ $CONFIG_DIR

sudo nixos-generate-config --show-hardware-config > $CONFIG_DIR/hardware-configuration.nix

echo "========================================="
echo "NixOS Configuration Setup"
echo "========================================="
echo ""

# Permission check
if [ "$EUID" -eq 0 ]; then
  echo "Error: Do not run this script as root"
  echo "Please run as a normal user"
  exit 1
fi

# Directory check
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Error: $CONFIG_DIR not found"
  exit 1
fi

cd "$CONFIG_DIR"

echo "Current username: $CURRENT_USER"
echo "Current hostname: $(hostname)"
echo ""

# Check if user-config.nix exists
if [ -f "user-config.nix" ]; then
  echo "Warning: user-config.nix already exists"
  read -p "Overwrite? [y/N]: " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted"
    exit 0
  fi
fi

# User input
echo ""
echo "Please enter configuration information:"
echo ""
echo " Username: [$CURRENT_USER]

read -p "Hostname [$(hostname)]: " INPUT_HOSTNAME
HOSTNAME=${INPUT_HOSTNAME:-$(hostname)}

read -p "Full name: " FULLNAME
read -p "Email address: " EMAIL

# Update user-config.nix
cat > user-config.nix << EOF
{
  # NixOS User Configuration
  # Auto-generated on: $(date)

  system = "x86_64-linux";
  myName = "$CURRENT_USER";
  myHostname = "$HOSTNAME";

  userFullName = "$FULLNAME";
  userEmail = "$EMAIL";

}
EOF

echo ""
echo "========================================="
echo "Configuration Complete"
echo "========================================="
echo ""
echo "Configuration summary:"
echo "  Username: $CURRENT_USER"
echo "  Hostname: $HOSTNAME"
echo "  Full name: $FULLNAME"
echo "  Email: $EMAIL"
echo ""

echo ""
echo "Next step:"
echo ""
echo "  1. Check if the configuration is correct:"
echo "     sudo nixos-rebuild dry-build --flake $CONFIG_DIR#$HOSTNAME"
echo ""
echo "  2. Apply configuration:"
echo "     sudo nixos-rebuild switch --flake $CONFIG_DIR#$HOSTNAME"
echo ""
