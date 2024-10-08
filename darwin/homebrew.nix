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
      "temurin@17"

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
      "yaak" # api testing
      "postman" # api testing

      "raycast" # launcher on steroids
      "obsidian" # zettelkasten

      "visual-studio-code" # code editor
      "zed" # vim like editor

      # browsers
      "google-chrome"
      "arc"
      "firefox@developer-edition"
      "zen-browser"
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/services"
    ];
  };
}
