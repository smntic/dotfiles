{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wineWowPackages.waylandFull
  ];
}
