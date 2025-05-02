{
  pkgs,
  inputs,
  ...
}: {
  home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = {
    imports = [
      ./program_configuration/i3wm.nix
      ./program_configuration/picom.nix
      ./program_configuration/ghostty.nix
      ./program_configuration/cli/bat.nix
      ./program_configuration/cli/cht-sh.nix
      ./program_configuration/cli/tmux.nix
    ];
    home.packages = with pkgs; [
      xfce.thunar
      inputs.zen-browser.packages."${system}".beta
      ghostty 
      rofi
      fzf
      authenticator
      i3status
      tmux
      ripgrep
      vesktop
      gh
      nsxiv
      xclip
      zoxide
      btop
      fd
      unzip
      neovim
      sesh
      arduino-ide
      eza
      gum
    ];
    dconf = {
      enable = true;
    };
    programs.btop.enable = true;
    stylix.targets.qt.enable = false;
    home.stateVersion = "24.11";
    programs.home-manager.enable = true; # let it cook bro
  };
}
