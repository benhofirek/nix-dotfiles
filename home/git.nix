{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Benedikt Hofirek";
        email = "benedikthofirek@gmail.com";
      };

      init = {
        defaultBranch = "main";
      };

      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
        preloadindex = true;
      };

      column = {
        ui = "auto";
      };

      branch = {
        sort = "-committerdate";
      };

      tag = {
        sort = "version:refname";
      };

      pull = {
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
        default = "simple";
      };

      fetch = {
        prune = true;
        pruneTags = true;
      };

      diff = {
        algorithm = "histogram";
        renames = true;
      };

      help = {
        autocorrect = 10;
      };

      merge = {
        conflictstyle = "zdiff3";
      };

      rebase = {
        autoStash = true;
        autoSquash = true;
      };
    };
  };
}
