{ config, ... }:

{
  programs.tmux = {
    enable = true;

    shell = config.programs.kitty.settings.shell;

    terminal = "tmux-256color";
    # Scrollback history
    historyLimit = 100000;
    # remove delay for exiting insert mode with ESC in Neovim
    escapeTime = 0;
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    aggressiveResize = false;
    focusEvents = true;

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
