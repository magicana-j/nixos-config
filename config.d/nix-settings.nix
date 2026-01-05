{ config, pkgs, lib, myName, ... }:

{
  # Nixパッケージマネージャーの設定
  nix = {
    settings = {
      # ダウンロードバッファサイズ: 500 MiB
      # 大きなパッケージのダウンロードを高速化
      download-buffer-size = 524288000;
      
      # ストアの自動最適化
      # 同一ファイルをハードリンクで共有してディスク容量を節約
      auto-optimise-store = true;
      
      # 実験的機能の有効化
      # nix-command: 新しいCLIコマンド (nix build, nix runなど)
      # flakes: 再現可能なNix構成管理システム
      experimental-features = ["nix-command" "flakes"];

      # バイナリキャッシュの設定
      # ビルド済みパッケージをダウンロードしてコンパイル時間を短縮
      substituters = [
        # 公式キャッシュ (デフォルトで有効)
        # "https://cache.nixos.org"
        
        # Nix Communityのキャッシュ
        "https://nix-community.cachix.org"
        
        # 必要に応じて他のCachixキャッシュを追加
      ];

      # キャッシュの公開鍵 (署名検証用)
      trusted-public-keys = [
        # 公式キャッシュの鍵 (デフォルトで含まれる)
        # "cache.nixos.org-1:【公式キー】"
        
        # Nix Communityキャッシュの鍵
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # 信頼されたユーザー
      # これらのユーザーは追加のバイナリキャッシュを使用できる
      trusted-users = [ "root" myName ];
    };

    # 自動ガベージコレクション
    # 古い世代のパッケージを自動削除してディスク容量を節約
    gc = {
      automatic = true;
      # 実行頻度: 毎週
      dates = "weekly";
      # 7日より古いものを削除
      options = "--delete-older-than 7d";
    };
  };

  # Unfreeパッケージの許可
  # プロプライエタリソフトウェアのインストールを可能にする
  nixpkgs.config.allowUnfree = true;

  # 特定の脆弱なパッケージを許可
  # セキュリティ上の理由で通常ブロックされるパッケージを使用する場合
  nixpkgs.config.permittedInsecurePackages = [ "ventoy-full" ];
}
