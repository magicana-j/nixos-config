#!/bin/sh

sudo nixos-generate-config --show-hardware-config > /mnt/etc/nixos/hardware-configuration.nix

sudo cp -r profiles /mnt/etc/nixos/
sudo cp configuration.nix /mnt/etc/nixos/
sudo cp flake.nix /mnt/etc/nixos/
sudo cp install.sh /mnt/etc/nixos/

cd /mnt/etc/nixos

