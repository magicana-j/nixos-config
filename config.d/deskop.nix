{ config, pkgs, lib, ... }:

{
  # X11サーバーの有効化
  services.xserver.enable = true;

  # ディスプレイマネージャー: SDDM (ログイン画面)
#   services.displayManager.sddm = {
#     enable = true;
#     theme = "breeze";
#     settings = {
#       Theme = {
#         Blur = true;
#       };
#     };
#   };

#  services.xserver.displayManager.lightdm.enable = true;

  # デスクトップ環境: Cinnamon
  services.xserver.desktopManager.cinnamon.enable = true;

  # デスクトップ環境: KDE Plasma 6
#   services.desktopManager.plasma6.enable = true;

  # PAMでログイン時にkeyringを解錠（SDDM + ログイン両方）
#   security.pam.services.sddm.enableGnomeKeyring = true;
#   security.pam.services.login.enableGnomeKeyring = true;

  # KWallet側のPAMは切る（両立させると「どっち解錠？」になってうるさい）
#   security.pam.services.sddm.kwallet.enable = lib.mkForce false;
#   security.pam.services.login.kwallet.enable = lib.mkForce false;

  # GNOME Keyring (パスワード管理システム)
  services.gnome.gnome-keyring.enable = true;

  # Wayland関連
  # Xwaylandを有効化 (X11アプリをWayland上で動かすための互換レイヤー)
  programs.xwayland.enable = true;

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

}
