{ config, pkgs, ... }:
let
  extraNodePackages = import ./default.nix {};
in
{
  home.packages = [
    extraNodePackages.ai-commit
  ];
}
