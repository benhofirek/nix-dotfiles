{
  modulesPath,
  inputs,
  pkgs,
  hostname,
  username,
  ...
}:
{
  imports = [
    # Use the official NixOS minimal console installer profile
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
  ];

  networking.hostName = hostname;

  # Optional: If you want networking out-of-the-box via NetworkManager
  networking.networkmanager.enable = true;

  # Set a default password for the root user so you can log in on the live ISO
  users.users.root.initialPassword = username;

  # Optional: Add any essential utilities you might want handy on the live USB
  # (git, neovim, curl, etc.)
  environment.systemPackages = with pkgs; [
    git
    neovim
    tmux
    htop
    kitty
  ];
}
