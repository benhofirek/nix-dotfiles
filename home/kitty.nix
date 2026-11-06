{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 16.5;
    };

    shellIntegration = {
      mode = "no-rc no-cursor";
      enableZshIntegration = true;
    };

    settings = {
      # needs an absolute path for tmux
      shell = "${pkgs.zsh}/bin/zsh";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      start_as = "normal";
      window_padding_width = 5;
      hide_window_decorations = true;
      background_opacity = 1.0;
      confirm_os_window_close = 0;
      allow_remote_control = false;
      notify_on_cmd_finish = "invisible 20";
      allow_hyperlinks = true;
      paste_actions = "quote-urls-at-prompt";
      enable_audio_bell = false;
      # Makes all the difference on light background
      text_composition_strategy = "legacy";
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 0;
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      # Max number of lines in the output
      scrollback_lines = -1;
    };

    keybindings = {
      "ctrl+i" = "send_text all \\x1f[105;5u";
    };

    autoThemeFiles = {
      light = "AtomOneLight";
      dark = "Broadcast";
      noPreference = "AtomOneLight";
    };
  };

  home.packages = with pkgs; [
    kitty-themes
  ];

  xdg.desktopEntries.nvim-kitty = {
    name = "Neovim (kitty)";
    exec = "${pkgs.kitty}/bin/kitty -e nvim %F";
    mimeType = [
      "text/plain"
      "text/markdown"
      "text/x-shellscript"
      "text/x-python"
      "text/x-csrc"
      "application/json"
      "application/x-yaml"
      "application/toml"
      "application/x-nix"
    ];
    terminal = false;
    categories = [
      "Utility"
      "TextEditor"
    ];
  };

}
