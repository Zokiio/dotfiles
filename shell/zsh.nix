{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };


    # This file contains the configuration for the Zsh shell.
    # It defines various functions and environment variables.

    # The `initExtra` function sets up additional configurations for the shell.
    # It exports the `XDG_DATA_DIRS` environment variable to include the Homebrew share directory.
    # It also defines several utility functions:
    # - `cd`: A wrapper around the built-in `cd` command that also runs `lsd` afterwards.
    # - `mkd`: Creates a directory and changes into it.
    # - `take`: Changes into a temporary directory created by `mktemp`.
    # - `vit`: Opens a new file in Neovim using `mktemp`.
    # - `clone`: Clones a Git repository using the provided URL.
    # - `gclone`: Clones a GitHub repository using the provided repository name.
    # - `bclone`: Clones a specific repository under the `breuerfelix` GitHub account.
    # - `gsm`: Executes a command in each submodule of a Git repository.
    # - `lgc`: Commits changes with a sign-off message.
    # - `lg`: Adds all changes, commits with a sign-off message, and pushes to the remote repository.
    # - `pfusch`: Amends the last commit, forces a push with lease.
    # - `dci`: Inspects a Docker container using `docker-compose`.
    # - `lmr`: Creates a merge request using the current branch name, ticket number, and squad name.
    initExtra = ''
      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share
      export GPG_TTY=$(tty)

      function cd() {
        builtin cd $*
        lsd
      }

      function mkd() {
        mkdir $1
        builtin cd $1
      }

      function take() { builtin cd $(mktemp -d) }
      function vit() { nvim $(mktemp) }

      function clone() { git clone git@$1.git }
      function gclone() { clone github.com:$1 }
      function bclone() { gclone breuerfelix/$1 }
      function gsm() { git submodule foreach "$* || :" }

      function lgc() { git commit --signoff -m "$*" }
      function lg() {
        git add --all
        git commit --signoff -a -m "$*"
        git push
      }

      function pfusch() {
        git add --all
        git commit --amend --no-edit
        git push --force-with-lease
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      function lmr () {
        TICKET=$(git branch --show-current | grep -E -i -o '^[0-9]+')
        SQUAD=$(basename $(dirname $(git rev-parse --show-toplevel)) | tr '[:lower:]' '[:upper:]')
        glab mr create --yes --remove-source-branch --title="$* - $SQUAD-$TICKET"
      }
    '';

    shellAliases = {
      psf = "ps -aux | grep";
      lsf = "ls | grep";

      # nix
      switch = "nix run nix-darwin -- switch --flake ~/.config/nix";
      clean =
        "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents && nix store optimise";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
    ];
    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      pmodules = [ "autosuggestions" "directory" "editor" "git" "terminal" ];
    };
  };
}