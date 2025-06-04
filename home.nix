{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "your-username";  # 実際のユーザー名に置き換え
  home.homeDirectory = "/home/your-username";  # 実際のパスに置き換え

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

  # パッケージのインストール
  home.packages = with pkgs; [
    # 開発ツール
    neovim
    vscode
    
    # メディア関連
    obs-studio

    # OBS用プラグイン・依存関係
    v4l-utils
    
    # フォント
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-code-pro
    noto-fonts-emoji

    # その他の便利ツール
    firefox
    git
    curl
    wget
    tree
    htop
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
    fcitx5.waylandFrontend = true;
  };

  # プログラム固有の設定
  programs = {
    # Home Manager自体を管理
    home-manager.enable = true;
    
    # Git設定
    git = {
      enable = true;
      userName = "Your Name";
      userEmail = "";
    };
    
    # Bash設定
    bash = {
      enable = true;
      bashrcExtra = ''
        # カスタムエイリアス
        alias ll='ls -alF'
        alias la='ls -A'
        alias l='ls -CF'
        
        # 環境変数
        export EDITOR=nvim
      '';
    };
  };

  # dotfiles管理（シンボリックリンク）
  home.file = {
    # Neovim設定
    ".config/nvim" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
    
    # VS Code settings
    ".config/Code/User/settings.json".source = ./dotfiles/Code/settings.json;
    ".config/Code/User/keybindings.json".source = ./dotfiles/Code/keybindings.json;
  };

  # セッション変数
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";

    # Fcitx5 環境変数
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # フォント設定
  fonts.fontconfig.enable = true;

}
