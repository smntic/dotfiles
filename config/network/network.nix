{ ... }:

{
  networking = {
    networkmanager.enable = true;
    hostName = "x13";
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
