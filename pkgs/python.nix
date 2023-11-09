{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    python311
    python311Packages.ipython
    python311Packages.ipdb
  ];
}
