{ config, pkgs, lib, ... }:

{
  # ブートローダー設定
  boot.loader = {
    # systemd-bootを使用 (UEFIシステム用のシンプルなブートローダー)
    systemd-boot.enable = true;
    # EFI変数の書き込みを許可 (ブートエントリの追加・削除に必要)
    efi.canTouchEfiVariables = true;
  };

  # カーネルパラメータ: スワップの使用を抑制
  # 値が低いほどスワップを使わず物理メモリを優先する (0-100, デフォルト60)
  boot.kernel.sysctl."vm.swappiness" = 10;
}
