{ pkgs, ... }: {
  imports = [ ./homebrew.nix ];

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    # This makes TouchId available in tmux
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh # nix-darwin: security.pam.enableSudoTouchIdAuth
      auth       sufficient     pam_tid.so # nix-darwin: security.pam.enableSudoTouchIdAuth
    '';
  };

  programs = { zsh.enable = true; };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ 
        "JetBrainsMono"
        "FiraCode" 
      ]; })
      sketchybar-app-font
    ];
  };

  security = { pam.enableSudoTouchIdAuth = true; };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 4.0;
      spaces.spans-displays = false;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "bottom";
        dashboard-in-overlay = true;
        tilesize = 30;
        launchanim = false;
        mru-spaces = false;
        show-recents = false;
        show-process-indicators = false;
        static-only = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf"; # current folder
        QuitMenuItem = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 2.0;
      };
    };
  };
}