{ ... }:

{
  imports = [
    ./formats.nix
    ./modules.nix
    ./style.nix
  ];

  programs.waybar.enable = true;
}
