{ pkgs, ... }:

{
  imports = [
    ./kdeconnect.nix
  ];

  environment.systemPackages = [ pkgs.scrcpy ];
}
