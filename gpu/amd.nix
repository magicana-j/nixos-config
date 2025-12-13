{ config, pkgs, lib, ... }:

{
  # AMD GPU基本設定
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # 32bitアプリケーション対応（ゲームなど）
    
    # 追加ドライバー
    extraPackages = with pkgs; [
      # OpenCL サポート
      rocmPackages.clr.icd
      
      # Video Acceleration API (VA-API)
      libva
      vaapiVdpau
      
      # AMD Media Driver
      mesa.drivers
    ];
    
    # 32bit版の追加ドライバー
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      vaapiVdpau
    ];
  };

  # カーネルモジュール
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  
  # AMDGPU有効化
  hardware.amdgpu = {
    enable = true;
    # OpenCLサポート（ROCmベース）
    opencl.enable = true;
    # AMDVLK（AMD公式Vulkanドライバー、オプション）
    # amdvlk.enable = true;
  };

  # カーネルパラメータ
  boot.kernelParams = [
    # 早期KMSサポート
    "amdgpu.dc=1"
    # 電力管理の改善
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  # X11/Wayland設定
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    
    # TearFree設定（画面のティアリング防止）
    deviceSection = ''
      Option "TearFree" "true"
      Option "VariableRefresh" "true"
    '';
  };

  # Vulkan設定
  hardware.vulkan = {
    enable = true;
    # RADV（Mesa Vulkanドライバー、推奨）
    package = pkgs.mesa.drivers;
    package32 = pkgs.pkgsi686Linux.mesa.drivers;
  };

  # 環境変数
  environment.variables = {
    # Mesa ドライバー指定
    AMD_VULKAN_ICD = "RADV";
    # Video Acceleration 設定
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
    # ROCm パス（OpenCL使用時）
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # ユーティリティパッケージ
  environment.systemPackages = with pkgs; [
    # モニタリングツール
    radeontop          # GPU使用率モニター
    
    # GPU情報ツール
    clinfo             # OpenCL情報表示
    vulkan-tools       # Vulkan情報（vulkaninfo）
    mesa-demos         # OpenGL デモ（glxinfo, glxgears）
    
    # ROCm関連（機械学習など使用する場合）
    # rocmPackages.rocm-smi  # GPU管理ツール
    
    # オーバークロック/ファン制御（上級者向け）
    # lact              # Linux AMDGPU Control Tool
    # corectrl          # GUI設定ツール
  ];

  # systemd サービス（電力管理の最適化）
  systemd.services.amdgpu-powerstate = {
    enable = true;
    description = "Set AMDGPU power state";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo auto > /sys/class/drm/card*/device/power_dpm_force_performance_level'";
    };
  };

  # ゲーム向け最適化（オプション）
  programs.gamemode = {
    enable = true;
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  # udev ルール（GPU アクセス権限）
  services.udev.extraRules = ''
    # AMD GPU デバイスへのアクセス許可
    KERNEL=="kfd", GROUP="video", MODE="0666"
    KERNEL=="card*", GROUP="video", MODE="0666"
    KERNEL=="renderD*", GROUP="video", MODE="0666"
  '';

  # グループ設定の確認
  # users.users.<username>.extraGroups に "video" "render" が含まれていることを確認
  # これはconfiguration.nixで既に設定済み
}
