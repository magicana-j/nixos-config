{ config, pkgs, lib, ... }:

{
  # unfreeパッケージを許可
  nixpkgs.config.allowUnfree = true;

  # システム全体でインストールするパッケージ
  # すべてのユーザーが使用できる
  environment.systemPackages = with pkgs; [
    # エディタ
    vim                 # テキストエディタ
    
    # バージョン管理
    #git                 # 分散型バージョン管理システム
    
    # ネットワークツール
    curl                # URLからデータを取得
    wget                # ファイルダウンロードツール
    
    # システム監視
    btop                # リソースモニター (美しいTUI)
    htop                # プロセスビューア
    fastfetch           # システム情報表示ツール
    
    # セキュリティ
    libfido2            # FIDO2/WebAuthn認証ライブラリ
  ];

  # Firefox Webブラウザ
  programs.firefox.enable = true;

  # （Ventoy用）InsecurePackagesを許可  
#  nixpkgs.config.permittedInsecurePackages = [ "ventoy-full-gtk-1.1.07" ];

}
