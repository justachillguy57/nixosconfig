 {pkgs, config,...}:
{
  home.packages = with pkgs; [ picom-pijulius ] ;
  xdg.configFile."picom.conf".text = ''
  shadow = true;
shadow-radius = 50;
shadow-opacity = .35
shadow-offset-x = -49;
shadow-offset-y = -47;
shadow-color = "#00020b"

frame-opacity = 0.95;
frame-opacity-for-same-colors = true;

inner-border-width = 1

corner-radius = 13

blur-method = "dual_kawase"
blur-background = false
blur-background-frame = false

backend = "glx"
dithered-present = false;
vsync = true;
detect-client-opacity = true;
detect-client-leader = true
use-damage = true;
xrender-sync-fence = true
log-level = "warn";

rules = ({
    match = "WM_TRANSIENT_FOR@";
    animations = ({
        triggers = ["open", "show"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        blur-opacity = {
            curve = "linear";
            duration = 0.1;
            delay = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        shadow-opacity = "opacity";
        scale-y = {
            curve = "cubic-bezier(0.24, 0.64, 0.79, 0.98)";
            duration = 0.15;
            start = 0.8;
            end = 1;
        };
        offset-y = "(-window-height/2) + (window-height/2) * scale-y";
        shadow-scale-y = "scale-y";
        shadow-offset-y = "offset-y";
    },{
        triggers = ["close", "hide"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "0";
        };
        blur-opacity = 0;
        shadow-opacity = "opacity";
        scale-y = {
            curve = "cubic-bezier(0.21, 0.02, 0.76, 0.36)";
            duration = 0.15;
            start = 1;
            end = 0.7;
        };
        offset-y = "(-window-height/2) + (window-height/2) * scale-y";
        shadow-scale-y = "scale-y";
        shadow-offset-y = "offset-y";
    });
}, {
    match = "window_type = 'dropdown_menu' || window_type = 'popup_menu' || window_type = 'menu'";
    animations = ({
        triggers = ["open", "show"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        blur-opacity = {
            curve = "linear";
            duration = 0.1;
            delay = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        shadow-opacity = "opacity";
        scale-y = {
            curve = "cubic-bezier(0.24, 0.64, 0.79, 0.98)";
            duration = 0.15;
            start = 0.8;
            end = 1;
        };
        shadow-scale-y = "scale-y";
    },{
        triggers = ["close", "hide"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "0";
        };
        blur-opacity = 0;
        shadow-opacity = "opacity";
        scale-y = {
            curve = "cubic-bezier(0.21, 0.02, 0.76, 0.36)";
            duration = 0.15;
            start = 1;
            end = 0.7;
        };
        shadow-scale-y = "scale-y";
    });
}, {
    match = "window_type = 'dropdown_menu' || window_type = 'popup_menu' || window_type = 'menu'";
    opacity = 0.9;
}, {
    match = "window_type = 'dock' || window_type = 'desktop'";
    blur-background = false;
    corner-radius = 0;
}, {
    match = "class_g *= 'i3lock' || _NET_WM_STATE@[1] = '_NET_WM_STATE_FULLSCREEN' || _NET_WM_STATE@[2] = '_NET_WM_STATE_FULLSCREEN' || _NET_WM_STATE@[3] = '_NET_WM_STATE_FULLSCREEN' || _NET_WM_STATE@[4] = '_NET_WM_STATE_FULLSCREEN'";
    shadow = false;
    corner-radius = 0;
    animations = ({
        triggers = ["open", "show"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        blur-opacity = {
            curve = "linear";
            duration = 0.1;
            delay = 0.15;
            start = "window-raw-opacity-before";
            end = "window-raw-opacity";
        };
        shadow-opacity = "opacity";
    },{
        triggers = ["close", "hide"];
        opacity = {
            curve = "linear";
            duration = 0.15;
            start = "window-raw-opacity-before";
            end = "0";
        };
        blur-opacity = 0;
        shadow-opacity = "opacity";
    });
});

animations = ({
    triggers = ["close", "hide"];
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "window-raw-opacity-before";
        end = "window-raw-opacity";
    };
    blur-opacity = "0";
    shadow-opacity = "opacity";
    offset-x = "(1 - scale-x) / 2 * window-width";
    offset-y = "(1 - scale-y) / 2 * window-height * 5";
    scale-x = {
        curve = "cubic-bezier(0.21, 0.02, 0.76, 0.36)";
        duration = 0.15;
        start = 1;
        end = 0.9;
    };
    scale-y = "scale-x";
    shadow-scale-x = "scale-x";
    shadow-scale-y = "scale-y";
    shadow-offset-x = "offset-x";
    shadow-offset-y = "offset-y";
}, {
    triggers = ["open", "show"];
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "window-raw-opacity-before";
        end = "window-raw-opacity";
    };
    blur-opacity = {
        curve = "linear";
        duration = 0.1;
        delay = 0.15;
        start = "window-raw-opacity-before";
        end = "window-raw-opacity";
    };
    shadow-opacity = "opacity";
    offset-x = "(1 - scale-x) / 2 * window-width";
    offset-y = "(1 - scale-y) / 2 * window-height * 5";
    scale-x = {
        curve = "cubic-bezier(0.24, 0.64, 0.79, 0.98)";
        duration = 0.15;
        start = 0.95;
        end = 1;
    };
    scale-y = "scale-x";
    shadow-scale-x = "scale-x";
    shadow-scale-y = "scale-y";
    shadow-offset-x = "offset-x";
    shadow-offset-y = "offset-y";
},

# Half Window Size Desktop Switch
{
    triggers = ["workspace-out"];
    offset-y = {
        curve = "cubic-bezier(0.21, 0.02, 0.76, 0.36)";
        duration = 0.15;
        start = "0";
        end = "- window-height / 2";
    };
    shadow-offset-y = "offset-y";
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "window-raw-opacity-before";
        end = "window-raw-opacity";
    };
    blur-opacity = "0";
    shadow-opacity = "opacity";
}, {
    triggers = ["workspace-out-inverse"];
    offset-y = {
        curve = "cubic-bezier(0.21, 0.02, 0.76, 0.36)";
        duration = 0.15;
        start = "0";
        end = "window-height / 2";
    };
    shadow-offset-y = "offset-y";
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "window-raw-opacity-before";
        end = "window-raw-opacity";
    };
    blur-opacity = "0";
    shadow-opacity = "opacity";
}, {
    triggers = ["workspace-in"];
    offset-y = {
        curve = "cubic-bezier(0.24, 0.64, 0.79, 0.98)";
        duration = 0.15;
        start = "window-height / 2";
        end = "0";
    };
    shadow-offset-y = "offset-y";
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "0";
        end = "window-raw-opacity";
    };
    blur-opacity = {
        curve = "linear";
        duration = 0.1;
        delay = 0.15;
        start = "0";
        end = "window-raw-opacity";
    };
    shadow-opacity = "opacity";
}, {
    triggers = ["workspace-in-inverse"];
    offset-y = {
        curve = "cubic-bezier(0.24, 0.64, 0.79, 0.98)";
        duration = 0.15;
        start = "- window-height / 2";
        end = "0";
    };
    shadow-offset-y = "offset-y";
    opacity = {
        curve = "linear";
        duration = 0.15;
        start = "0";
        end = "window-raw-opacity";
    };
    blur-opacity = {
        curve = "linear";
        duration = 0.1;
        delay = 0.15;
        start = "0";
        end = "window-raw-opacity";
    };
    shadow-opacity = "opacity";
}, {
    triggers = [ "geometry" ];
    preset = "geometry-change";
}

# Full Opaque Desktop Switch
#{
#    triggers = ["workspace-out"];
#    offset-y = {
#        timing = "0.15s cubic-bezier(0.21, 0.02, 0.76, 0.36)";
#        start = "0";
#        end = "-window-monitor-height";
#    };
#    shadow-offset-y = "offset-y";
#    opacity = {
#        timing = "0.2s linear";
#        start = "window-raw-opacity-before";
#        end = "window-raw-opacity-before";
#    };
#    blur-opacity = "opacity";
#    shadow-opacity = "opacity";
#}, {
#    triggers = ["workspace-out-inverse"];
#    offset-y = {
#        timing = "0.15s cubic-bezier(0.21, 0.02, 0.76, 0.36)";
#        start = "0";
#        end = "window-monitor-height";
#    };
#    shadow-offset-y = "offset-y";
#    opacity = {
#        timing = "0.2s linear";
#        start = "window-raw-opacity-before";
#        end = "window-raw-opacity-before";
#    };
#    blur-opacity = "opacity";
#    shadow-opacity = "opacity";
#}, {
#    triggers = ["workspace-in"];
#    offset-y = {
#        timing = "0.15s cubic-bezier(0.24, 0.64, 0.79, 0.98)";
#        start = "window-monitor-height";
#        end = "0";
#    };
#    shadow-offset-y = "offset-y";
#    opacity = {
#        timing = "0.2s linear";
#        start = "window-raw-opacity";
#        end = "window-raw-opacity";
#    };
#    blur-opacity = "opacity";
#    shadow-opacity = "opacity";
#}, {
#    triggers = ["workspace-in-inverse"];
#    offset-y = {
#        timing = "0.15s cubic-bezier(0.24, 0.64, 0.79, 0.98)";
#        start = "-window-monitor-height";
#        end = "0";
#    };
#    shadow-offset-y = "offset-y";
#    opacity = {
#        timing = "0.2s linear";
#        start = "window-raw-opacity";
#        end = "window-raw-opacity";
#    };
#    blur-opacity = "opacity";
#    shadow-opacity = "opacity";
#}

)
  '';

}

