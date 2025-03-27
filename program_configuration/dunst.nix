{config, pkgs, ...}: 
{
	home.packages = with pkgs; [ dunst ];
	xdg.configFile."dunst/dunstrc".text = ''
[global]
frame_color = "#89b4fa"
separator_color= frame
highlight = "#89b4fa"
font = JetBrainsMono Nerd Font Mono 14 
timeout = 2

[urgency_low]
background = "#1e1e2e"
foreground = "#cdd6f4"

[urgency_normal]
background = "#1e1e2e"
foreground = "#cdd6f4"

[urgency_critical]
background = "#1e1e2e"
foreground = "#cdd6f4"
frame_color = "#fab387"
	''; 
}
