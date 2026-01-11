{ config, pkgs, lib, userName, fullName, hostName, ... }:

let
  dotfilesDir = ./dotfiles;
  cfgDirs = [
    "alacritty"
    "fastfetch"
    "foot"
    "kitty"
    "ghostty"
    "nvim"
    "tmux"
  ];
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  # バージョン管理ツール
  programs.git = {
    enable = true;

    settings = {
      user.name = fullName;
      user.email = "";
      init.defaultBranch = "main";
      
      # Access Github through SSH
      # Uncomment the following two lines when you want to enable
#      url."git@github.com:".insteadOf = "https://github.com/";
#      url."ssh://git@github.com".insteadOf = "https://github.com";
    };
  };

  home.packages = with pkgs; [
    home-manager
    neovim
    geany
    gparted

    tmux
    wezterm
    ghostty

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

    libreoffice-still

    flatpak
  ];

  ## bash
  programs.bash = {
	enable = true;
    enableCompletion = true;
    shellAliases = {
      la = "ls -a";
      ll = "ls -al";
      l = "ls -alF";
      nrsf = "sudo nixos-rebuild switch --flake .#${hostName}";
      nrb = "sudo nixos-rebuild dry-build --flake .#${hostName}";
    };
  };

  ## Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file = {
    ".vim" = {
      source = "${dotfilesDir}/.vim";
      recursive = true;
    };
  } // lib.genAttrs cfgDirs (name: {
    target = ".config/${name}";
    source = "${dotfilesDir}/config/${name}";
    recursive = true;
  });

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.11"; # Please read the comment before changing.
}
