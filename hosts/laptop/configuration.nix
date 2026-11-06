{
  config,
  ...
}:
{
  # Cpu configuration
  imports = [
    ./cpu-management.nix
    ./fan-management.nix
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false; # only valid with offload mode
    open = true; # fine for Ada (RTX 40xx)
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
