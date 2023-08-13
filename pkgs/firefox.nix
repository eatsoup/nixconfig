{ config, pkgs, ... }:
let
  nur = import (builtins.fetchTarball { 
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "11v4ba0cjvfg7f1fk1x7azjrdhkxxr867bxqy7mss1bpsyxym06m";
  }) { inherit pkgs; };
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      extensions = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
