{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = { };
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [ 
      "pinentry-mac" # gpg
      "gpg2" # gpg
      "imagemagick" # image processing
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
      "yaak"

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
