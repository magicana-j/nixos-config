{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;

  programs.niri.enable = true;
}
