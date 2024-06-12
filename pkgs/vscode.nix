{ config, pkgs, ... }:
# Find plugins @ https://search.nixos.org/packages?channel=23.05&from=0&size=50&sort=relevance&type=packages&query=vscode-extensions
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      shd101wyy.markdown-preview-enhanced
      genieai.chatgpt-vscode
    ];
    keybindings = [
      {
        key = "ctrl+e";
        command = "workbench.action.tasks.runTask";
        args = "openinvim";
      }
    ];
    userSettings = {
      "editor.maxTokenizationLineLength" = 200000;
      "editor.renderWhitespace" = "trailing";
      "genieai.openai.model" = "gpt-3.5-turbo";
      "genieai.promptPrefix.customPrompt1" = "generate a docstring";
      "genieai.promptPrefix.customPrompt1-enabled" = true;
    };
    userTasks = {
      version = "2.0.0";
      tasks = [{
        label = "openinvim";
        type = "shell";
        command = "alacritty";
        args = ["-e" "vim" "+call cursor(\${lineNumber}, 5)" "\${file}"];
        presentation = {
          close = true;
        };
      }];
    };
  };
}
