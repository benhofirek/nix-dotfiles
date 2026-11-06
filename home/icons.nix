{ pkgs, ... }:

{
  # 1. Install Icon Theme Packages
  home.packages = with pkgs; [
    papirus-icon-theme
    adwaita-icon-theme
    colloid-icon-theme
  ];

  # 3. Configure GTK Apps (GTK2, GTK3, GTK4)
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark"; # Options: "Papirus", "Papirus-Dark", "Papirus-Light", "MoreWaita", "Colloid-dark", etc.
      package = pkgs.papirus-icon-theme;
    };

    # Optional: Match cursor & font for a unified look
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
