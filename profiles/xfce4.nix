{ config, pkgs, ... }:

{
#  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
}
