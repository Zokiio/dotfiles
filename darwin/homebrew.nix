{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    # will not be uninstalled when removed
    masApps = {
      Xcode = 497799835;
    };
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [ 
      "gpg"
    ];
    casks = [
      # coding
      "intellij-idea"

      # virtualization
      "podman-desktop" # docker desktop

      # communication
      "microsoft-teams"
      "slack"
      "signal"
      "discord"

      "1password" # password manager
      "1password-cli"
      "proton-mail"

      "raycast" # launcher on steroids
      "obsidian" # zettelkasten
      "arc" # mac browser
      "visual-studio-code" # code editor
      "zed" # vim like editor
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/services"
    ];
  };
}
