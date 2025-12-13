{ config, pkgs, lib, ... }:

{
  # Intel GPU基本設定
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # 32bitアプリケーション対応
    
    # 追加ドライバー
    extraPackages = with pkgs; [
      # Intel Media Driver (iHD) - 第8世代以降推奨
      intel-media-driver
      
      # Intel VAAPI Driver (i965) - 第7世代以前
      intel-vaapi-driver
      
      # Video Acceleration
      libva
      
      # Intel Compute Runtime (OpenCL)
      intel-compute-runtime
      
      # Vulkan
      intel-media-sdk
    ];
    
    # 32bit版の追加ドライバー
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-vaapi-driver
      vaapiIntel
      libva
    ];
  };

  # カーネルモジュール
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "i915" ];
  
  # Intel GPU有効化
  hardware.intel.graphics = {
    enable = true;
  };

  # カーネルパラメータ
  boot.kernelParams = [
    # 早期KMSサポート
    "i915.enable_fbc=1"          # Frame Buffer Compression（省電力）
    "i915.enable_psr=1"          # Panel Self Refresh（省電力）
#    "i915.enable_psr=2"          # Panel Self Refresh（省電力）
    "i915.fastboot=1"            # 高速ブート
    # GuC/HuC ファームウェア有効化（第9世代以降）
#    "i915.enable_guc=3"          # GuC submission & HuC loading
  ];

  # X11/Wayland設定
  services.xserver = {
#    enable = true;               # configuration.nixで設定済み
    videoDrivers = [ "intel" ];
    
    # Intel専用設定（TearFree、加速など）
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
      Option "AccelMethod" "sna"
    '';
    
    # または modesetting ドライバー（より新しい世代向け）
    # videoDrivers = [ "modesetting" ];
  };

  # 環境変数
  environment.variables = {
    # VA-API ドライバー選択
    # 第8世代以降: iHD (intel-media-driver)
#    LIBVA_DRIVER_NAME = "iHD";
    # 第7世代以前の場合は "i965" を使用
    LIBVA_DRIVER_NAME = "i965";
    
    # VDPAU バックエンド
    VDPAU_DRIVER = "va_gl";
    
    # OpenCL
    OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors/";
  };

  # Vulkan設定
  hardware.vulkan = {
    enable = true;
    package = pkgs.mesa.drivers;
    package32 = pkgs.pkgsi686Linux.mesa.drivers;
  };

  # ユーティリティパッケージ
  environment.systemPackages = with pkgs; [
    # GPU情報・モニタリング
    intel-gpu-tools      # intel_gpu_top, intel_gpu_frequency など
    
    # GPU情報確認
    clinfo               # OpenCL情報
    vulkan-tools         # vulkaninfo
    mesa-demos           # glxinfo, glxgears
    libva-utils          # vainfo（VA-API確認）
    
    # パフォーマンスモニタリング
    nvtop                # GPU使用率（Intel対応版）
    
    # デバッグツール（開発者向け）
    # igt-gpu-tools      # Intel GPU Tools
  ];

  # systemd サービス（電力管理の最適化）
  systemd.services.intel-gpu-powersave = {
    enable = true;
    description = "Intel GPU Power Management";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "intel-gpu-powersave" ''
        # GPU周波数の自動調整を有効化
        echo 1 > /sys/module/i915/parameters/enable_dc
        echo 1 > /sys/module/i915/parameters/enable_fbc
        
        # RC6省電力状態を有効化（既定で有効）
        if [ -f /sys/class/drm/card0/gt_RP_enable ]; then
          echo 1 > /sys/class/drm/card0/gt_RP_enable
        fi
      '';
    };
  };

  # ゲーム向け最適化（オプション）
  programs.gamemode = {
    enable = true;
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };

  # udev ルール（GPU パフォーマンスモード切替）
  services.udev.extraRules = ''
    # Intel GPU デバイスへのアクセス許可
    KERNEL=="card*", SUBSYSTEM=="drm", GROUP="video", MODE="0666"
    KERNEL=="renderD*", SUBSYSTEM=="drm", GROUP="video", MODE="0666"
  '';

  # ファームウェア（GuC/HuC）
  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  # バックライト制御（ノートPC向け）
  programs.light.enable = true;  # 非rootユーザーでバックライト調整可能に
  
  # または acpilight を使用
  # hardware.acpilight.enable = true;

  # グループ設定の確認
  # users.users.<username>.extraGroups に "video" が含まれていることを確認
  # これはconfiguration.nixで既に設定済み

  # 自動輝度調整
  services.illum.enable = true;

  # 追加パッケージ
  environment.systemPackages = with pkgs; [
    tlp       # 電力管理
  ];

}
