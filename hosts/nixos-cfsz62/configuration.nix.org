# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/nix-settings.nix
    ../modules/audio.nix
    ../modules/boot.nix
    ../modules/desktop.nix
    ../modules/fonts.nix
    ../modules/localization.nix
    ../modules/networking.nix
    ../modules/packages.nix
    ../modules/programs.nix
    ../modules/users.nix
    ../modules/ssh.nix
    ../modules/tor.nix
#    ../modules/podman.nix
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 80;
    algorithm = "zstd";
    priority = 100;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
