{ ... }:

{
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      backgroundColor = "#000000";
      splashImage = ./backgrounds/background.png;
      splashMode = "normal";
    };
    efi.canTouchEfiVariables = true;
  };

  # unfortunately, this seems required, for now. maybe try to remove later.
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
  ];
}
