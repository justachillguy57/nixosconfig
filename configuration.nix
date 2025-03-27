{ config, pkgs, inputs,... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager 
      inputs.stylix.nixosModules.stylix
    ];
  programs.nano.enable = false;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  users.users.ghost.shell = pkgs.zsh;
  users.users.ghost.useDefaultShell = true;

  # zsh configuration 
  programs.zsh.enable = true;


  services.xserver.excludePackages = [ pkgs.xterm ];
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
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
        gnome-pomodoro
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	gitFull 
	neovim
	xorg.xinit
	xorg.libX11 
	nerd-fonts.jetbrains-mono
	jetbrains-mono
	spotify 
	obsidian
    pamixer
    nixd
  ];
  environment.gnome.excludePackages = (with pkgs; [
	  atomix 
	  cheese 
	  epiphany 
	  evince 
	  geary 
	  gedit 
	  gnome-characters
	  gnome-music
	  gnome-photos
	  gnome-terminal
	  gnome-tour
	  hitori 
	  iagno 
	  tali 
      gnome-console 
      gnome-text-editor
      gnome-connections
      gnome-system-monitor
      gnome-calculator
      file-roller
      gnome-maps
      gnome-disk-utility
      gnome-extensions-cli
      gnome-contacts
  ]);
  


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
  stylix.image = ./to.png;
  stylix.polarity = "dark";

  system.stateVersion = "24.11"; 
}
