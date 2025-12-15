{ pkgs, ... }:

{
  home.packages = [
    pkgs.krita
    pkgs.vlc
    pkgs.obs-studio
    pkgs.blender
    pkgs.godot_4-mono
    pkgs.octaveFull
    pkgs.audacity
    pkgs.kicad
  ];
}
