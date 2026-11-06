{ pkgs, ... }:

let
  sddm-astronaut-custom = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${../wallpapers/stars.jpg}";
    };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-astronaut-custom ];
  };

  environment.systemPackages = [ sddm-astronaut-custom ];

  # Make startup less noisy
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
  };
}
