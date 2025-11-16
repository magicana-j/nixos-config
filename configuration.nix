# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

# 以下の2つはいずれかをコメントアウト
    ./modules/perf-intel-kaby.nix
#    ./modules/powersave-intel-kaby.nix

    ./modules/nix-settings.nix
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/fonts.nix
    ./modules/localization.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/ssh.nix
    ./modules/tor.nix
    ./modules/podman.nix
  ];

  system.stateVersion = "25.05";
}
