{ config, pkgs, lib, ... }:

{
  # 日本語入力メソッド: Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    
    # Fcitx5のアドオン
    fcitx5.addons = [
      pkgs.fcitx5-mozc  # Mozc (Google日本語入力のオープンソース版)
    ];
    
    # Waylandフロントエンド
    # Waylandセッションでの日本語入力を有効化
    fcitx5.waylandFrontend = true;
  };
}
