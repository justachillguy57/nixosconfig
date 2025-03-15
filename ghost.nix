{pkgs, inputs, ...}:
{
	home-manager.backupFileExtension = "hmBak";
  home-manager.users.ghost = { 
  	imports = [
		inputs.catppuccin.homeManagerModules.catppuccin
	        ./program_configuration/i3wm.nix
	        ./program_configuration/picom.nix
	        ./program_configuration/rofi.nix 
	        ./program_configuration/polybar.nix 
	        ./program_configuration/ghostty.nix 
	        ./program_configuration/cli/bat.nix
  	];
	home.packages = with pkgs; [
		# <NOTE> add the packages here </NOTE>.
		inputs.zen-browser.packages."${system}".beta
        polybar
        fzf 
        authenticator
        ghostty 
        tmux
        ripgrep
        bat
        vesktop
        screenkey 
        gh
        xclip
	];
	catppuccin = {
		enable = true; 
		flavor = "mocha";
		accent = "blue";
	};
    stylix.targets.qt.enable = false;
	home.stateVersion = "24.11";
	programs.home-manager.enable = true; # let it cook bro

  };

}
