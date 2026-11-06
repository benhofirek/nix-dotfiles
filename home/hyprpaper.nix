{
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;
      ipc = true;

      wallpaper = {
        monitor = "";
        path = "${../wallpapers/stars.jpg}";
        fit_mode = "cover";
      };
    };
  };
}
