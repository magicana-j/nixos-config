{ config, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      #onevpl-intel-gpu
      vpl-gpu-rt
      mesa
      intel-media-driver
      intel-media-sdk
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
    ];
  };

}
