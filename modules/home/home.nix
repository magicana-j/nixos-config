{ config, pkgs, ... }:

{
    imports = [
        ../hyprland/hyprland.nix
        ../../dotfiles.nix
        #../nvim/nvim.nix
        #../kitty/kitty.nix
        #../alacritty/alacritty.nix
    ];

    home.username = "amuharai";
    home.homeDirectory = "/home/amuharai";

    home.stateVersion = "25.05";

    home.packages = with pkgs; [
        neovim
        htop
        fastfetch
        tree

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        font-awesome
        source-code-pro

        gimp inkscape imagemagick

        vlc obs-studio pavucontrol handbrake
        easyeffects audacity

        libreoffice

        pdfarranger evince

        file-roller p7zip unrar

        gparted 

        vscode

    ];

    home.file = {
        # "~/.screenrc".source = dotfiles/screenrc;
    };

    home.sessionVariables = {
        # EDITOR = "vim";
    };

    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = [pkgs.fcitx5-mozc];
        fcitx5.waylandFrontend = true;
    };

    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        userName = "magicana-j";
        userEmail = "";
    };

    programs.direnv.enable = true;

    nixpkgs.config.allowUnfree = true;

    fonts.fontconfig.enable = true;

}
