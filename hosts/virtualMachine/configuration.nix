{
  inputs,
  username,
  hostname,
  lib,
  ...
}:
{
  imports = [
    ../laptop/configuration.nix # reuse the whole laptop system
    inputs.home-manager.nixosModules.home-manager
  ];

  # home-manager as a NixOS module, so the VM boots with your home applied
  home-manager = {
    extraSpecialArgs = { inherit inputs hostname username; };
    users.${username}.imports = [
      (inputs.import-tree ../../home)
    ];
  };

  services.displayManager.autoLogin = {
    enable = lib.mkForce true;
  };

  virtualisation.vmVariant = {
    services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];

    services.openssh.enable = true;
    services.openssh.settings.PasswordAuthentication = true;

    virtualisation = {
      memorySize = 4096;
      cores = 4;
      qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
      forwardPorts = [
        {
          from = "host";
          host.port = 2222;
          guest.port = 22;
        }
      ];
    };
  };
}
