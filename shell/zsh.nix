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

    initExtra = ''
      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share

      sudo xcodebuild -license

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

      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      switch = "darwin-rebuild switch --flake ~/.config/nix-darwin";
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