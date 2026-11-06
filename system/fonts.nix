{ pkgs, ... }:

{
  # Configuration options are not available inside home-manager
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.caskaydia-mono
      inter
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font Mono" ];
        sansSerif = [ "Inter" ];
        serif = [ "Liberation Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "none";
        lcdfilter = "default";
      };
    };
  };
}
