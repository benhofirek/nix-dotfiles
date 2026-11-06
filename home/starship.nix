{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    presets = [ "nerd-font-symbols" ];

    settings = {
      add_newline = true;
      command_timeout = 300;
      scan_timeout = 30;
    };
  };
}
