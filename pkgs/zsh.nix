{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      TERM = "xterm-256color";
    };

    initExtra = ''
      bindkey '^ ' autosuggest-accept
      eval "$(direnv hook zsh)"
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
}
