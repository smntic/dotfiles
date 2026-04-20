{ pkgs, ... }:

let
  sabaki = pkgs.callPackage ./sabaki.nix {};
in
{
  imports = [
    ./katago.nix
  ];

  home.packages = [
    sabaki
  ];
}
