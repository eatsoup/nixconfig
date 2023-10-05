{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    openconnect
    python310Packages.keyring
    vpn-slice
    teams-for-linux
    kubelogin-oidc
    git-crypt
    gnupg
    dbeaver
    mongodb-compass
  ];
}
