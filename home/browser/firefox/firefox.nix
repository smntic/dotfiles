{ inputs, ... }:

{
  imports = [
    ./extensions.nix
    ./policies.nix
    ./preferences.nix
    ./profiles.nix
  ];

  programs.firefox = {
    enable = true;
  };

  stylix.targets.firefox.profileNames = [ "default" ];
}
