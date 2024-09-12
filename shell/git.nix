{ ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Joakim Hall";
    userEmail = "joakim.hall@zottik.com";
    signing = {
      key = null; # gnupg decides by mail
      signByDefault = true;
    };
    includes = [
      {
        condition = "gitdir:~/code/devoteam/";
        contents.user.email = "joakim.hall@devoteam.com";
      }
      {
        condition = "gitdir:~/code/inter/";
        contents.user.email = "joakim.hall@inter.ikea.com";
      }
    ];
    hooks = { prepare-commit-msg = ./rtl-hook.sh; };
    aliases = {
      cm = "commit";
      ca = "commit --amend --no-edit";
      co = "checkout";
      cp = "cherry-pick";

      di = "diff";
      dh = "diff HEAD";

      pu = "pull";
      ps = "push";
      pf = "push --force-with-lease";

      st = "status -sb";
      fe = "fetch";
      gr = "grep -in";

      ri = "rebase -i";
      rc = "rebase --continue";
    };
    ignores = [
      # ide
      ".idea"
      ".vs"
      ".vsc"
      ".vscode"
      # npm
      "node_modules"
      "npm-debug.log"
      # python
      "__pycache__"
      "*.pyc"

      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
      ".DS_Store" # mac
      "kls_database.db" # kotlin lsp
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      fetch = { prune = true; };
      push.autoSetupRemote = true;
      delta = { line-numbers = true; };
    };
  };
}
