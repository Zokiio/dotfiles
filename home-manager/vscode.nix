{ ... }: {
  programs.visual-studio-code = {
    enable = false;
    userSettings = {
      editor.fontFamily = "'FiraCode Nerd Font', 'JetBrains Mono', monospace";
    }
  }
}