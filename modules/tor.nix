{ config, pkgs, ... }:

{
  # Tor
  environment.systemPackages = with pkgs; [
    tor
    tor-browser
  ];
  
  services.tor = {
    enable = true;
    client.enable = true;
  };
  
}
