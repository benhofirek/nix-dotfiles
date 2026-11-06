{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/dotfiles";
    homeFlake = "${config.home.homeDirectory}/dotfiles";
  };
}
