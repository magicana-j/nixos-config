{ config, pkgs, lib, myName, userConfig, ... }:

{
  # ユーザーアカウントの設定
  users.users.${myName} = {
    # 通常のユーザーアカウント (システムアカウントではない)
    isNormalUser = true;
    
    # ユーザーのフルネーム (表示名)
    description = userConfig.userFullName;
    
    # 所属グループ
    # グループに所属することで特定の権限や機能が使えるようになる
    extraGroups = [
      "networkmanager"  # ネットワーク設定の変更権限
      "wheel"           # sudo権限 (管理者コマンド実行)
      "video"           # ビデオデバイスへのアクセス
      "audio"           # オーディオデバイスへのアクセス
      "libvirt"         # 仮想マシン管理 (KVM/QEMU)
      "podman"          # Podmanコンテナの管理
    ];
  };
}
