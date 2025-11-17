# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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

  # X Server and Desktop Environment
  services.xserver.enable = true;

#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

#  services.xserver.displayManager.lightdm.enable = true;
#  services.xserver.desktopManager.cinnamon.enable = true;


  # GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Networking configuration
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [];
  };

  # Nix package manager settings
  nix = {
    settings = {
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
      trusted-users = [ "root" "amuharai" ];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  

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
    ];

    fontDir.enable = true;
    
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Takao PMincho" "IPA PMincho" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Takao PGothic" "IPA PGothic" "Noto Color Emoji"];
        monospace = ["Noto Sans Mono CJK JP" "Takao Gothic" "IPA Gothic" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Time zone
  time.timeZone = "Asia/Tokyo";

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };


  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    
    # 各ディレクトリを英語名で固定
    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
  };


  # Keyboard layout
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  console.keyMap = "jp106";

  # Input method (Fcitx5 with Mozc for Japanese)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
    fcitx5.waylandFrontend = true;
  };


  # User account configuration
  users.users.amuharai = {
    isNormalUser = true;
    description = "Amuharai";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "libvirt"
      "podman"
    ];
  };

  # Shell aliases
  environment.shellAliases = {
    ls = "ls -F --color=auto";
    ll = "ls -lh";
    la = "ls -la";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim git
  ];


  # Program configurations

  # Firefox
  programs.firefox.enable = true;

  # Direnv for project-specific environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  system.stateVersion = "25.05";
}
