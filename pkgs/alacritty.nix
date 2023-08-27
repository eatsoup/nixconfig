{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = "zsh";
      shell.args = [
        "-l"
        "-c"
        "tmux attach || tmux"
      ];
      window = {
        opacity = 0.95;
        dimensions = {
          columns = 133;
          lines = 40;
        };
        # decorations = "none";
        padding = {
          x = 2;
          y = 2;
        };
      };
    };
  };
}
