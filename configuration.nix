{ config, pkgs, lib, userName, hostName, fullName, ... }:

let
  # config.dディレクトリ内のすべての.nixファイルを自動的にインポート
  configDir = ./config.d;
  nixFiles = builtins.readDir configDir;
  importNixFiles = lib.mapAttrsToList
    (name: type:
      if type == "regular" && lib.hasSuffix ".nix" name
      then configDir + "/${name}"
      else null
    )
    nixFiles;
  validImports = builtins.filter (x: x != null) importNixFiles;
in

{
  imports = [
    ./hardware-configuration.nix
  ] ++ validImports;

  networking.hostName = hostName;

  users.users.${userName} = {
    isNormalUser = true;

    # ユーザーのフルネーム (表示名)
    description = fullName;
    
    # 所属グループ
    # グループに所属することで特定の権限や機能が使えるようになる
    extraGroups = [
      "networkmanager"  # ネットワーク設定の変更権限
      "wheel"           # sudo権限 (管理者コマンド実行)
      "video"           # ビデオデバイスへのアクセス
      "audio"           # オーディオデバイスへのアクセス
      #"libvirt"         # 仮想マシン管理 (KVM/QEMU)
      "podman"          # Podmanコンテナの管理
    ];
  };

  # flakes を有効化（導入直後に入れる定番）
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ダウンロードバッファサイズ: 500 MiB
  # 大きなパッケージのダウンロードを高速化
  nix.settings.download-buffer-size = 524288000;
  
  # ストアの自動最適化
  # 同一ファイルをハードリンクで共有してディスク容量を節約
  nix.settings.auto-optimise-store = true;
  
  # バイナリキャッシュの設定
  # ビルド済みパッケージをダウンロードしてコンパイル時間を短縮
  nix.settings.substituters = [
    # 公式キャッシュ (デフォルトで有効)
    # "https://cache.nixos.org"
    
    # Nix Communityのキャッシュ
    "https://nix-community.cachix.org"
    
    # 必要に応じて他のCachixキャッシュを追加
  ];

  # キャッシュの公開鍵 (署名検証用)
  nix.settings.trusted-public-keys = [
    # 公式キャッシュの鍵 (デフォルトで含まれる)
    # "cache.nixos.org-1:【公式キー】"
    
    # Nix Communityキャッシュの鍵
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # 信頼されたユーザー
  # これらのユーザーは追加のバイナリキャッシュを使用できる
  nix.settings.trusted-users = [ "root" userName ];

  # 自動ガベージコレクション
  # 古い世代のパッケージを自動削除してディスク容量を節約
  nix.gc = {
    automatic = true;
    # 実行頻度: 毎週
    dates = "weekly";
    # 7日より古いものを削除
    options = "--delete-older-than 7d";
  };

  # システムバージョン (このシステムで最初にインストールしたNixOSのバージョン)
  system.stateVersion = "25.11";
}
