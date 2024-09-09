{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./zellij.nix
  ];

  home = {
    packages = with pkgs; [
      neovim

      # net tools
      bind
      nmap
      inetutils

      # core
      openssl
      wget
      curl
      fd
      ripgrep # fast search

      grc # colored log output
      gitAndTools.delta # pretty diff tool
      sshfs # mount folders via ssh
      gh # github cli tool
      httpie # awesome alternative to curl
      corepack # node wrappers
      gnupg

      # gnu binaries
      coreutils-full # multiple tools

      # cloud
      google-cloud-sdk
      awscli2
      
      ## node
      deno # node runtime
      nodejs

      ## golang
      golangci-lint
    ];

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      del = "rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";

      # overrides
      cat = "bat";
      top = "btop";
      htop = "btop";
      ping = "gping";
      diff = "delta";
      ssh = "TERM=screen ssh";
      j = "z";
      ji = "zi";

      # programs
      g = "git";
      k = "kubectl";
      d = "docker";
      kca = "kubectl apply -f";
      dc = "docker-compose";
      tf = "terraform";
      cht = "cht.sh"; # terminal cheat sheet
    };

    sessionPath = [
      "$HOME/go/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      GO111MODULE = "on";
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
      PULUMI_CONFIG_PASSPHRASE = "";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    nnn.enable = true; # file browser
    btop.enable = true; # htop alternative
    nushell.enable = true; # zsh alternative
    broot.enable = true; # browser big folders

    # sqlite browser history
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        inline_height = 20;
        style = "compact";
      };
    };

    # pretty prompt
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };

    # pretty ls
    lsd = {
      enable = true;
      enableAliases = true;
    };

    go = {
      enable = true;
      package = pkgs.go_1_23;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [ ];
    };
  };
}