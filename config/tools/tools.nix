{ ... }:

{
  imports = [
    ./nix_ld.nix
    ./ollama.nix
  ];

  services.tailscale = {
    enable = true;
  };
}
