{ config, pkgs, ... }:

{
  # X Server and Desktop Environment
  services.xserver.enable = true;
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;
}
