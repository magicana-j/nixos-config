{ config, pkgs, lib, myName, myHostname, userConfig, ... }:

let
  # config.dディレクトリ内のすべての.nixファイルを自動的にインポート
  configDir = ./config.d;
  nixFiles = builtins.readDir configDir;
  importNixFiles = lib.mapAttrsToList
    (name: type:
      if type == "regular" && lib.hasSuffix ".nix" name
      then configDir + "/${name}"
      else null
    )
    nixFiles;
  validImports = builtins.filter (x: x != null) importNixFiles;
in

{
  imports = [
    ./hardware-configuration.nix
    ./gaming.nix
  ] ++ validImports;

  # user-config.nixが存在しない場合の警告
  warnings = lib.optionals (!builtins.pathExists ./user-config.nix) [
    ''
      Warning: user-config.nix does not exists.
      Copy user-config.nix.example and modify according to your environment:
        cd /etc/nixos
        cp user-config.nix.example user-config.nix
        nano user-config.nix
    ''
  ];

  # システムバージョン (このシステムで最初にインストールしたNixOSのバージョン)
  system.stateVersion = "25.11";
}
