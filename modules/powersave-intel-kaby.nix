{ config, lib, pkgs, ... }:

{
  ############################
  # CPUまわり（省電力重視）
  ############################

  boot.kernelParams = lib.mkAfter [
    "intel_pstate=active"
    "i915.enable_guc=0"   # デフォルト（省電力優先）
    "i915.enable_fbc=1"
    "i915.enable_psr=1"   # 省電力に効くが、問題が出たら 0 に戻す
  ];

  # デフォルトのCPUガバナを powersave に
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # auto-cpufreq で両方とも節約寄りに制御
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "powersave";
        turbo = "never";
      };
    };
  };

  ############################
  # GPU / OpenGL
  ############################

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

  ############################
  # メモリ・ストレージ
  ############################

  zramSwap = {
    enable = true;
    algorithm = "zstd";  # 圧縮率優先
    memoryPercent = 40;
  };

  boot.kernel.sysctl."vm.swappiness" = 30;

  services.fstrim.enable = true;

  # 必要ならLUKS discardもここで許可
  # boot.initrd.luks.devices."cryptroot".allowDiscards = true;

  };
}
