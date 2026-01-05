{ config, pkgs, lib, ... }:

{
  # System76スケジューラー
  # CPUスケジューリングを最適化し、電源状態に応じてプロファイルを自動調整
  # デスクトップ向けに応答性を改善
  services.system76-scheduler = {
    enable = true;
    # CFS (Completely Fair Scheduler) プロファイルも有効化
    # より公平なCPU時間配分を実現
    settings.cfsProfiles.enable = true;
  };

  # Thermald: CPUの熱管理デーモン
  # Intel CPUの温度を監視し、過熱を防ぐ
  services.thermald.enable = true;

  # Powertop: 電力測定および最適化ツール
  # 消費電力を測定し、システムの省電力設定を最適化
  powerManagement.powertop.enable = true;

  # zram: 圧縮スワップ
  # メモリの一部を圧縮してスワップとして使用し、実質的なメモリ容量を増やす
  zramSwap = {
    enable = true;
    # 圧縮アルゴリズム: lz4 (高速な圧縮・展開)
    algorithm = "lz4";
    # 物理メモリの50%をzramに割り当て
    memoryPercent = 50;
  };

  # SSDのTRIM
  # 定期的にTRIMを実行してSSDのパフォーマンスを維持
  # ガベージコレクションの効率を向上
  services.fstrim.enable = true;

  # LUKS暗号化パーティションでのdiscard許可
  # TRIMコマンドを暗号化パーティションを通過させる
  # セキュリティとパフォーマンスのトレードオフがあるため、必要に応じて有効化
  # boot.initrd.luks.devices."cryptroot".allowDiscards = true;
}
