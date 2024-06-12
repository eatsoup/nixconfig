{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

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
    fzf
    git
    gnumake
    iconv
    jq
    kubectl
    nodejs
    psmisc
    thefuck
    xclip
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    ZSH_TMUX_AUTOSTART = "true";
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "Luuk Kemp";
    userEmail = "l.kemp@fullstaq.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.autojump.enable = true;

  imports = [
    # Packages
    ./pkgs/alacritty.nix
    ./pkgs/albert.nix
    ./pkgs/direnv.nix
    ./pkgs/firefox.nix
    ./pkgs/gnome.nix
    ./pkgs/neovim.nix
    ./pkgs/python.nix
    ./pkgs/slack.nix
    ./pkgs/teams.nix
    ./pkgs/tmux.nix
    ./pkgs/vscode.nix
    ./pkgs/zsh.nix
    ./pkgs/steam.nix
    ./node/node.nix

    # Project / Client specfic settings and packages
    ./projects/jumbo.nix
  ];
}
