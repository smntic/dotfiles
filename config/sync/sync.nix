{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gocryptfs
  ];

  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "simon";
      dataDir = "/home/simon/notes";
      configDir = "/home/simon/.config/syncthing";
    };
  };
}
