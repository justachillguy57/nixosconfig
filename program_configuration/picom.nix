 {pkgs, config,...}:
{
  home.packages = with pkgs; [ picom-pijulius ];
  xdg.configFile."picom.conf".text = ''

animations = true;
animation-for-open-window = "slide-up";
animation-for-transient-window = "slide-down";
animation-for-unmap-window = "slide-up";
animation-stiffness = 300.0;
animation-window_mass = 1.0;
animation-dampening = 26;
animation-delta = 10;
animation-force_steps = false;
animation-clamping = true;

blur-background = false;
blur-background-frame = false;

shadow = true;
shadow-radius = 10;
shadow-opacity = 0.7;
shadow-offset-x = -10;
shadow-offset-y = -9;

fading = true;
fade-in-step = 0.07;
fade-out-step = 0.07;

corner-radius = 8

# Backend

backend ="glx";

vsync = true;

use-damage = true;

# Window type settings

wintypes:
{
  dialog = { animation = "zoom"; animation-unmap = "zoom"; fade = true; shadow = true; blur-background = false; focus = true; };
  splash = { animation = "zoom";  animation-unmap = "slide-down"; fade = true; shadow = true; blur-background = false; focus = false; };
};

  '';

}

