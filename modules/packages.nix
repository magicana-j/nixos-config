# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    ntfs3g exfatprogs
    htop btop wget curl fastfetch
    git
    geany
    xarchiver p7zip

    # Graphics
    gimp
    shotwell
#    inkscape

    # Video
    vlc

    # Utilities
    isoimagewriter
    lm_sensors
    gparted
#    unetbootin
#    ventoy-full

    # Office
#    libreoffice-fresh
  ];

}
