{pkgs, config, ...}: 
{
	xdg.configFile."ghostty/config".text = '' 
		font-family = "JetBrainsMono Nerd Font" 
		gtk-titlebar = false

		theme = catppuccin-mocha

		window-theme = ghostty
		window-decoration = false

		gtk-titlebar = false
		gtk-single-instance = true
		gtk-tabs-location = bottom
		gtk-wide-tabs = false
	'';

}
