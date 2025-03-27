{pkgs, config, ...}:
let
  # Define the colors in Nix variables
  colors = {
    background = "#282A2E";
    backgroundAlt = "#373B41";
    foreground = "#C5C8C6";
    primary = "#F0C674";
    secondary = "#8ABEB7";
    alert = "#A54242";
    disabled = "#707880";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext1 = "#bac2de";
    subtext0 = "#a6adc8";
    overlay2 = "#9399b2";
    overlay1 = "#7f849c";
    overlay0 = "#6c7086";
    surface2 = "#585b70";
    surface1 = "#45475a";
    surface0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
    transparent = "#FF00000";
  };
  
in {
  home.packages = with pkgs; [ polybar ];
  xdg.configFile."polybar/config.ini".text = ''
;==========================================================
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;==========================================================


[bar/bar]

width = 100%

height = 24pt

radius = 6


background = ${colors.base}

foreground = ${colors.surface1}


line-size = 3pt


border-size = 4pt

border-color = #00000000


padding-left = 0

padding-right = 1


module-margin = 1


separator = |

separator-foreground = ${colors.disabled}


font-0 = JetBrainsMono Nerd Font;2


modules-left = xworkspaces nix_logo
modules-center = xwindow
modules-right = filesystem  xkeyboard memory cpu battery date systray


cursor-click = pointer

cursor-scroll = ns-resize


enable-ipc = true


[module/systray]

type = internal/tray


format-margin = 8pt

tray-spacing = 16pt

[module/battery]

type = internal/battery

format-margin = 8pt

[module/xworkspaces]

type = internal/xworkspaces

label-active = %name%

label-active-background = ${colors.surface2}

label-active-underline= ${colors.mauve}

label-active-padding = 1


label-occupied = %name%

label-occupied-padding = 1


label-urgent = %name%

label-urgent-background = ${colors.alert}

label-urgent-padding = 1


label-empty = %name%

label-empty-foreground = ${colors.overlay2}

label-empty-padding = 1


[module/xwindow]

type = internal/xwindow
label = %{F#F0C674}%title:0:60:...%
; title:0:60:... 



[module/filesystem]

type = internal/fs

interval = 25


mount-0 = /


label-mounted = %{F#F0C674}%mountpoint%%{F-} %percentage_used%%


label-unmounted = %mountpoint% not mounted

label-unmounted-foreground = ${colors.disabled}


[module/pulseaudio]

type = internal/pulseaudio


format-volume-prefix = "VOL "

format-volume-prefix-foreground = ${colors.primary}

format-volume = <label-volume>


label-volume = %percentage%%


label-muted = muted

label-muted-foreground = ${colors.disabled}

[module/nix_logo]
type = custom/text
content = %{F#89dceb} %{F-}


[module/xkeyboard]

type = internal/xkeyboard

blacklist-0 = num lock


label-layout = %layout%

label-layout-foreground = ${colors.primary}


label-indicator-padding = 2

label-indicator-margin = 1

label-indicator-foreground = ${colors.background}

label-indicator-background = ${colors.secondary}


[module/memory]

type = internal/memory

interval = 2

format-prefix = "RAM "

format-prefix-foreground = ${colors.primary}

label = %percentage_used:2%%


[module/cpu]

type = internal/cpu

interval = 2

format-prefix = "CPU "

format-prefix-foreground = ${colors.primary}

label = %percentage:2%%


[network-base]

type = internal/network

interval = 5

format-connected = <label-connected>

format-disconnected = <label-disconnected>

label-disconnected = %{F#F0C674}%ifname%%{F#707880} disconnected


[module/wlan]

inherit = network-base

interface-type = wireless

label-connected = %{F#F0C674}%ifname%%{F-} %essid% %local_ip%


[module/eth]

inherit = network-base

interface-type = wired

label-connected = %{F#F0C674}%ifname%%{F-} %local_ip%


[module/date]

type = internal/date

interval = 1


date = %H:%M

date-alt = %Y-%m-%d %H:%M:%S


label = %date%

label-foreground = ${colors.primary}


[settings]

screenchange-reload = true

pseudo-transparency = true


; vim:ft=dosini
 
  '';
}

