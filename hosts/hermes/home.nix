{ config, pkgs, ... }:

{
  home.username = "amuharai";
  home.homeDirectory = "/home/amuharai";

  home.stateVersion = "25.11"; # Please read the comment before changing.

#  nixpkgs.config.allowUnfree = true;

#  imports = [
#
#  ];
  
  home.packages = with pkgs; [
    home-manager
    neovim

    geany

    swaybg
    swayidle
    swaylock
    hyprpaper
    grim slurp
    mako
    wofi fuzzel
    waybar
    alacritty kitty foot

    google-chrome

    podman
    podman-compose

    shotwell
    gimp

    audacity
    handbrake
    obs-studio
    shotcut
    shotwell
    vlc

    go
    rustc
    nodejs_24

  ];

  ## bash
  programs.bash = {
	enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "ls -a";
      ll = "ls -al";
      l = "ls -alF";
      nrsf = "sudo nixos-rebuild switch --flake";
    };
  };

  ## Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "magicana-j";
      user.email = "";
      init.defaultBranch = "main";
      url."git@github.com:".insteadOf = "https://github.com/";
      url."ssh://git@github.com".insteadOf = "https://github.com";
	};
    #config = {
      #usr = {
        #name = "magicana-j";
        #email = "";
      #};
      #init = {
        #defaultBranch = "main";
      #};
      #url = {
        #"git@github.com:".insteadOf = "https://github.com/";
        #"ssh://git@github.com".insteadOf = "https://github.com";
      #};
    #};
  };

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

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
