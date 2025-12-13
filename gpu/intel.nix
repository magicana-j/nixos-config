{ config, pkgs, ... }:

{
  # Intel Graphics最適化

  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = ["i915"];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
    "i915.fastboot=1"
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vulkan-loader
      vulkan-validation-layers
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHd";

    # 第７世代以前の場合は "i915";
#    LIBVA_DRIVER_NAME = "i915";
  };

  # thermald サービス (Intel CPU向け)
  # Intel CPUの温度管理デーモンを有効にし、過熱を防ぎます。
  # Intel製以外のCPUを使用している場合は不要です。
  services.thermald.enable = true;
}

