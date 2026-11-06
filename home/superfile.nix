{ pkgs, ... }:

{
  programs.superfile = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
      nerdfont = true;
      ignore_missing_fields = true;
      editor = "nvim";
    };

  };

  xdg.desktopEntries.superfile = {
    name = "Superfile";
    comment = "Terminal file manager";
    exec = "${pkgs.kitty}/bin/kitty --title Superfile -e ${pkgs.superfile}/bin/superfile";
    icon = "utilities-terminal";
    terminal = false;
    categories = [
      "System"
      "FileManager"
    ];
  };
}
