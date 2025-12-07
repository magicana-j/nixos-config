{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    grim slurp
    mako
    wofi fuzzel
    waybar
  ];
    
}
