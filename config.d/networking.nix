{ config, pkgs, lib, myHostname, ... }:

{
  # NetworkManager: ネットワーク接続の管理
  # GUI環境で簡単にWi-Fiや有線LANを管理できる
  networking.networkmanager.enable = true;

  # ファイアウォール設定
  networking.firewall = {
    enable = true;
    
    # 信頼するネットワークインターフェース
    # Tailscaleなどを使う場合はコメントを外す
    # trustedInterfaces = ["tailscale0"];
    
    # 開放するUDPポート (必要に応じて追加)
    allowedUDPPorts = [];
  };
}
