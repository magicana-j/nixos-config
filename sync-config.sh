#!/bin/sh

rsync -av \
	--exclude='.git/' \
	--exclude='.gitignore' \
	--exclude='.gitmodules' \
	--exclude='*.sh' \
	--exclude='README.md' \
	--exclude='flake.lock' \
	~/nixos-config/ ~/nixos/

