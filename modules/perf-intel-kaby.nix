{ config, lib, pkgs, ... }:

{
  ############################
  # CPUまわり（パフォーマンス重視）
  ############################

  # intel_pstate を明示的に active にする
  boot.kernelParams = lib.mkAfter [
    "intel_pstate=active"
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
    "i915.enable_psr=0"
  ];

  # デフォルトのCPUガバナを performance に
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # auto-cpufreq は「AC時性能重視/バッテリ時そこそこ節約」運用
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
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
      intel-media-driver   # VAAPI
      vaapiIntel
    ];
  };

  ############################
  # メモリ・ストレージ
  ############################

  # zramで実メモリを稼ぐ
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  # 不要なスワップを極力抑える
  boot.kernel.sysctl."vm.swappiness" = 10;

  # SSDのTRIM
  services.fstrim.enable = true;

  # LUKSのdiscard許可（cryptroot 名は各自の構成に合わせて変更）
  # boot.initrd.luks.devices."cryptroot".allowDiscards = true;

}
