{ config, pkgs, ... }:

{
  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
#  nixpkgs.config.packageOverrides = pkgs: {
#    steam = pkgs.steam.override {
#      extraPkgs = pkgs:
#        with pkgs; [
#          migu
#        ];
#    };
#  };

}

