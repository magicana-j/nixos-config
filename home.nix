{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "your-username";  # 実際のユーザー名に置き換え
  home.homeDirectory = "/home/your-username";  # 実際のパスに置き換え

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # パッケージのインストール
  home.packages = with pkgs; [
    # 開発ツール
    neovim
    vscode
    
    # メディア関連
    obs-studio
    
    # その他の便利ツール
    firefox
    git
    curl
    wget
    tree
    htop
  ];

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
  };
}
