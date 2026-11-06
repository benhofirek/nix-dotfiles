{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        font = "monospace:size=11";
        width = 40;
        line-height = 24;
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        border = "89b4faff";
      };
      border = {
        width = 2;
        radius = 10;
      };
    };
  };

}
