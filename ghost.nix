{pkgs, inputs, ...}:
{
   home-manager.backupFileExtension = "hmBak";
   home-manager.users.ghost = { 
  	imports = [
	        ./program_configuration/i3wm.nix
	        ./program_configuration/picom.nix
	        ./program_configuration/rofi.nix 
	        ./program_configuration/polybar.nix 
	        ./program_configuration/ghostty.nix 
	        ./program_configuration/cli/bat.nix
	        ./program_configuration/dunst.nix
	        ./program_configuration/cli/cht-sh.nix
            ./program_configuration/cli/tmux.nix
  	];
	home.packages = with pkgs; [
		# <NOTE> add the packages here </NOTE>.
		inputs.zen-browser.packages."${system}".beta
        ghostty
		fzf 
		authenticator
		tmux
		ripgrep
		vesktop
		gh
		xclip
		gnome-tweaks
		gnome-extension-manager
        zoxide
        btop
        fd
        unzip
	];
	dconf = {
		enable = true; 
	};
    programs.btop.enable = true; 
    stylix.targets.nixvim.enable = false;
    stylix.targets.qt.enable = false;
	home.stateVersion = "24.11";
	programs.home-manager.enable = true; # let it cook bro
  };
}
