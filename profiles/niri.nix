{ config, pkgs, ... }:

{
  environment.systemPackges = with pkgs; [
    niri
  ];
}
