{ config, pkgs, ... }:

{
  # Nix package manager settings
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
  };
  
  nix.settings = {
    # 既定の公式キャッシュを残したまま、順序は優先度を意味
    substituters = [
      # "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      # 必要なら他のCachixを追加
    ];
    
    trusted-public-keys = [
      # "cache.nixos.org-1:【公式キー】"
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # 追加した各キャッシュの公開鍵を列挙
    ];
    
    # 一般ユーザーが追加のsubstituterを使えるようにしたい場合だけ
    trusted-users = [ "root" "amuharai" ];
  };    

}
