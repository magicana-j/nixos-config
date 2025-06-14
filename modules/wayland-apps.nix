{ config, pkgs, ... }:

{
    
    home.packages = with pkgs; [
        # Wayland必須アプリ
        waybar          # ステータスバー
        wofi            # アプリケーションランチャー
        mako            # 通知デーモン

        # ターミナル
        kitty           # GPU加速ターミナル
        alacritty       # 軽量ターミナル

        # ファイルマネージャー
        xfce.thunar xfce.thunar-archive-plugin xfce.thunar-volman

        # スクリーンショット
        grim            # スクリーンショット
        slurp           # 範囲選択
        wl-clipboard    # クリップボード

        # システムモニター
        btop

        # その他ユーティリティ
        wlr-randr       # ディスプレイ設定
        wlogout         # ログアウトメニュー
        swaylock        # 画面ロック
        swayidle        # アイドル管理
    ];

    # Optionally, set Hyprland as the default session for a user
    # services.displayManager.defaultSession = "hyprland";


}