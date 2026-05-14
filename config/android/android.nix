{ pkgs, ... }:

{
  imports = [
    ./kdeconnect.nix
  ];

  environment.systemPackages = with pkgs; [
    scrcpy
    android-tools
  ];
}
