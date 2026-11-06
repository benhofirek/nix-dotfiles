{ pkgs, ... }:

{
  # https://wiki.hypr.land/hypr-ecosystem/user/hyprcursor/
  environment.systemPackages = [
    pkgs.rose-pine-hyprcursor
  ];
}
