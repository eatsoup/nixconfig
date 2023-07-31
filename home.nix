{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";;
  home.homeDirectory = builtins.getEnv "HOME";;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nodejs
    tmux
    python3
    thefuck
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    ZSH_TMUX_AUTOSTART = "true";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.autojump.enable = true;

  programs.zsh = {
    enable = true;
    sessionVariables = {
    };

    initExtra = ''
      bindkey '^ ' autosuggest-accept
    '';

    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "geoffgarside";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim coc-git coc-highlight coc-pyright coc-rls coc-vetur coc-vimtex coc-yaml coc-html coc-json
      ctrlp
      fzf-vim
      gruvbox
      nerdtree
      rainbow
      vim-nix
      vim-surround
    ];
    extraConfig = ''
      colorscheme gruvbox
      set tabstop=4 autoindent shiftwidth=4 expandtab number
      set smartcase ignorecase
      set incsearch
      set backspace=indent,eol,start
      set listchars=tab:▸\ ,trail:·
      set list
      set mouse=
      set relativenumber

      let mapleader="\<space>"

      map <c-i> :tabn<CR>

      "Easy quotes life
      inoremap "" ""<left>
      inoremap ''' '''<left>
      inoremap () ()<left>
      inoremap {} {}<left>
      inoremap [] []<left>
      inoremap <> <><left>
      inoremap <C-a> <right>
      nmap <Leader>' ysiw'
      nmap <Leader>" ysiw"
      noremap <Leader>/ :Commentary<cr>

      " Coc settings
      inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
      inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
    '';
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Start index of window/pane with 1, because we're humans, not computers
      set -g base-index 1
      setw -g pane-base-index 1

      # Retain pwd
      bind c new-window -c "#{pane_current_path}"
      # Toggle mouse on with ^B m
      bind m set-option mouse\; display-message "Mouse is now #{?mouse,on,off}"

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
    '';
  };
}
