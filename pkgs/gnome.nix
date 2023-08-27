{ config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "run-or-raise@edvard.cz"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "gsconnect@andyholmes.github.io"
      ];
    };

    "org.gnome.settings-daemon.peripherals.touchpad" = {
      natural-scroll = true;
    };

    "org.gnome.shell.extensions.dash-to-dock" = {
      dock-fixed = true;
      dash-max-icon-size = 24;
      custom-theme-shrink = true;
      extend-height = true;
      height-fraction = 0.9;
      dock-position = "left";
    };

  };

  home.packages = with pkgs; [
    gnomeExtensions.run-or-raise
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
  ];


  home.file.".config/run-or-raise/shortcuts.conf".text = ''
      <Super>t,"alacritty",,
    '';
}
