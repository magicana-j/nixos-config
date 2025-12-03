{ config, pkgs, ... }:

{
  home.username = "amuharai";
  home.homeDirectory = "/home/amuharai";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    home-manager
    neovim
    btop htop fastfetch

    geany

#    podman
#    podman-compose
#
#    shotwell
#    gimp
#
#    audacity
#    handbrake
#    obs-studio
#    shotcut
#    shotwell
#    vlc
#
#    go
#    rustc
#    nodejs_24

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
      nrt = "sudo nixos-rebuild test --flake /etc/nixos#$(hostname)";
      nrb = "sudo nixos-rebuild build --flake /etc/nixos#$(hostname)";
      
      hms = "home-manager switch --flake ~/dotfiles#amuharai";
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
