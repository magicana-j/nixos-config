{ config, pkgs, lib, ... }:

{
  # X11サーバーの有効化
  services.xserver.enable = true;

  # ディスプレイマネージャー: SDDM (ログイン画面)
  services.displayManager.sddm.enable = true;

  # デスクトップ環境: Cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;

  # Wayland関連
  # Xwaylandを有効化 (X11アプリをWayland上で動かすための互換レイヤー)
  programs.xwayland.enable = true;

  # Swayウィンドウマネージャー (Wayland用タイル型WM)
  programs.sway = {
    enable = true;
    # GTKテーマの適用を有効化
    wrapperFeatures.gtk = true;
  };

  # Waybar (Wayland用のステータスバー)
  programs.waybar.enable = true;

  # Niri (Wayland用のスクロール型タイリングウィンドウマネージャー)
  programs.niri.enable = true;

  # タッチパッドサポート (ほとんどのデスクトップ環境でデフォルト有効)
  # services.xserver.libinput.enable = true;

  # Bluetooth設定
  hardware.bluetooth = {
    enable = true;
    # 起動時にBluetoothを自動でオンにする
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # グラフィックスドライバ
  hardware.graphics = {
    enable = true;
    # 32bitアプリケーション対応 (一部のゲームやWineで必要)
    enable32Bit = true;
  };

  # GNOME Keyring (パスワード管理システム)
  services.gnome.gnome-keyring.enable = true;
}
