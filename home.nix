# ★ vars を引数に追加
{ config, pkgs, lib, vars, ... }:

{
  # ================================
  # 基本ユーザー情報（変数使用）
  # ================================
  home.username = vars.user.userName;
  home.homeDirectory = "/home/${vars.user.userName}";
  home.stateVersion = vars.release;

  # ================================
  # Git設定（変数使用）
  # ================================
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
        quotepath = false;
        whitespace = "trailing-space,space-before-tab";
      };
      pull.rebase = false;
      push.default = "simple";
      color.ui = "auto";
    };

    settings.user.name = vars.git.name;
    settings.user.email = vars.git.email;
    settings.alias = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit -m";
      lg = "log --oneline --graph --decorate --all";
      dif = "diff --stat";
    };
  };

  # ================================
  # Vim設定
  # ================================
  programs.vim.defaultEditor = true;
  programs.vim.settings = {
    number = true;         # 行番号を表示
    relativenumber = true; # 相対行番号を表示
    shiftwidth = 2;        # インデント幅を2に設定
    tabstop = 2;           # タブ文字の表示幅を2に設定
    expandtab = true;      # タブの代わりにスペースを使用
    smartindent = true;    # オートインデントを有効化
  };

  # 追加のカスタム設定（extraConfig）
  programs.vim.extraConfig = ''
    set mouse=a            " マウス操作を有効化
    set ignorecase         " 検索時に大文字小文字を区別しない
    set smartcase          " 大文字が含まれる場合は区別する
    set hlsearch           " 検索結果をハイライト
    set clipboard=unnamedplus " システムのクリップボードと同期
    syntax on              " シンタックスハイライトを有効化
  '';

  # ================================
  # ユーザーパッケージ
  # ================================
  home.packages = with pkgs; [
    firefox
    htop btop fastfetch
    tree
    unzip
    ripgrep
    fd
    #vim
    neovim 
    geany
    evince
    
    tmux wezterm ghostty

    google-chrome
    zoom-us

    shotwell gimp

    audacity ffmpeg obs-studio shotcut shotwell
    vlc

    # 後でもいいもの
    libreoffice-still

  ];

  # ================================
  # シェル設定
  # ================================
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      grep = "grep --color=auto";
    };
  };

  programs.home-manager.enable = true;
}
