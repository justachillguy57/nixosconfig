{pkgs, config, ...}: 
{
    home.packages = with pkgs; [ tmux ];
    xdg.configFile."tmux/tmux.conf".text = '' 
set-option -g default-shell ${pkgs.zsh}/bin/zsh
set -g default-terminal 'tmux-256color'

bind-key h select-pane -L 
bind-key j select-pane -D 
bind-key k select-pane -U
bind-key l select-pane -R

unbind '"'
bind '"' split-window -h -c "#{pane_current_path}"
unbind % 
bind % split-window -v -c "#{pane_current_path}"
unbind i 
bind-key -r i run-shell ~/scripts/cht.sh


unbind r 
bind r source-file ~/.config/tmux/tmux.conf
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'

set -g renumber-windows on
set -g base-index 1

setw -g mode-keys vi
set -g @catppuccin_window_left_separator ""
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_default_fill "number"
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
set -g @catppuccin_status_modules_right "directory date_time"
set -g @catppuccin_status_modules_left "session"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator " "
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_connect_separator "no"
set -g @catppuccin_directory_text "#{b:pane_current_path}"
set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
set -g @catppuccin_date_time_text "%H:%M"


set -g prefix C-Space
set-option -g status-position top 
set -g mouse on

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'omerxx/catppuccin-tmux'

run '~/.tmux/plugins/tpm/tpm'
'';
}
