{ pkgs, ... }:

{
    imports = [
        ../waybar/waybar.nix
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;                 # 25.05 の stable ビルド
        #systemdIntegration = true;              # renamed in current version
        systemd.enable = true;
    };

    # 設定ファイルを別置き
    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

#    home.packages = with pkgs; [
#        waybar
#        #rofi-wayland
#        wofi kitty alacritty foot
#        xdg-desktop-portal
#        xdg-desktop-portal-hyprland
#        networkmanagerapplet
#        wl-clipboard grim slurp sway-contrib.grimshot
#        swaylock swaybg mako
#        xfce.thunar xfce.thunar-volman xfce.thunar-archive-plugin
#    ];

    home.sessionVariables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        NIXOS_OZONE_WL = "1";
    };
}
