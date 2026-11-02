{
  pkgs,
  username,
  hostname,
  ...
}:
{
  system.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  boot.kernelModules = [
    "i2c-dev"
  ];

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;

  time.timeZone = "Europe/Prague";

  services.xserver.xkb = {
    layout = "us";
    variant = ""; # Leave empty for standard US layout
  };

  nix = {
    settings = {
      auto-optimise-store = true; # Hard-link identical store files
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly"; # Runs weekly (uses systemd timer)
      options = "--delete-older-than 14d"; # Keeps generations from the last 14 days
    };
  };

  # Set keyboard layout for Console / TTY
  console.keyMap = "us";

  users.users.${username} = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "i2c"
    ];

    shell = pkgs.bashInteractive;

    initialPassword = username;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite

    # For initial secret scaffolding
    sops
    age
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.displayManager.defaultSession = "hyprland-uwsm";
  services.displayManager.autoLogin = {
    enable = false;
    user = username;
  };

  # Screensharing, notifications
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;

    settings = {
      General = {
        # Lets headphones reconnect on their own, plus battery info
        Experimental = true;
      };
      Policy = {
        AutoEnable = true;
        ReconnectAttempts = 7;
        ReconnectIntervals = "1,2,4,8,16,32,64";
      };
    };
  };
  hardware.i2c.enable = true;
  hardware.graphics.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
