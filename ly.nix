# /etc/nixos/configuration.nix の該当部分

{
  # ディスプレイマネージャをlyに設定
  services.displayManager.ly = {
    enable = true;
    settings = {
      # アニメーションを無効化（オプション）
      animation = "none";
      
      # ログイン試行回数の制限
      max_desktop_len = 100;
      max_login_len = 255;
      max_password_len = 255;
      
      # セッション選択を表示
      hide_borders = false;
      hide_key_hints = false;
      
      # 言語設定（日本語環境の場合）
      lang = "en";
    };
  };

  # 既存のディスプレイマネージャを無効化（必要に応じて）
  # services.xserver.displayManager.gdm.enable = false;
  # services.xserver.displayManager.lightdm.enable = false;

  # X11またはWaylandの設定
  services.xserver = {
    enable = true;
    
    # デスクトップ環境（Cinnamon）
    desktopManager.cinnamon.enable = true;
    
    # ウィンドウマネージャー設定
    windowManager.session = [];
  };
}
