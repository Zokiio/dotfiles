{ ... }: {
  programs.vscode = {
    enable = true;
    userSettings = {
      editor.fontFamily = "'FiraCode Nerd Font', 'JetBrains Mono', monospace";
    };
  };
}