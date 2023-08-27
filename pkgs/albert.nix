{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    albert
  ];
  home.file.".config/albert.conf".text = ''
  [General]
  hotkey=Meta+R
  showTray=true
  telemetry=false

  [applications]
  enabled=true

  [widgetsboxmodel]
  alwaysOnTop=true
  clearOnHide=false
  clientShadow=true
  displayIcons=true
  displayScrollbar=false
  followCursor=true
  hideOnFocusLoss=true
  historySearch=true
  itemCount=5
  quitOnClose=false
  showCentered=true
  showFallbacksOnEmpty=true
  systemShadow=true
  theme=Adapta
  windowPosition=@Point(603 240)
    '';
}
