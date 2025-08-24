{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wineWowPackages.waylandFull

    pkgs.virt-manager
    pkgs.qemu
    pkgs.spice
    pkgs.spice-gtk
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };

    spiceUSBRedirection.enable = true;
  };
}
