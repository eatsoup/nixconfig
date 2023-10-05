{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Set terminal color
      set -g default-terminal xterm-256color

      # Start index of window/pane with 1, because we're humans, not computers
      set -g base-index 1
      setw -g pane-base-index 1

      # Retain pwd
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Toggle mouse on with ^B m
      bind m set-option mouse\; display-message "Mouse is now #{?mouse,on,off}"

      # Disable Esc time
      set -s escape-time 0

      # Set active tab color
      set-window-option -g window-status-current-style bg=blue

      # Keyboard shortcuts
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n M-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind-key -n M-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind-key -n M-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind-key -n M-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
      # bind-key -n M-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
      bind-key -T copy-mode-vi M-h select-pane -L
      bind-key -T copy-mode-vi M-j select-pane -D
      bind-key -T copy-mode-vi M-k select-pane -U
      bind-key -T copy-mode-vi M-l select-pane -R
      # bind-key -T copy-mode-vi M-\ select-pane -l

      # Enable mouse support
      set -g mouse on

      # Selection with mouse should copy to clipboard right away, in addition to the default action.
      unbind -n -Tcopy-mode-vi MouseDragEnd1Pane
      bind -Tcopy-mode-vi MouseDragEnd1Pane send -X copy-selection-and-cancel\; run "tmux save-buffer - | xclip -i -sel clipboard > /dev/null"

      # Double LMB Select & Copy (Word)
      bind-key -T copy-mode-vi DoubleClick1Pane select-pane \; send-keys -X select-word \; send-keys -X copy-pipe "xclip -in -sel primary"
      bind-key -n DoubleClick1Pane select-pane \; copy-mode -M \; send-keys -X select-word \; send-keys -X copy-pipe "xclip -in -sel primary"

      # RMB for paste
      unbind-key MouseDown3Pane
      bind-key -n MouseDown3Pane run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

      # Set window title to current path
      set-option -g status-interval 2
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      # Enable vim mode
      set-window-option -g mode-keys vi
    '';
  };
}
