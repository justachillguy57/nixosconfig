{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [tmux];
  xdg.configFile."tmux/tmux.conf".text = ''

    # status right style
    set-option -g default-shell ${pkgs.zsh}/bin/zsh
    set -g default-terminal "xterm-ghostty"
    set-option -g assume-paste-time 1

    # Smart pane switching with awareness of Vim splits.
    # See: https://github.com/christoomey/vim-tmux-navigator

    # decide whether we're in a Vim process
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

    tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

    if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R
    bind-key -T copy-mode-vi 'C-\' select-pane -l
    bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+

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

    bind-key C-k display-popup -E -w 40% "sesh connect \"$(sesh list --hide-duplicates -i | gum filter --limit 1 --placeholder 'Pick a Sesh' --prompt='⚡')\""

    unbind r
    bind r source-file ~/.config/tmux/tmux.conf
    set -g pane-active-border-style 'fg=magenta,bg=default'
    set -g pane-border-style 'fg=brightblack,bg=default'

    set -g renumber-windows on
    set -g base-index 1

    setw -g mode-keys vi

    set -g prefix C-Space
    set-option -g status-position top
    set -g mouse on

    set -g status-style 'bg=terminal'

    set -g @plugin 'catppuccin/tmux'
    set -g @catppuccin_flavor 'mocha'

    set -g status-left-length 100
    set -g status-left ""
    set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_mantle},bold]  #S },#{#[bg=#{@thm_mantle},fg=#{@thm_green}]  #S }}"
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]│"
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_maroon}]  #{pane_current_command} "
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0},none]│"
    set -ga status-left "#[bg=#{@thm_mantle},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "


    set -g status-right-length 100
    set -g status-right ""
    set -ga status-right ""
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0}, none] "
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0}, none]│"
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_overlay_0}, none]│"
    set -ga status-right "#[bg=#{@thm_mantle},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

    # window style
    set -wg automatic-rename on
    set -g automatic-rename-format ""
    set -g window-status-separator '|'
    set -g window-status-current-format " #{pane_currecnt_command} "
    set -g status-justify 'absolute-centre'
    set -g @catppuccin_window_status_style 'custom'
    set -g @catppuccin_window_flags ""
    set -g @catppuccin_window_number ""
    set -g @catppuccin_window_text "#[fg=#{@thm_rosewater},bg=#{@thm_mantle}] #I#{?#{!=:#{window_name},},: #W ,}"
    set -g @catppuccin_window_current_number ""
    set -g @catppuccin_window_current_text "#[fg=#{@thm_mantle},bg=#{@thm_peach}] #I#{?#{!=:#{window_name},},: #W ,}"

    # Configure Online
    set -g @online_icon "ok"
    set -g @offline_icon "nok"



    set -g @plugin 'tmux-plugins/tpm'

    run '~/.tmux/plugins/tpm/tpm'
  '';
}
