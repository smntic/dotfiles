{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wineWow64Packages.waylandFull
  ];
}
