{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    podman
    podman-compose

    shotwell
    gimp

    audacity
    handbrake
    obs-studio
    shotcut
    shotwell
    vlc

    go
    rustc
    nodejs_24

  ];

}
