{ config, pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "o";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";
    # lib.strings.fileContents reads the content of a file 
    # and returns it as a string
    extraConfig = lib.strings.fileContents ./tmux.conf;
  };
}