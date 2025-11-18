{ config, pkgs, ... }:

{
  home.username = "amuharai";
  home.homeDirectory = "/home/amuharai";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # シェルや基本ツール
  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    userName = "magicana-j";
    userEmail = "";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    vim
    ntfs3g exfatprogs
    htop btop wget curl fastfetch
    geany
    xarchiver p7zip

    # Graphics
    gimp
    shotwell
    inkscape

    # Multimedia
    vlc
    obs-studio
    kooha
    audacity
    shotcut
    handbrake

    # Utilities
    isoimagewriter
    lm_sensors
    gparted
#    unetbootin
#    ventoy-full

    # Office
    libreoffice-fresh
  ];

  # 例: dotfiles的な設定

  # ここに fcitx5, terminal, editor, etc…を足していく
}
