{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "zsh";
      shell.args = [
        "-l"
        "-c"
        "tmux attach || tmux"
      ];
      window.opacity = 0.95;
      window = {
        decorations = "none";
      };
    };
  };
}
