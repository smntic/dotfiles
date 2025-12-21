{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    spice
    spice-gtk
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };
}
