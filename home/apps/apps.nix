{ pkgs, ... }:

{
  imports = [
    ./go/go.nix
  ];

  home.packages = [
    pkgs.audacity
    pkgs.blender
    pkgs.gimp
    pkgs.godot_4-mono
    pkgs.kdePackages.kdenlive
    pkgs.kicad
    pkgs.krita
    pkgs.libreoffice
    pkgs.obs-studio
    pkgs.octaveFull
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.wireshark
    pkgs.xournalpp
    pkgs.anki
  ];
}
