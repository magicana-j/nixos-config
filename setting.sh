#!/bin/sh

sudo cp -r profiles /mnt/etc/nixos/
sudo cp configuration.nix /mnt/etc/nixos/
sudo cp flake.nix /mnt/etc/nixos/

cd /mnt/etc/nixos

