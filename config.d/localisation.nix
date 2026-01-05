{ config, pkgs, lib, userConfig, ... }:

{
  # タイムゾーン設定
  time.timeZone = userConfig.timeZone;

  # ロケール設定
  # システム全体のデフォルト言語と地域設定
  i18n.defaultLocale = userConfig.locale;

  # 追加のロケール設定
  # 各カテゴリごとに地域形式を指定
  i18n.extraLocaleSettings = {
    LC_ADDRESS = userConfig.extralocale;        # 住所の表示形式
    LC_IDENTIFICATION = userConfig.extralocale; # システム識別情報
    LC_MEASUREMENT = userConfig.extralocale;    # 測定単位 (メートル法など)
    LC_MONETARY = userConfig.extralocale;       # 通貨の表示形式
    LC_NAME = userConfig.extralocale;           # 人名の表示形式
    LC_NUMERIC = userConfig.extralocale;        # 数値の表示形式
    LC_PAPER = userConfig.extralocale;          # 用紙サイズ (A4など)
    LC_TELEPHONE = userConfig.extralocale;      # 電話番号の表示形式
    LC_TIME = userConfig.extralocale;           # 日時の表示形式
  };

  # X11のキーボードレイアウト
  services.xserver.xkb = {
    layout = userConfig.xkblayout;  # キーボード配列 (jp, usなど)
    variant = "";                   # レイアウトのバリエーション
  };

  # コンソール (TTY) のキーマップ
  console.keyMap = userConfig.keymap;

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
