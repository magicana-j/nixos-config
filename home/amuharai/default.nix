{ config, pkgs, ... }:

{
  home.username = "amuharai";
  home.homeDirectory = "/home/amuharai";

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
    htop
    btop
    fastfetch
    wget
    curl
  ];

  # 例: dotfiles的な設定

  # ここに fcitx5, terminal, editor, etc…を足していく
}
