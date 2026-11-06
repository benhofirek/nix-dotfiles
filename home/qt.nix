{ pkgs, ... }:

{
  # 1. Enable Qt theme management
  qt = {
    enable = true;

    # Platform theme to use (qtct or kde/gnome)
    platformTheme.name = "qt6ct";

    # Widget style
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };

  # 2. Set environment variables for Hyprland/Wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # Prevent error message loop
    QT_LOGGING_RULES = "qt.qpa.wayland.textinput.warning=false";
    # QT_WAYLAND_DISABLE_TEXT_INPUT = "1";
  };

  # 3. Ensure required Qt packages are installed in user environment
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    qt6.qtwayland
  ];
}
