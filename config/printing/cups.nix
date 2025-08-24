{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Printing
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    # Enable autodiscovery of network printers
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
