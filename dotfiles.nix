{ inputs, pkgs, lib, config, ... }:

{

    home.file.".config/hypr" = {
        source     = ./dotfiles/hypr;
        recursive  = true;
    };

    home.file.".config/waybar" = {
        source     = ./dotfiles/waybar;
        recursive  = true;
    };

    home.file.".config/kitty" = {
        source     = ./dotfiles/kitty;
        recursive  = true;
    };

    home.file.".config/alacritty" = {
        source     = ./dotfiles/alacritty;
        recursive  = true;
    };

}
