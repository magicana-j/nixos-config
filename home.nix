{ config, pkgs, lib, myName, myHostname, userConfig, ... }:

let
  dotfilesDir = ./dotfiles;
  cfgDirs = [
    "alacritty"
    "fastfetch"
    "foot"
    "kitty"
    "nvim"
    "tmux"
  ];
in
{
  home.username = myName;
  home.homeDirectory = "/home/${myName}";

  imports = [
    # git設定ファイル(git.nix)を作成してから次の行のコメントを解除
#    ./git.nix
  ];
  
  home.packages = with pkgs; [
    home-manager
    neovim
    geany
    gparted
    stow

    tmux
    wezterm
    ghostty
    
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
      nrsf = "sudo nixos-rebuild switch --flake .#$(hostname)";
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
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.11"; # Please read the comment before changing.
}
