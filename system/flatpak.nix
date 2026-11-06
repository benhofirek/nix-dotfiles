{
  services.flatpak = {
    enable = true;
    packages = [
      # "io.beekeeperstudio.Studio"
      # "com.jetbrains.DataGrip"
    ];
    update.onActivation = true;
  };
}
