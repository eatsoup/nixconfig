{ config, pkgs, ... }:
let
  nur = import (builtins.fetchTarball { 
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    # sha256 = "133ncv3sl4rs4zlwrfwm10k19jrzdvmgmjkhx4k9lk6p7g3p999";
  }) { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    firefox
  ];
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
