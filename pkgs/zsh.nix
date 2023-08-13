{ config, pkgs, ... }:
{
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
}
