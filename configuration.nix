{ config, pkgs, inputs,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager 
      inputs.stylix.nixosModules.stylix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Hostname defined over here.

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Asia/Kolkata";

  # locales 
  i18n.defaultLocale = "en_US.UTF-8";
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
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
  users.users.ghost = {
    isNormalUser = true;
    description = "Ghost";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.variables = {
    QT_QPA_PLATFROMTHEME = "kvantum";
  }; 

  environment.systemPackages = with pkgs; [
    gitFull 
	neovim
	zed-editor 
	xorg.xinit
	xorg.libX11 
	nerd-fonts.jetbrains-mono
	jetbrains-mono
	spotify 
	obsidian
    pamixer
    nixd
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
  stylix.image = ./to.png;
  stylix.polarity = "dark";


  system.stateVersion = "24.11";
}
