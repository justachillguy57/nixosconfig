{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];
  programs.nano.enable = false;
  services.tailscale.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["ghost"];
  virtualisation.libvirtd.enable = true;

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.dummy-avrcp-player" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.hw-volume" = ["a2dp_sink" "a2dp_source" "hsp_hs" "hsp_ag"];
      "bluez5.codecs" = [
        "sbc"
        "aac"
        "sbc_xq"
        "ldac"
        "aptx"
        "aptx_hd"
      ];
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
        "bap_sink"
        "bap_source"
        "a2dp_sink"
        "a2dp_source"
      ];
    };
  };

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  users.users.ghost.shell = pkgs.zsh;
  users.users.ghost.useDefaultShell = true;

  # zsh enabling
  programs.zsh.enable = true;

  services.xserver.excludePackages = [pkgs.xterm];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.displayManager.ly.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  services.printing.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  users.users.ghost = {
    isNormalUser = true;
    description = "Ghost";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "dialout" "audio"];
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gitFull
    xorg.xinit
    xorg.libX11
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    spotify
    obsidian
    pamixer
    nixd
    alsa-utils
  ];

  stylix.enable = true;
  stylix.base16Scheme = ./catppuccin-mocha.yaml;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
  };
  stylix.cursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };
  stylix.image = ./to.jpg;
  stylix.polarity = "dark";

  system.stateVersion = "24.11";
}
