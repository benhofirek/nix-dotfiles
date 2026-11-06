{ config, ... }:

# Hyprland enabled in system config

# To allow home-manager to take care of other hyprland utilities like hyprpaper
# we need not to replace whole hypr directory, but just to symlink hyprland.lua
{
  wayland.windowManager.hyprland = {
    # Leave installation and session handling on NixOS
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
  };

  xdg.configFile = {
    "hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink ./hyprland.lua;

    "hypr/config".source = config.lib.file.mkOutOfStoreSymlink ./config;

    # Ensure xdg-desktop-portal-hyprland has its config file set up:
    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
      }
    '';
  };

}
