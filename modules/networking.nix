{ config, pkgs, ... }:

{
  # Networking configuration
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [];
    # allowedTCPPorts = [ ... ];
  };
}
