{ config, pkgs, lib, ... }:

{
  fonts = {
    # インストールするフォントパッケージ
    packages = with pkgs; [
      # 基本フォント
      noto-fonts                    # Google Notoフォント (多言語対応)
      # noto-fonts-cjk-sans         # 中日韓フォント (必要に応じて)
      noto-fonts-color-emoji        # カラー絵文字
      liberation_ttf                # Liberation (Arial/Times New Roman代替)
      
      # プログラミング用等幅フォント
      fira-code                     # Fira Code (合字対応)
      fira-code-symbols
      jetbrains-mono                # JetBrains Mono
      nerd-fonts.jetbrains-mono     # Nerd Fonts版 (アイコン追加)
      
      # 日本語プログラミングフォント
      mplus-outline-fonts.githubRelease  # M+ Outline
      udev-gothic                   # UDEVゴシック
      udev-gothic-nf                # UDEVゴシック Nerd Fonts版
      hackgen-font                  # 白源/HackGen
      hackgen-nf-font               # 白源 Nerd Fonts版
      explex                        # EXPLEX (IBM Plex Mono改)
      explex-nf                     # EXPLEX Nerd Fonts版
      plemoljp                      # PlemolJP (IBM Plex Mono改)
      plemoljp-nf                   # PlemolJP Nerd Fonts版
      plemoljp-hs                   # PlemolJP Half-Size版
      moralerspace                  # Moralerspace
      moralerspace-hw               # Moralerspace Half-Width版
    ];

    # フォントディレクトリの有効化
    # ~/.local/share/fontsなどからフォントを読み込む
    fontDir.enable = true;

    # フォント設定
    fontconfig = {
      # デフォルトフォントの指定
      defaultFonts = {
        # セリフ体とサンセリフ体はコメントアウト (システムデフォルトを使用)
        # serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        # sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        
        # 等幅フォント: ターミナルやエディタで使用
        monospace = [
          "HackGen"                 # メインの等幅フォント
          "Noto Sans Mono CJK JP"   # 日本語等幅フォント
          "Noto Color Emoji"        # 絵文字
        ];
        
        # 絵文字フォント
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
