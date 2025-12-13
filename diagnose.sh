#!/usr/bin/env bash
echo "=== NixOS Flake診断 ==="
echo "現在のホスト名: $(hostname)"
echo "設定ディレクトリ: $(pwd)"
echo ""
echo "user-config.nixの内容:"
if [ -f user-config.nix ]; then
  grep -E "(hostname|username)" user-config.nix
else
  echo "user-config.nix が見つかりません"
  grep -E "(hostname|username)" user-config.nix.example
fi
echo ""
echo "Flakeの構造:"
sudo nix flake show

