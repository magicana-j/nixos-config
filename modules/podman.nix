{ config, pkgs, ... }:

{
  # Podmanの有効化
  virtualisation.podman = {
    enable = true;
    
    # Dockerとの互換性（docker コマンドのエイリアス）
    dockerCompat = true;
    
    # Docker Composeとの互換性
    dockerSocket.enable = true;
    
    # デフォルトネットワークの設定
    defaultNetwork.settings = {
      dns_enabled = true;
    };
    
    # 自動更新の有効化（オプション）
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # コンテナイメージのレジストリ設定
  virtualisation.containers = {
    enable = true;
    
    # registries.confの設定
    registries.search = [
      "docker.io"
      "quay.io"
      "registry.fedoraproject.org"
    ];
    
    # 非セキュアレジストリ（必要に応じて）
    # registries.insecure = [ "localhost:5000" ];
  };

  # 推奨パッケージ
  environment.systemPackages = with pkgs; [
    podman
    podman-compose     # Docker Composeファイルを使用可能に
    podman-tui         # Podman用のTUIツール
    buildah            # コンテナイメージのビルド
    skopeo             # イメージの操作・転送
    dive               # イメージレイヤーの分析
    
    # Tor関連
#    tor
#    tor-browser-bundle-bin  # ネイティブTor Browser（比較用）
    
    # デバッグ・監視ツール
    ctop               # コンテナのトップ
    lazydocker         # Docker/Podman用のTUI
  ];

  # systemdサービスの設定（オプション）
  systemd.services.podman-auto-update = {
    enable = true;
    description = "Podman auto-update service";
  };

  # ファイアウォール設定（必要に応じて）
  networking.firewall = {
    # Torプロキシポートは127.0.0.1に限定するため開放不要
    # 他のコンテナサービスを公開する場合のみ設定
    # allowedTCPPorts = [ ];
  };
}

