{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # vim keymaps
    defaultKeymap = "emacs";

    history = {
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };

    initContent = builtins.readFile ./config.zsh + ''
      # secrets from sops-nix
      if [ -r "${config.sops.secrets.deepseek_api_key.path}" ]; then
        export DEEPSEEK_API_KEY="$(cat ${config.sops.secrets.deepseek_api_key.path})"
      fi
    '';
  };
}
