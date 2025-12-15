{ config, pkgs, lib, myName, myHostname, userConfig, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./gaming.nix
    ./profiles/cinnamon.nix
  ];

  # user-config.nixが存在しない場合の警告
  warnings = lib.optionals (!builtins.pathExists /etc/nixos/user-config.nix) [
    ''
      警告: user-config.nix が見つかりません。
      user-config.nix.example をコピーして、自分の環境に合わせて編集してください：
        cd /etc/nixos
        cp user-config.nix.example user-config.nix
        vim user-config.nix
    ''
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # X Server
  services.xserver.enable = true;

  # GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Networking configuration
  networking.hostName = myHostname;
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [];
  };

  # Nix package manager settings
  nix = {
    settings = {
      download-buffer-size = 524288000; # 500 MiB
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

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
      trusted-users = [ "root" myName ];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # System76 CPU スケジューラー
  # CPUのスケジューリングを最適化し、電源状態に応じてプロファイルを自動調整します。
  services.system76-scheduler = {
    enable = true;
    # CFS (Completely Fair Scheduler)プロファイルも有効にする
    settings.cfsProfiles.enable = true;
  };

  # TLP (Linux Advanced Power Management)
  # 詳細な電源管理を行います。
  services.tlp = {
    enable = true;
    settings = {
      # 電源接続時: CPUガバナーをパフォーマンスに設定
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # バッテリー駆動時: CPUガバナーを省電力に設定
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # 例: CPUターボブーストをバッテリー駆動時に無効化する (さらなる省電力化)
      # CPU_BOOST_ON_BAT = 0;

      # 注: ここでは動画の内容に沿った基本的な設定のみを示しています。
      # 必要に応じて、ディスク、USB、Wi-Fiなどの詳細設定を追加できます。
    };
  };

  # Power Profiles Daemon (電源プロファイルデーモン) の無効化
  # TLPを使用する場合、Gnomeなどの標準的な電源管理デーモンと競合するため、これを無効にする必要があります。
  services.power-profiles-daemon.enable = false;

  # Powertop (電力測定および最適化)
  # 消費電力を測定し、システムの最適化を行うために使用します。
  powerManagement.powertop.enable = true;

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

  # Font configuration
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      source-code-pro
      #nerdfetch
      udev-gothic-nf
      hackgen-font
      hackgen-nf-font
    ];

    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
#        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
#        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["HackGen35 Console NF" "Noto Sans Mono CJK JP" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Time zone
  time.timeZone = userConfig.timeZone;

  # Localization
  i18n.defaultLocale = userConfig.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = userConfig.extralocale;
    LC_IDENTIFICATION = userConfig.extralocale;
    LC_MEASUREMENT = userConfig.extralocale;
    LC_MONETARY = userConfig.extralocale;
    LC_NAME = userConfig.extralocale;
    LC_NUMERIC = userConfig.extralocale;
    LC_PAPER = userConfig.extralocale;
    LC_TELEPHONE = userConfig.extralocale;
    LC_TIME = userConfig.extralocale;
  };

  # Keyboard layout
  services.xserver.xkb = {
    layout = userConfig.xkblayout;
    variant = "";
  };

  console.keyMap = userConfig.keymap;

  # Input method (Fcitx5 with Mozc for Japanese)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
    fcitx5.waylandFrontend = true;
  };

  # User account configuration
  users.users.${myName} = {
    isNormalUser = true;
    description = userConfig.userFullName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "libvirt"
      "podman"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim git
    btop htop fastfetch
    libfido2
  ];

  ## Firefox
  programs.firefox.enable = true;

  system.stateVersion = "25.11";
}
