{ config, pkgs, ... }:

{
  # User account configuration
  users.users.amuharai = {
    isNormalUser = true;
    description = "Amuharai";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "libvirt"
      "podman"
    ];
  };

  # Shell aliases
  environment.shellAliases = {
    ls = "ls -F --color=auto";
    ll = "ls -lh";
    la = "ls -la";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
  };
}
