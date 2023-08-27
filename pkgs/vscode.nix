{ config, pkgs, ... }:
# Find plugins @ https://search.nixos.org/packages?channel=23.05&from=0&size=50&sort=relevance&type=packages&query=vscode-extensions
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      shd101wyy.markdown-preview-enhanced
      genieai.chatgpt-vscode
    ];
  };
}
