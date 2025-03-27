#    _ _____                   
#   (_)___ /_      ___ __ ___  
#   | | |_ \ \ /\ / / '_ ` _ \ 
#   | |___) \ V  V /| | | | | |
#   |_|____/ \_/\_/ |_| |_| |_|

{
  config,
  pkgs,
  lib,
  ...
}:

{
    home.packages = with pkgs; [ maim ];
	xsession.windowManager.i3 = {
		enable = true; 
		package = pkgs.i3-gaps; 
    config = {
      modifier = "Mod4"; 
      fonts = {
        names =   ["JetBrainsMono Nerd Font"] ;
        style = "Regular";
      };
      gaps = {
          inner = 5; 
          outer = 10;
          smartGaps = true; 
      };
      startup = [
        { command = "--no-startup-id picom"; }
        { command = "--no-startup-id setxkbmap 'caps:swapescape'"; }
      ];
      keybindings = let
  modifier = config.xsession.windowManager.i3.config.modifier;
in lib.mkOptionDefault {
        "${modifier}+Return" = "exec ghostty";
        "${modifier}+t" = "exec ghostty";
        "Mod1+Tab" = "workspace next";
        "${modifier}+b" = "exec zen";
        "${modifier}+d" = "exec rofi -show drun";
        "${modifier}+Shift+S" = "exec maim -s | xclip -selection clipboard -t image/png";
        "${modifier}+s" = "exec maim -s ~/foo.png";
        "XF86AudioRaiseVolume" = "exec pamixer --increase 5"; 
        "XF86AudioLowerVolume" = "exec pamixer --decrease 5";
        "Mod1+w" = "kill";
      }; 
      defaultWorkspace = "workspace number 1"; 
      

      window = {
        border = 2; 
        titlebar = false;
      };

      bars = [];
    };
    extraConfig = '' 
        bar {
          i3bar_command /home/ghost/.config/polybar/launch.sh
        }
    '';
	};
}
